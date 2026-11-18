import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/repositories/explore_repository.dart';
import 'package:workation_mobile/data/repositories/mock_assets.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final assets = MockAssets(rootBundle, delay: Duration.zero);

  test('인기 지역 mock 은 12곳이고 요청한 달을 그대로 돌려준다', () async {
    final res = await MockRegionRepository(assets).popular('2025-10');

    expect(res.month, '2025-10');
    expect(res.items, hasLength(12));
    final goseong = res.items.firstWhere((r) => r.id == '51820');
    expect(goseong.name, '고성군');
    expect(goseong.terrain, [Terrain.coast]);
    expect(goseong.scores[MetricKey.overnight], 76);
    expect(goseong.favoriteCount, 1284);
  });

  test('강릉시 핀 mock 은 21동이고 유형 3종 점수가 있다', () async {
    final res = await MockExploreRepository(assets).pins('51150');

    expect(res.dongs, hasLength(21));
    final jumunjin = res.dongs.firstWhere((d) => d.id == '5115025000');
    expect(jumunjin.topType, WorkationTypes.local);
    expect(jumunjin.topScore, 60);
    expect(jumunjin.coastal, isTrue);
    expect(jumunjin.grades.evening, Grade.a);
    expect(jumunjin.scoreOf(WorkationTypes.networking), 50);
    for (final d in res.dongs) {
      expect(d.types, hasLength(3), reason: d.name);
      final top = d.types!.first;
      if (d.topType == null) {
        // 1위가 대표 유형 기준 미만이면 topType 은 비고 types 는 그대로 온다
        expect(top.score, lessThan(WorkationTypes.min), reason: d.name);
      } else {
        expect((top.name, top.score), (d.topType, d.topScore), reason: d.name);
      }
    }
    expect(res.dongs.where((d) => d.topType == null), hasLength(5));
  });

  test('핀에 types 가 없으면 1위 유형 점수만 안다', () {
    const pin = PinDong(id: '1', name: '가동', topType: '몰입형', topScore: 63);

    expect(pin.scoreOf('몰입형'), 63);
    expect(pin.scoreOf('로컬살이형'), isNull);
  });

  test('주문진읍 동 요약 mock 은 유형 3개 · 브리핑 3줄이다', () async {
    final dong = await MockExploreRepository(assets).dong('5115025000');

    expect(dong.name, '주문진읍');
    expect(dong.sigungu.name, '강릉시');
    expect(dong.coastKm, 0);
    expect(dong.types.map((t) => t.score), [60, 50, 36]);
    expect(dong.briefing, hasLength(3));
  });

  test('mock 에 없는 시군구 · 동은 NotFoundException 이다', () async {
    final repo = MockExploreRepository(assets);

    expect(repo.pins('99999'), throwsA(isA<NotFoundException>()));
    expect(repo.dong('0000000000'), throwsA(isA<NotFoundException>()));
  });
}
