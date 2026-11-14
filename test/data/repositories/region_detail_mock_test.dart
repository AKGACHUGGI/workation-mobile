import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/models/search_intent.dart';
import 'package:workation_mobile/data/repositories/mock_assets.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';
import 'package:workation_mobile/data/repositories/search_repository.dart';
import 'package:workation_mobile/features/region/region_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final repo = MockRegionRepository(
    MockAssets(rootBundle, delay: Duration.zero),
  );

  test('고성군 상세 mock 은 웹 W-03 픽스처와 같은 값이다', () async {
    final d = await repo.detail('51820', '2025-10');

    expect(d.name, '고성군');
    expect(d.month, '2025-10');
    expect(d.seasonType, SeasonType.secondHalfRise);
    expect(d.photos, hasLength(5));
    expect(d.photos.first.url, 'assets/mock-photos/51820.jpg');
    expect(d.stats.weekendRatio, 1.05);
    expect(d.months.map((m) => m.crowd), [
      53, 41, 41, 46, 60, 60, 80, 100, 52, 68, 52, 47, //
    ]);
    expect(d.bestMonths, [2, 3]);
    expect(d.avoidMonths, [7, 8]);
    expect(d.peerOffpeakMonths, [12, 2]);
    expect(d.dongs.map((x) => x.name), ['토성면', '죽왕면', '거진읍', '간성읍', '현내면']);
    expect(d.dongs.first.kind, DongKind.tourist);
    expect(d.excludedDongs.single.name, '수동면');
  });

  test('인기 지역 12곳 모두 상세 mock 이 있고 12개월 막대를 갖는다', () async {
    final popular = await repo.popular('2025-10');

    for (final r in popular.items) {
      final d = await repo.detail(r.id, '2025-12');
      expect(d.name, r.name, reason: r.id);
      expect(d.month, '2025-12', reason: r.id);
      expect(d.months, hasLength(12), reason: r.id);
      expect(d.dongs, isNotEmpty, reason: r.id);
    }
  });

  test('mock 에 없는 지역은 NotFoundException 이다', () {
    expect(repo.detail('99999', '2025-10'), throwsA(isA<NotFoundException>()));
  });

  test('고성군은 조용한 곳 프리셋에서 50점 · 12곳 중 3위 · S 다 (Figma M-03)', () async {
    final popular = await repo.popular('2025-10');

    final rank = rankRegion(popular.items, '51820', Weights.quietPreset)!;

    expect(rank.score, 50);
    expect(rank.label, '12곳 중 3위 · S');
    expect(rankRegion(popular.items, '99999', Weights.quietPreset), isNull);
  });

  group('mockParseIntent', () {
    test('Figma 예시 문장에서 월 · 분위기 · 지형 · 기간 · 또래를 읽는다', () {
      final intent = mockParseIntent(
        '10월에 조용한 바닷가에서 한 달 정도 일하고 싶어요. 또래가 좀 있었으면 좋겠어요',
      );

      expect(intent.month, '2025-10');
      expect(intent.preset, PresetKey.quiet);
      expect(intent.terrain, [Terrain.coast]);
      expect(intent.stay, StayLength.month);
      expect(intent.peer, isTrue);
      expect(intent.tags.map((t) => t.label), [
        '10월',
        '조용한 곳',
        '해안',
        '한 달 살기',
        '또래 20~40대',
      ]);
    });

    test('활기 · 도시, 산간 · 2주도 읽는다', () {
      final lively = mockParseIntent('또래가 많고 밤에도 활기찬 도시');
      expect(lively.preset, PresetKey.lively);
      expect(lively.terrain, [Terrain.city]);

      final mountain = mockParseIntent('단풍철 산간 마을에서 2주');
      expect(mountain.terrain, [Terrain.mountain]);
      expect(mountain.stay, StayLength.twoWeeks);
      expect(mountain.month, isNull);
    });

    test('읽을 낱말이 없으면 조건이 비어 있다', () {
      expect(mockParseIntent('아무 데나').isEmpty, isTrue);
      expect(mockParseIntent('13월').isEmpty, isTrue);
    });
  });

  test('조건 태그를 빼면 그 축의 값도 지워진다', () {
    final intent = mockParseIntent('10월 조용한 바다와 도시');
    final coast = intent.tags.firstWhere((t) => t.label == '해안');
    final city = intent.tags.firstWhere((t) => t.label == '도시');

    // 같은 축(지형)의 태그가 남아 있으면 값은 그대로 둡니다.
    final one = intent.without(coast);
    expect(one.tags, isNot(contains(coast)));
    expect(one.terrain, isNotNull);

    final none = one.without(city);
    expect(none.terrain, isNull);
    expect(none.month, '2025-10');

    final noMonth = none.without(
      const IntentTag(axis: IntentAxis.month, label: '10월'),
    );
    expect(noMonth.month, isNull);
    expect(noMonth.tags.map((t) => t.label), ['조용한 곳']);
  });

  test('응답 JSON 의 two_weeks · 축 이름을 읽는다', () {
    final intent = SearchIntent.fromJson(const {
      'month': '2025-11',
      'stay': 'two_weeks',
      'terrain': ['coast'],
      'tags': [
        {'axis': 'month', 'label': '11월'},
        {'axis': 'stay', 'label': '2주'},
      ],
    });

    expect(intent.stay, StayLength.twoWeeks);
    expect(intent.terrain, [Terrain.coast]);
    expect(intent.tags.last.axis, IntentAxis.stay);
  });
}
