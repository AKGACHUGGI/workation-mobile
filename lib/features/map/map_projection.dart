import 'dart:math' as math;

import 'package:flutter/painting.dart';

import '../../data/models/explore.dart';

/// 위경도 상자.
class GeoBounds {
  const GeoBounds({
    required this.west,
    required this.south,
    required this.east,
    required this.north,
  });

  /// 점들을 감싸는 상자. 점이 없으면 null.
  static GeoBounds? of(Iterable<GeoPoint> points) {
    double? west, south, east, north;
    for (final p in points) {
      west = west == null ? p.lng : math.min(west, p.lng);
      east = east == null ? p.lng : math.max(east, p.lng);
      south = south == null ? p.lat : math.min(south, p.lat);
      north = north == null ? p.lat : math.max(north, p.lat);
    }
    if (west == null) return null;
    return GeoBounds(west: west, south: south!, east: east!, north: north!);
  }

  final double west;
  final double south;
  final double east;
  final double north;

  GeoPoint get center =>
      GeoPoint(lat: (south + north) / 2, lng: (west + east) / 2);

  /// 두 상자를 합친 상자
  GeoBounds union(GeoBounds o) => GeoBounds(
    west: math.min(west, o.west),
    south: math.min(south, o.south),
    east: math.max(east, o.east),
    north: math.max(north, o.north),
  );

  /// 가로 · 세로가 [minSpan] 도보다 좁으면 가운데를 두고 넓힙니다.
  GeoBounds atLeast(double minSpan) {
    final c = center;
    final w = math.max(east - west, minSpan);
    final h = math.max(north - south, minSpan);
    return GeoBounds(
      west: c.lng - w / 2,
      south: c.lat - h / 2,
      east: c.lng + w / 2,
      north: c.lat + h / 2,
    );
  }

  bool contains(GeoPoint p) =>
      p.lng >= west && p.lng <= east && p.lat >= south && p.lat <= north;
}

/// 위경도 ↔ 세계 좌표(웹 메르카토르, 단위 라디안, y 는 아래로 커짐).
/// Google Maps 와 같은 투영이라 나중에 `google_maps_flutter` 로 바꿔도 모양이 같습니다.
abstract final class MapProjection {
  static Offset toWorld(GeoPoint p) => Offset(
    p.lng * math.pi / 180,
    -math.log(math.tan(math.pi / 4 + p.lat * math.pi / 360)),
  );

  static GeoPoint toGeo(Offset w) => GeoPoint(
    lat: (2 * math.atan(math.exp(-w.dy)) - math.pi / 2) * 180 / math.pi,
    lng: w.dx * 180 / math.pi,
  );
}

/// 화면 크기 · 가운데 · 배율로 정해지는 카메라. 위경도를 화면 좌표(px)로 바꿉니다.
class MapCamera {
  const MapCamera({
    required this.size,
    required this.center,
    required this.scale,
  });

  /// [bounds] 가 [padding] 안쪽 화면에 꼭 맞는 카메라. [maxScale] 로 확대 한도를 둡니다.
  factory MapCamera.fit(
    GeoBounds bounds,
    Size size, {
    EdgeInsets padding = EdgeInsets.zero,
    double maxScale = double.infinity,
  }) {
    final a = MapProjection.toWorld(
      GeoPoint(lat: bounds.north, lng: bounds.west),
    );
    final b = MapProjection.toWorld(
      GeoPoint(lat: bounds.south, lng: bounds.east),
    );
    final w = math.max((b.dx - a.dx).abs(), 1e-9);
    final h = math.max((b.dy - a.dy).abs(), 1e-9);
    final availW = math.max(size.width - padding.horizontal, 1.0);
    final availH = math.max(size.height - padding.vertical, 1.0);
    final scale = math.min(math.min(availW / w, availH / h), maxScale);
    // padding 이 비대칭이면 가운데를 그만큼 옮깁니다.
    final shift = Offset(
      (padding.left - padding.right) / 2,
      (padding.top - padding.bottom) / 2,
    );
    return MapCamera(
      size: size,
      center: Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2) - shift / scale,
      scale: scale,
    );
  }

  final Size size;

  /// 화면 가운데에 오는 세계 좌표
  final Offset center;

  /// 세계 좌표 1 당 px
  final double scale;

  Offset worldToScreen(Offset w) =>
      (w - center) * scale + Offset(size.width / 2, size.height / 2);

  Offset toScreen(GeoPoint p) => worldToScreen(MapProjection.toWorld(p));

  GeoPoint toGeo(Offset screen) => MapProjection.toGeo(
    (screen - Offset(size.width / 2, size.height / 2)) / scale + center,
  );

  /// 지금 화면에 보이는 위경도 범위
  GeoBounds get visible {
    final nw = toGeo(Offset.zero);
    final se = toGeo(Offset(size.width, size.height));
    return GeoBounds(west: nw.lng, south: se.lat, east: se.lng, north: nw.lat);
  }

  MapCamera copyWith({Size? size, Offset? center, double? scale}) => MapCamera(
    size: size ?? this.size,
    center: center ?? this.center,
    scale: scale ?? this.scale,
  );

  /// [t] 0~1 로 두 카메라 사이를 잇습니다. 배율은 로그 척도로 보간해 확대가 고르게 느껴집니다.
  static MapCamera lerp(MapCamera a, MapCamera b, double t) => MapCamera(
    size: b.size,
    center: Offset.lerp(a.center, b.center, t)!,
    scale: a.scale * math.pow(b.scale / a.scale, t),
  );
}

/// 점이 구역 안에 있는지. 폴리곤의 고리들을 짝홀(even-odd) 규칙으로 셉니다(구멍 처리).
bool pointInPolygon(GeoPoint p, List<List<GeoPoint>> rings) {
  var inside = false;
  for (final ring in rings) {
    for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final a = ring[i];
      final b = ring[j];
      if ((a.lat > p.lat) != (b.lat > p.lat) &&
          p.lng < (b.lng - a.lng) * (p.lat - a.lat) / (b.lat - a.lat) + a.lng) {
        inside = !inside;
      }
    }
  }
  return inside;
}
