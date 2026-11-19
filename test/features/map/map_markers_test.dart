import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/models/geo_area.dart';
import 'package:workation_mobile/features/map/map_logic.dart';
import 'package:workation_mobile/features/map/map_markers.dart';
import 'package:workation_mobile/features/map/map_projection.dart';
import 'package:workation_mobile/features/map/widgets/marker_bitmaps.dart';
import 'package:workation_mobile/shared/widgets/area_label.dart';
import 'package:workation_mobile/shared/widgets/dong_pin.dart';

GeoArea area(String id, String name, double lat, double lng) => GeoArea(
  id: id,
  name: name,
  polygons: const [],
  label: GeoPoint(lat: lat, lng: lng),
  dongCount: 5,
);

PinDong pin(
  String id,
  double lat,
  double lng, {
  double? score,
  List<String> tags = const [],
}) => PinDong(
  id: id,
  name: id,
  center: GeoPoint(lat: lat, lng: lng),
  topScore: score,
  tags: tags,
);

/// 강릉 근처를 390×500 화면에 담은 카메라
final camera = MapCamera.fit(
  const GeoBounds(west: 128.7, south: 37.6, east: 129.1, north: 37.95),
  const Size(390, 500),
);

void main() {
  group('마커 그림(캐시 키)', () {
    test('이름 · 태그 · 상태가 같으면 같은 그림이다', () {
      expect(
        const PinVisual(name: '주문진읍', tag: 'beach'),
        const PinVisual(name: '주문진읍', tag: 'beach'),
      );
      expect(
        const PinVisual(name: '주문진읍', tag: 'beach').hashCode,
        const PinVisual(name: '주문진읍', tag: 'beach').hashCode,
      );
      expect(
        const LabelVisual(name: '강릉시', summary: '동 21'),
        const LabelVisual(name: '강릉시', summary: '동 21'),
      );
      expect(const ClusterVisual(3), const ClusterVisual(3));
    });

    test('하나라도 다르면 다른 그림이다', () {
      const base = PinVisual(name: '주문진읍', tag: 'beach');
      expect(base, isNot(const PinVisual(name: '교1동', tag: 'beach')));
      expect(base, isNot(const PinVisual(name: '주문진읍', tag: 'cafe')));
      expect(base, isNot(const PinVisual(name: '주문진읍')));
      expect(
        base,
        isNot(const PinVisual(name: '주문진읍', tag: 'beach', selected: true)),
      );
      expect(
        const LabelVisual(name: '강릉시'),
        isNot(const LabelVisual(name: '강릉시', state: AreaLabelState.selected)),
      );
      expect(const ClusterVisual(3), isNot(const ClusterVisual(4)));
      // 종류가 다르면 이름이 같아도 다릅니다.
      expect(
        const PinVisual(name: '강릉시'),
        isNot(const LabelVisual(name: '강릉시')),
      );
    });
  });

  group('앵커', () {
    test('핀은 아래 가운데의 위치 점 중심', () {
      // 위젯 100×44 에 여백 12 를 두른 비트맵
      final anchor = markerAnchor(
        const PinVisual(name: 'a'),
        const Size(124, 68),
        padding: 12,
      );
      expect(anchor.dx, 0.5);
      // 위젯 아래 끝(68 - 12 = 56)에서 점 반지름(4)만큼 위
      expect(anchor.dy * 68, closeTo(56 - DongPin.dotSize / 2, 1e-9));
    });

    test('라벨 · 묶음은 한가운데', () {
      expect(
        markerAnchor(const LabelVisual(name: 'a'), const Size(90, 50)),
        const Offset(0.5, 0.5),
      );
      expect(
        markerAnchor(const ClusterVisual(2), const Size(80, 52)),
        const Offset(0.5, 0.5),
      );
    });
  });

  group('⓪ 시군구 라벨', () {
    final areas = [
      area('a', '강릉시', 37.75, 128.9),
      area('b', '동해시', 37.52, 129.1), // 화면 아래 밖
      area('c', '강릉옆', 37.752, 128.905), // a 와 겹침
    ];
    const scores = {'a': 50.0, 'b': 70.0, 'c': 90.0};

    test('겹친 위젯용: 화면 안의 것만, 겹치면 점수 높은 것', () {
      final labels = pickAreaLabels(
        camera,
        areas,
        scores: scores,
        includeOffscreen: false,
      );
      expect([for (final l in labels) l.area.id], ['c']);
    });

    test('마커용: 화면 밖 라벨도 제자리에 둔다', () {
      final labels = pickAreaLabels(
        camera,
        areas,
        scores: scores,
        includeOffscreen: true,
      );
      expect([for (final l in labels) l.area.id], ['c', 'b']);
      expect(labels.last.spot, camera.toScreen(areas[1].label!));
    });

    test('고른 시군구가 맨 위 · 고른 상태로 그려지고, 누르면 그 id 를 알린다', () {
      String? tapped;
      final specs = sigunguMarkerSpecs(
        camera,
        areas,
        scores: scores,
        selected: 'a',
        onSelect: (id) => tapped = id,
      );
      final labels = [
        for (final s in specs)
          if (s.id.startsWith('label:')) s,
      ];
      // 고른 a 가 앞서므로 겹치는 c 가 빠집니다.
      expect([for (final s in labels) s.id], ['label:a', 'label:b']);
      expect(
        (labels.first.visual as LabelVisual).state,
        AreaLabelState.selected,
      );
      expect((labels.last.visual as LabelVisual).state, AreaLabelState.normal);
      expect(labels.first.zIndex, greaterThan(labels.last.zIndex));
      // 가장자리에 걸치지 않으면 제자리(대표 점)
      expect(labels.first.at.lat, closeTo(areas[0].label!.lat, 1e-9));
      expect(labels.first.at.lng, closeTo(areas[0].label!.lng, 1e-9));

      labels.last.onTap!();
      expect(tapped, 'b');
    });

    test('화면 안 라벨이 가장자리에 걸치면 안쪽으로 밀어 넣는다', () {
      // 화면 왼쪽 끝 바로 안쪽에 대표 점이 있는 시군구
      final edge = camera.toGeo(const Offset(10, 250));
      final specs = sigunguMarkerSpecs(
        camera,
        [area('e', '고성군', edge.lat, edge.lng)],
        scores: const {},
        onSelect: (_) {},
      );
      final label = specs.firstWhere((s) => s.id == 'label:e');
      final half = areaLabelSize('고성군', '동 5').width / 2 + 8;
      final at = camera.toScreen(label.at);
      expect(at.dx, closeTo(half, 1e-6));
      expect(at.dy, closeTo(250, 1e-6));
    });

    test('집계 제외 라벨은 확대했을 때만 넣는다', () {
      bool hasExcluded(MapCamera c) => sigunguMarkerSpecs(
        c,
        areas,
        scores: scores,
        onSelect: (_) {},
      ).any((s) => s.id.startsWith('excluded:'));

      expect(hasExcluded(camera), isTrue);
      final wide = MapCamera.fit(
        const GeoBounds(west: 124, south: 33, east: 132, north: 39),
        const Size(390, 500),
      );
      expect(hasExcluded(wide), isFalse);
    });
  });

  group('① ② 핀 · 묶음', () {
    final pins = [
      pin('high', 37.75, 128.9, score: 90, tags: ['cafe']),
      pin('low', 37.751, 128.902, score: 10), // high 와 겹침
      pin('far', 37.9, 129.05, score: 50),
      pin('off', 36.5, 127.5, score: 80), // 화면 밖
      const PinDong(id: 'nowhere', name: 'nowhere'), // 위치 없음
    ];

    List<MapMarkerSpec> build({String? dongId}) => dongMarkerSpecs(
      camera,
      pins,
      dongId: dongId,
      onPickDong: (_) {},
      onOpenCluster: (_) {},
    );

    test('겹친 핀은 묶음으로, 화면 밖 핀도 함께 놓는다', () {
      final specs = build();
      expect([
        for (final s in specs) s.id,
      ], containsAll(['pin:high', 'pin:far', 'pin:off', 'cluster:low']));
      expect(specs.any((s) => s.id == 'pin:low'), isFalse);
      expect(specs.any((s) => s.id == 'pin:nowhere'), isFalse);

      final high = specs.firstWhere((s) => s.id == 'pin:high');
      expect(high.at, pins[0].center);
      expect(high.visual, const PinVisual(name: 'high', tag: 'cafe'));
      expect(high.alpha, 1);

      final cluster = specs.firstWhere((s) => s.id == 'cluster:low');
      expect(cluster.visual, const ClusterVisual(1));
      // 묶음은 핀 위에 그립니다.
      expect(cluster.zIndex, greaterThan(high.zIndex));
      // 묶음 자리는 접힌 핀 근처(위경도로 되돌린 화면 좌표)
      expect(cluster.at.lat, closeTo(37.75, 0.1));
      expect(cluster.at.lng, closeTo(128.9, 0.1));
    });

    test('고르면 그 핀만 진하고 맨 위, 나머지는 같은 그림에 투명도만 낮춘다', () {
      final specs = build(dongId: 'low');
      final low = specs.firstWhere((s) => s.id == 'pin:low');
      final far = specs.firstWhere((s) => s.id == 'pin:far');

      expect(low.visual, const PinVisual(name: 'low', selected: true));
      expect(low.alpha, 1);
      expect(far.visual, const PinVisual(name: 'far'));
      expect(far.alpha, kDimmedPinAlpha);
      for (final s in specs) {
        if (s.id.startsWith('pin:') && s.id != 'pin:low') {
          expect(low.zIndex, greaterThan(s.zIndex));
        }
      }
      // 고른 핀에 밀려 high 가 묶음이 됩니다.
      expect(specs.any((s) => s.id == 'cluster:high'), isTrue);
    });

    test('핀 · 묶음을 누르면 콜백이 불린다', () {
      String? picked;
      PinCluster? opened;
      final specs = dongMarkerSpecs(
        camera,
        pins,
        onPickDong: (id) => picked = id,
        onOpenCluster: (c) => opened = c,
      );
      specs.firstWhere((s) => s.id == 'pin:far').onTap!();
      expect(picked, 'far');
      specs.firstWhere((s) => s.id == 'cluster:low').onTap!();
      expect([for (final m in opened!.members) m.id], ['low']);
    });
  });

  group('비트맵 캐시', () {
    late int drawn;
    late MarkerBitmapCache cache;

    Future<RasterizedWidget> fake(
      Widget widget, {
      required ui.FlutterView view,
      required ThemeData theme,
      required double pixelRatio,
      TextScaler textScaler = TextScaler.noScaling,
      double padding = 0,
      Size maxSize = Size.zero,
    }) async {
      drawn++;
      return RasterizedWidget(Uint8List.fromList([drawn]), const Size(80, 40));
    }

    setUp(() {
      drawn = 0;
      cache = MarkerBitmapCache(rasterize: fake);
    });

    void configure(WidgetTester tester, {double pixelRatio = 3}) =>
        cache.configure(
          view: tester.view,
          theme: AppTheme.light,
          textScaler: TextScaler.noScaling,
          pixelRatio: pixelRatio,
        );

    testWidgets('같은 그림은 한 번만 그린다', (tester) async {
      configure(tester);
      const visual = PinVisual(name: '주문진읍', tag: 'beach');
      expect(cache.peek(visual), isNull);

      // 동시에 두 번 청해도 한 번만 그립니다.
      final both = await Future.wait([cache.get(visual), cache.get(visual)]);
      expect(drawn, 1);
      expect(both[0], same(both[1]));
      expect(both[0].size, const Size(80, 40));

      expect(cache.peek(const PinVisual(name: '주문진읍', tag: 'beach')), both[0]);
      await cache.get(visual);
      expect(drawn, 1);

      await cache.get(
        const PinVisual(name: '주문진읍', tag: 'beach', selected: true),
      );
      expect(drawn, 2);
    });

    testWidgets('픽셀 비율이 바뀌면 다시 그리고, 그대로면 캐시를 둔다', (tester) async {
      configure(tester);
      const visual = ClusterVisual(3);
      final first = await cache.get(visual);

      configure(tester);
      expect(cache.peek(visual), same(first));

      configure(tester, pixelRatio: 2);
      expect(cache.peek(visual), isNull);
      await cache.get(visual);
      expect(drawn, 2);
    });

    testWidgets('그리는 중에 비워지면 늦게 끝난 결과는 캐시에 넣지 않는다', (tester) async {
      configure(tester);
      const visual = ClusterVisual(3);
      final pending = cache.get(visual);
      cache.clear();
      await pending;
      expect(cache.peek(visual), isNull);
    });
  });

  group('위젯 → 비트맵', () {
    testWidgets('핀을 제 크기 + 여백으로, 픽셀 비율만큼 크게 그린다', (tester) async {
      final raster = await tester.runAsync(
        () => rasterizeWidget(
          markerWidget(const PinVisual(name: '주문진읍', tag: 'beach')),
          view: tester.view,
          theme: AppTheme.light,
          pixelRatio: 2,
          padding: kMarkerBitmapPadding,
        ),
      );

      // 화면에 올린 같은 위젯의 크기와 비교합니다.
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Center(
            child: DongPin(name: '주문진읍', tag: 'beach'),
          ),
        ),
      );
      final onScreen = tester.getSize(find.byType(DongPin));
      expect(
        raster!.size,
        onScreen + const Offset(kMarkerBitmapPadding, kMarkerBitmapPadding) * 2,
      );

      final image = await tester.runAsync(() async {
        final codec = await ui.instantiateImageCodec(raster.png);
        return (await codec.getNextFrame()).image;
      });
      expect(image!.width, (raster.size.width * 2).round());
      expect(image.height, (raster.size.height * 2).round());
      image.dispose();
    });

    testWidgets('라벨 · 묶음도 그려진다', (tester) async {
      for (final visual in const <MarkerVisual>[
        LabelVisual(name: '강릉시', summary: '동 21 · 카페'),
        LabelVisual(
          name: '수동면',
          summary: '집계 제외',
          state: AreaLabelState.excluded,
        ),
        ClusterVisual(11),
      ]) {
        final raster = await tester.runAsync(
          () => rasterizeWidget(
            markerWidget(visual),
            view: tester.view,
            theme: AppTheme.light,
            pixelRatio: 1,
            padding: kMarkerBitmapPadding,
          ),
        );
        expect(raster!.size.width, greaterThan(2 * kMarkerBitmapPadding));
        expect(raster.size.height, greaterThan(2 * kMarkerBitmapPadding));
        expect(raster.png, isNotEmpty);
      }
    });
  });
}
