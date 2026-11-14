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

  test('강릉시 핀 mock 은 21동이고 유형 4종 점수가 있다', () async {
    final res = await MockExploreRepository(assets).pins('51150');

    expect(res.dongs, hasLength(21));
    final jumunjin = res.dongs.firstWhere((d) => d.id == '5115025000');
    expect(jumunjin.topType, WorkationTypes.longStay);
    expect(jumunjin.coastal, isTrue);
    expect(jumunjin.grades.evening, Grade.a);
    expect(jumunjin.scoreOf(WorkationTypes.local), 60);
    for (final d in res.dongs) {
      expect(d.types, hasLength(4), reason: d.name);
      expect(d.types!.first.name, d.topType, reason: d.name);
    }
  });

  test('핀에 types 가 없으면 1위 유형 점수만 안다', () {
    const pin = PinDong(id: '1', name: '가동', topType: '몰입형', topScore: 63);

    expect(pin.scoreOf('몰입형'), 63);
    expect(pin.scoreOf('장기체류형'), isNull);
  });

  test('주문진읍 동 요약 mock 은 유형 4개 · 브리핑 3줄이다', () async {
    final dong = await MockExploreRepository(assets).dong('5115025000');

    expect(dong.name, '주문진읍');
    expect(dong.sigungu.name, '강릉시');
    expect(dong.coastKm, 0);
    expect(dong.types.map((t) => t.score), [61, 60, 50, 36]);
    expect(dong.briefing, hasLength(3));
  });

  test('mock 에 없는 시군구 · 동은 NotFoundException 이다', () async {
    final repo = MockExploreRepository(assets);

    expect(repo.pins('99999'), throwsA(isA<NotFoundException>()));
    expect(repo.dong('0000000000'), throwsA(isA<NotFoundException>()));
  });
}
