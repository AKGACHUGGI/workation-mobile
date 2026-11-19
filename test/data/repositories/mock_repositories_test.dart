import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/explore_repository.dart';
import 'package:workation_mobile/data/repositories/mock_assets.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';

// assets/mock 의 지역 · 지도 응답은 실서버 응답을 받아 둔 것이라(`tool/refresh_mock.sh`)
// 값은 다시 받을 때마다 바뀝니다. 여기서는 값이 아니라 지켜져야 하는 규칙만 봅니다.
// 정확한 값은 test/fixtures 로 견줍니다.

Map<String, dynamic> _fixture(String file) =>
    jsonDecode(File('test/fixtures/$file').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final assets = MockAssets(rootBundle, delay: Duration.zero);
  final regions = MockRegionRepository(assets);
  final explore = MockExploreRepository(assets);

  test('인기 지역 mock 은 12곳이고 요청한 달을 그대로 돌려준다', () async {
    final res = await regions.popular('2025-10');

    expect(res.month, '2025-10');
    expect(res.items, hasLength(12));
    expect({for (final r in res.items) r.id}, hasLength(12));
    // 지도 경계(assets/geo/sigungu.json)와 같은 시군구여야 ⓪ 에서 색이 칠해집니다.
    final geo = jsonDecode(
      File('assets/geo/sigungu.json').readAsStringSync(),
    ) as Map<String, dynamic>;
    final geoIds = {
      for (final f in geo['features'] as List)
        ((f as Map)['properties'] as Map)['id'] as String,
    };
    expect({for (final r in res.items) r.id}, geoIds);
    for (final r in res.items) {
      expect(r.name, isNotEmpty, reason: r.id);
      for (final k in MetricKey.values) {
        expect(r.scores[k], inInclusiveRange(0, 100), reason: '${r.id} $k');
      }
    }
  });

  test('시군구 12곳 모두 핀이 있고, 핀은 그 지역의 행정동과 같다', () async {
    final popular = await regions.popular('2025-12');
    var count = 0;

    for (final r in popular.items) {
      final detail = await regions.detail(r.id, '2025-12');
      final pins = await explore.pins(r.id);
      expect(
        {for (final d in pins.dongs) d.id},
        {for (final d in detail.dongs) d.id},
        reason: r.name,
      );
      for (final d in pins.dongs) {
        count++;
        expect(d.center, isNotNull, reason: d.name);
        expect(d.types, hasLength(3), reason: d.name);
        final top = d.types!.first;
        if (d.topType == null) {
          // 1위가 대표 유형 기준 미만이면 topType 은 비고 types 는 그대로 온다
          expect(top.score, lessThan(WorkationTypes.min), reason: d.name);
        } else {
          expect(
            (top.name, top.score),
            (d.topType, d.topScore),
            reason: d.name,
          );
        }
      }
    }
    expect(count, 203);
  });

  test('행정동 203곳 모두 동 요약이 있다(유형 3개 · 브리핑)', () async {
    var count = 0;
    for (final f in Directory('assets/mock/regions').listSync()) {
      final region = RegionDetail.fromJson(
        jsonDecode((f as File).readAsStringSync()) as Map<String, dynamic>,
      );
      for (final d in region.dongs) {
        final dong = await explore.dong(d.id);
        count++;
        expect(dong.name, d.name, reason: d.id);
        expect(dong.sigungu.id, region.id, reason: d.id);
        expect(dong.types, hasLength(3), reason: d.id);
        expect(dong.briefing, isNotEmpty, reason: d.id);
      }
    }
    expect(count, 203);
  });

  test('mock 에 없는 시군구 · 동은 NotFoundException 이다', () async {
    expect(explore.pins('99999'), throwsA(isA<NotFoundException>()));
    expect(explore.dong('0000000000'), throwsA(isA<NotFoundException>()));
  });

  group('고정 응답(test/fixtures)', () {
    test('인기 지역: 고성군', () {
      final res = PopularResponse.fromJson(_fixture('regions_popular.json'));

      final goseong = res.items.firstWhere((r) => r.id == '51820');
      expect(goseong.name, '고성군');
      expect(goseong.terrain, [Terrain.coast]);
      expect(goseong.scores[MetricKey.overnight], 76);
      expect(goseong.favoriteCount, 1284);
    });

    test('강릉시 핀 21동: 유형 3종 점수', () {
      final res = PinsResponse.fromJson(_fixture('explore/pins_51150.json'));

      expect(res.dongs, hasLength(21));
      final jumunjin = res.dongs.firstWhere((d) => d.id == '5115025000');
      expect(jumunjin.topType, WorkationTypes.local);
      expect(jumunjin.topScore, 60);
      expect(jumunjin.coastal, isTrue);
      expect(jumunjin.grades.evening, Grade.a);
      expect(jumunjin.scoreOf(WorkationTypes.networking), 50);
      expect(res.dongs.where((d) => d.topType == null), hasLength(5));
    });

    test('주문진읍 동 요약: 유형 3개 · 브리핑 3줄', () {
      final dong = ExploreDong.fromJson(
        _fixture('explore/dong_5115025000.json'),
      );

      expect(dong.name, '주문진읍');
      expect(dong.sigungu.name, '강릉시');
      expect(dong.coastKm, 0);
      expect(dong.types.map((t) => t.score), [60, 50, 36]);
      expect(dong.briefing, hasLength(3));
    });
  });

  test('핀에 types 가 없으면 1위 유형 점수만 안다', () {
    const pin = PinDong(id: '1', name: '가동', topType: '몰입형', topScore: 63);

    expect(pin.scoreOf('몰입형'), 63);
    expect(pin.scoreOf('로컬살이형'), isNull);
  });
}
