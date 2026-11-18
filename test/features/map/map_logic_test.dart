import 'dart:convert';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/models/geo_area.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/features/map/map_logic.dart';
import 'package:workation_mobile/features/map/map_projection.dart';

PinDong pin(
  String id,
  String name, {
  Map<String, double>? scores,
  String? topType,
  double? topScore,
  bool coastal = false,
  String? life,
  List<String> tags = const [],
  GeoPoint? center,
}) => PinDong(
  id: id,
  name: name,
  center: center,
  tags: tags,
  topType: topType,
  topScore: topScore,
  coastal: coastal,
  life: life,
  types: scores == null
      ? null
      : [
          for (final e in scores.entries)
            TypeScore(name: e.key, score: e.value),
        ],
);

void main() {
  group('투영', () {
    test('위경도 → 세계 좌표 → 위경도가 제자리로 돌아온다', () {
      const p = GeoPoint(lat: 37.7519, lng: 128.8761);
      final back = MapProjection.toGeo(MapProjection.toWorld(p));
      expect(back.lat, closeTo(p.lat, 1e-9));
      expect(back.lng, closeTo(p.lng, 1e-9));
    });

    test('북쪽일수록 화면 위(y 작음), 동쪽일수록 오른쪽(x 큼)', () {
      final a = MapProjection.toWorld(const GeoPoint(lat: 37, lng: 128));
      final north = MapProjection.toWorld(const GeoPoint(lat: 38, lng: 128));
      final east = MapProjection.toWorld(const GeoPoint(lat: 37, lng: 129));
      expect(north.dy, lessThan(a.dy));
      expect(east.dx, greaterThan(a.dx));
    });

    test('fit 은 범위를 패딩 안쪽 화면에 꼭 맞춘다', () {
      const bounds = GeoBounds(
        west: 128.2,
        south: 37.4,
        east: 129.1,
        north: 38.6,
      );
      const size = Size(390, 500);
      const padding = EdgeInsets.fromLTRB(20, 60, 20, 30);
      final cam = MapCamera.fit(bounds, size, padding: padding);
      final nw = cam.toScreen(const GeoPoint(lat: 38.6, lng: 128.2));
      final se = cam.toScreen(const GeoPoint(lat: 37.4, lng: 129.1));
      expect(nw.dx, greaterThanOrEqualTo(padding.left - 0.01));
      expect(nw.dy, greaterThanOrEqualTo(padding.top - 0.01));
      expect(se.dx, lessThanOrEqualTo(size.width - padding.right + 0.01));
      expect(se.dy, lessThanOrEqualTo(size.height - padding.bottom + 0.01));
      // 둘 중 한 방향은 딱 맞는다.
      final fitsWidth = (se.dx - nw.dx - (size.width - 40)).abs() < 0.01;
      final fitsHeight = (se.dy - nw.dy - (size.height - 90)).abs() < 0.01;
      expect(fitsWidth || fitsHeight, isTrue);
    });

    test('화면 좌표 ↔ 위경도가 서로 되돌린다', () {
      const bounds = GeoBounds(
        west: 128.2,
        south: 37.4,
        east: 129.1,
        north: 38.6,
      );
      final cam = MapCamera.fit(bounds, const Size(390, 500));
      const p = GeoPoint(lat: 37.9, lng: 128.7);
      final back = cam.toGeo(cam.toScreen(p));
      expect(back.lat, closeTo(p.lat, 1e-9));
      expect(back.lng, closeTo(p.lng, 1e-9));
      // 가운데는 범위의 가운데(메르카토르라 위도는 산술 중간과 조금 다름)
      expect(cam.toGeo(const Offset(195, 250)).lng, closeTo(128.65, 1e-6));
    });

    test('maxScale 로 확대 한도를 둔다', () {
      const tiny = GeoBounds(
        west: 128.0,
        south: 37.0,
        east: 128.001,
        north: 37.001,
      );
      final cam = MapCamera.fit(tiny, const Size(390, 500), maxScale: 1000);
      expect(cam.scale, 1000);
    });

    test('lerp 는 양 끝을 돌려주고 배율을 로그로 잇는다', () {
      const size = Size(100, 100);
      const a = MapCamera(size: size, center: Offset.zero, scale: 100);
      const b = MapCamera(size: size, center: Offset(1, 1), scale: 400);
      expect(MapCamera.lerp(a, b, 0).scale, closeTo(100, 1e-9));
      expect(MapCamera.lerp(a, b, 1).scale, closeTo(400, 1e-9));
      expect(MapCamera.lerp(a, b, 0.5).scale, closeTo(200, 1e-9));
    });

    test('GeoBounds: of · atLeast · contains', () {
      final b = GeoBounds.of(const [
        GeoPoint(lat: 37.5, lng: 128.5),
        GeoPoint(lat: 37.6, lng: 128.9),
      ])!;
      expect(b.west, 128.5);
      expect(b.north, 37.6);
      expect(GeoBounds.of(const []), isNull);
      final wide = GeoBounds.of(const [GeoPoint(lat: 37, lng: 128)])!
          .atLeast(0.02);
      expect(wide.east - wide.west, closeTo(0.02, 1e-12));
      expect(wide.contains(const GeoPoint(lat: 37.005, lng: 128.005)), isTrue);
      expect(b.contains(const GeoPoint(lat: 38, lng: 128.6)), isFalse);
    });

    test('pointInPolygon: 안 · 밖 · 구멍', () {
      GeoPoint p(double lng, double lat) => GeoPoint(lat: lat, lng: lng);
      final outer = [p(0, 0), p(10, 0), p(10, 10), p(0, 10)];
      final hole = [p(4, 4), p(6, 4), p(6, 6), p(4, 6)];
      expect(pointInPolygon(p(2, 2), [outer]), isTrue);
      expect(pointInPolygon(p(12, 2), [outer]), isFalse);
      expect(pointInPolygon(p(5, 5), [outer, hole]), isFalse);
      expect(pointInPolygon(p(5, 5), [outer]), isTrue);
    });
  });

  group('경계 파일', () {
    test('시군구 12곳 · 강릉시 동 21 · 모든 점이 한국 안', () {
      final areas = GeoArea.parseCollection(
        jsonDecode(File('assets/geo/sigungu.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      expect(areas, hasLength(12));
      final gn = areas.firstWhere((a) => a.id == '51150');
      expect(gn.name, '강릉시');
      expect(gn.dongCount, 21);
      expect(gn.hint, '카페 · 해수욕장');
      expect(gn.label, isNotNull);
      for (final a in areas) {
        for (final pt in a.points) {
          expect(pt.lat, inInclusiveRange(33, 39));
          expect(pt.lng, inInclusiveRange(125.5, 130));
        }
      }
    });

    test('MultiPolygon 은 폴리곤 여러 개로 읽는다', () {
      final areas = GeoArea.parseCollection(
        jsonDecode(File('assets/geo/sigungu.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      expect(
        areas.firstWhere((a) => a.id == '50110').polygons.length,
        greaterThan(1),
      );
      expect(areas.firstWhere((a) => a.id == '51150').polygons, hasLength(1));
    });

    test('강릉시 행정동 경계 21곳', () {
      final dongs = GeoArea.parseCollection(
        jsonDecode(File('assets/geo/dongs_51150.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      expect(dongs, hasLength(21));
    });
  });

  group('⓪ 점수', () {
    PopularRegion region(String id, MetricScores s) => PopularRegion(
      id: id,
      name: id,
      province: '강원특별자치도',
      scores: s,
      favoriteCount: 0,
      viewCount: 0,
    );
    final items = [
      region(
        'a',
        const MetricScores(
          quiet: 55,
          crowd: 37,
          peer: 48,
          overnight: 76,
          vibe: 30,
        ),
      ),
      region(
        'b',
        const MetricScores(
          quiet: 10,
          crowd: 10,
          peer: 10,
          overnight: 10,
          vibe: 90,
        ),
      ),
    ];

    test('종합은 프리셋 가중 평균(조용한 곳 3·3·1·1·0)', () {
      final s = sigunguScores(items, null);
      expect(s['a'], closeTo((55 * 3 + 37 * 3 + 48 + 76) / 8, 1e-9));
      expect(s['b'], closeTo(10, 1e-9));
    });

    test('지표를 고르면 그 지표 점수 그대로', () {
      expect(sigunguScores(items, MetricKey.quiet)['a'], 55);
      expect(sigunguScores(items, MetricKey.vibe)['b'], 90);
    });

    test('가중치를 바꾸면 종합이 달라진다', () {
      final s = sigunguScores(items, null, weights: Weights.livelyPreset);
      expect(s['b'], greaterThan(sigunguScores(items, null)['b']!));
    });

    test('heatStep: 7단계 경계', () {
      expect(heatStep(0), 0);
      expect(heatStep(14.2), 0);
      expect(heatStep(14.3), 1);
      expect(heatStep(50), 3);
      expect(heatStep(99.9), 6);
      expect(heatStep(100), 6);
      expect(heatStep(-5), 0);
      expect(heatStep(150), 6);
    });
  });

  group('① 정렬 · 거르기', () {
    final dongs = [
      pin(
        '1',
        '다동',
        scores: {'몰입형': 30, '장기체류형': 70},
        topType: '장기체류형',
        topScore: 70,
        coastal: true,
        life: '관광지',
      ),
      pin(
        '2',
        '가동',
        scores: {'몰입형': 80, '장기체류형': 20},
        topType: '몰입형',
        topScore: 80,
        life: '생활권',
      ),
      pin(
        '3',
        '나동',
        scores: {'몰입형': 50, '장기체류형': 50},
        topType: '몰입형',
        topScore: 50,
        coastal: true,
        life: '생활권',
      ),
      pin('4', '라동', topType: '장기체류형', topScore: 40, life: '관광지'),
    ];
    List<String> names(PinFilter f) => [
      for (final d in filterAndSortPins(dongs, f)) d.name,
    ];

    test('전체는 이름순', () {
      expect(names(const PinFilter()), ['가동', '나동', '다동', '라동']);
    });

    test('유형 칩은 그 유형 점수 높은 순, 점수가 같으면 이름순', () {
      expect(names(const PinFilter(type: '몰입형')).take(3), ['가동', '나동', '다동']);
      expect(names(const PinFilter(type: '장기체류형')).first, '다동');
    });

    test('types 가 없는 동은 1위 유형일 때만 점수가 있고, 점수 없는 동은 맨 뒤', () {
      // 라동은 types 없이 1위 유형(장기체류형 40)만 있다.
      expect(names(const PinFilter(type: '장기체류형')), ['다동', '나동', '라동', '가동']);
      expect(names(const PinFilter(type: '몰입형')).last, '라동');
    });

    test('속성 칩은 거르기이고 동시에 고르면 모두 만족(AND)', () {
      expect(names(const PinFilter(attrs: {PinAttr.coast})), ['나동', '다동']);
      expect(names(const PinFilter(attrs: {PinAttr.life})), ['가동', '나동']);
      expect(names(const PinFilter(attrs: {PinAttr.tourist})), ['다동', '라동']);
      expect(names(const PinFilter(attrs: {PinAttr.coast, PinAttr.life})), [
        '나동',
      ]);
    });

    test('유형 칩과 속성 칩을 같이 쓰면 거른 뒤 그 유형 점수순', () {
      expect(names(const PinFilter(type: '몰입형', attrs: {PinAttr.coast})), [
        '나동',
        '다동',
      ]);
    });

    test('toggleType: 하나만 고르고 다시 누르면 풀린다 · toggleAttr 는 겹쳐 고른다', () {
      var f = const PinFilter();
      expect(f.isAll, isTrue);
      f = f.toggleType('몰입형').toggleType('장기체류형');
      expect(f.type, '장기체류형');
      f = f.toggleType('장기체류형');
      expect(f.type, isNull);
      f = f.toggleAttr(PinAttr.coast).toggleAttr(PinAttr.life);
      expect(f.attrs, {PinAttr.coast, PinAttr.life});
      expect(f.isAll, isFalse);
      f = f.toggleAttr(PinAttr.coast);
      expect(f.attrs, {PinAttr.life});
      expect(
        const PinFilter(attrs: {PinAttr.coast}),
        const PinFilter(attrs: {PinAttr.coast}),
      );
    });

    test('rowScore: 유형 칩이면 그 유형, 아니면 1위 유형', () {
      final d = dongs[0];
      expect(rowScore(d, const PinFilter())!.type, '장기체류형');
      expect(rowScore(d, const PinFilter())!.score, 70);
      expect(rowScore(d, const PinFilter(type: '몰입형'))!.score, 30);
      expect(rowScore(dongs[3], const PinFilter(type: '몰입형')), isNull);
    });

    test('강릉시 mock: 장기체류형 칩 정렬이 점수 내림차순', () {
      final res = PinsResponse.fromJson(
        jsonDecode(
          File('assets/mock/explore/pins_51150.json').readAsStringSync(),
        ) as Map<String, dynamic>,
      );
      final sorted = filterAndSortPins(
        res.dongs,
        const PinFilter(type: '장기체류형'),
      );
      expect(sorted, hasLength(21));
      final scores = [for (final d in sorted) d.scoreOf('장기체류형') ?? -1];
      for (var i = 1; i < scores.length; i++) {
        expect(scores[i], lessThanOrEqualTo(scores[i - 1]));
      }
      expect(sorted.first.scoreOf('장기체류형'), isNotNull);
    });
  });

  group('핀 아이콘', () {
    test('특성 태그(바닷가·도심)보다 하는 일 · 쉬는 곳 태그를 앞세운다', () {
      expect(pinIconTag(['coast', 'cafe', 'long_stay']), 'cafe');
      expect(pinIconTag(['coast', 'park']), 'park');
      expect(pinIconTag(['city']), 'city');
      expect(pinIconTag(['mountain']), 'mountain');
    });

    test('아이콘이 있는 태그가 없으면 null', () {
      expect(pinIconTag(const []), isNull);
      expect(pinIconTag(['food']), isNull);
    });
  });

  group('핀 겹침 묶음', () {
    const viewport = Rect.fromLTWH(0, 0, 390, 500);
    PlacedPin placed(String id, double x, double y, {double? score}) =>
        PlacedPin(pin(id, id, topScore: score), Offset(x, y));

    test('겹치지 않는 핀은 모두 보인다', () {
      final l = layoutPins([
        placed('a', 60, 100),
        placed('b', 250, 100),
        placed('c', 150, 300),
      ], viewport: viewport);
      expect(l.shown, hasLength(3));
      expect(l.clusters, isEmpty);
    });

    test('겹치면 우선순위(1위 점수 높은 쪽)만 남고 나머지는 묶음이 된다', () {
      final l = layoutPins([
        placed('low', 100, 200, score: 10),
        placed('high', 110, 205, score: 90),
      ], viewport: viewport);
      expect([for (final p in l.shown) p.pin.id], ['high']);
      expect(l.clusters, hasLength(1));
      expect([for (final m in l.clusters.single.members) m.id], ['low']);
    });

    test('고른 핀은 점수가 낮아도 항상 보인다', () {
      final l = layoutPins(
        [
          placed('low', 100, 200, score: 10),
          placed('high', 110, 205, score: 90),
        ],
        viewport: viewport,
        selectedId: 'low',
      );
      expect([for (final p in l.shown) p.pin.id], ['low']);
      expect(l.clusters.single.members.single.id, 'high');
    });

    test('가까이 접힌 핀들은 한 묶음, 멀리 접힌 핀은 따로', () {
      final l = layoutPins([
        placed('top', 100, 100, score: 99),
        placed('n1', 105, 100, score: 5),
        placed('n2', 110, 104, score: 4),
        placed('n3', 95, 98, score: 3),
        placed('top2', 300, 400, score: 98),
        placed('far', 305, 402, score: 2),
      ], viewport: viewport);
      expect(l.shown, hasLength(2));
      expect(l.clusters, hasLength(2));
      final sizes = [for (final c in l.clusters) c.members.length]..sort();
      expect(sizes, [1, 3]);
    });

    test('확대해서 핀 사이가 벌어지면 묶음이 풀린다', () {
      List<PlacedPin> at(double k) => [
        for (var i = 0; i < 6; i++)
          placed(
            'p$i',
            200 + (i - 3) * 6 * k,
            250 + (i % 2) * 5 * k,
            score: 100.0 - i,
          ),
      ];
      final tight = layoutPins(at(1), viewport: viewport);
      final loose = layoutPins(at(30), viewport: viewport.inflate(2000));
      expect(tight.clusters, isNotEmpty);
      expect(tight.shown.length, lessThan(6));
      expect(loose.clusters, isEmpty);
      expect(loose.shown, hasLength(6));
    });

    test('화면 밖 핀은 그리지도 묶지도 않는다', () {
      final l = layoutPins([
        placed('in', 100, 100),
        placed('out', 900, 100),
      ], viewport: viewport);
      expect(l.shown, hasLength(1));
      expect(l.clusters, isEmpty);
    });

    test('묶음 필은 이름 핀을 가리지 않는 자리에 놓인다', () {
      final l = layoutPins([
        placed('a', 100, 200, score: 90),
        placed('b', 105, 202, score: 10),
      ], viewport: viewport);
      final c = l.clusters.single;
      final pill = Rect.fromCenter(center: c.spot, width: 76, height: 28);
      final pinRect = Rect.fromLTWH(100 - 31, 200 - 44, 62, 44);
      expect(pill.overlaps(pinRect), isFalse);
    });

    test('pickNonOverlapping: 앞선 것이 이긴다', () {
      final keep = pickNonOverlapping(const [
        Rect.fromLTWH(0, 0, 10, 10),
        Rect.fromLTWH(5, 5, 10, 10),
        Rect.fromLTWH(20, 0, 10, 10),
      ]);
      expect(keep, [true, false, true]);
    });
  });
}
