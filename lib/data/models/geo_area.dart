import 'explore.dart';

/// 경계 파일(GeoJSON)의 구역 하나: 시군구 또는 행정동.
///
/// [polygons] 는 폴리곤 목록이고, 폴리곤 하나는 고리 목록입니다(첫 고리가 바깥, 나머지는 구멍).
/// 섬이 여럿인 구역은 폴리곤이 여러 개입니다. 좌표는 위경도입니다.
class GeoArea {
  const GeoArea({
    required this.id,
    required this.name,
    required this.polygons,
    this.label,
    this.dongCount,
    this.hint,
  });

  /// 시군구 5자리 또는 행정동 10자리 코드
  final String id;
  final String name;
  final List<List<List<GeoPoint>>> polygons;

  /// 이름 · 핀을 놓을 구역 안쪽 대표 점(`labelLat` · `labelLng`)
  final GeoPoint? label;

  /// 시군구의 행정동 수(집계 제외 동은 빠짐)
  final int? dongCount;

  /// 시군구 라벨의 대표 태그 문구. 예: `카페 · 해수욕장` (mock 에만 있음)
  final String? hint;

  /// 모든 경계 점
  Iterable<GeoPoint> get points sync* {
    for (final polygon in polygons) {
      for (final ring in polygon) {
        yield* ring;
      }
    }
  }

  /// GeoJSON `FeatureCollection` 을 구역 목록으로 읽습니다.
  static List<GeoArea> parseCollection(Map<String, dynamic> json) {
    final features = json['features'] as List<dynamic>;
    return [
      for (final f in features) GeoArea._fromFeature(f as Map<String, dynamic>),
    ];
  }

  factory GeoArea._fromFeature(Map<String, dynamic> feature) {
    final props = feature['properties'] as Map<String, dynamic>;
    final geometry = feature['geometry'] as Map<String, dynamic>;
    final coords = geometry['coordinates'] as List<dynamic>;
    final raw = geometry['type'] == 'MultiPolygon' ? coords : [coords];
    final lat = props['labelLat'] as num?;
    final lng = props['labelLng'] as num?;
    return GeoArea(
      id: props['id'] as String,
      name: props['name'] as String,
      polygons: [
        for (final polygon in raw)
          [
            for (final ring in polygon as List<dynamic>)
              [
                for (final p in ring as List<dynamic>)
                  GeoPoint(
                    lat: ((p as List<dynamic>)[1] as num).toDouble(),
                    lng: (p[0] as num).toDouble(),
                  ),
              ],
          ],
      ],
      label: lat == null || lng == null
          ? null
          : GeoPoint(lat: lat.toDouble(), lng: lng.toDouble()),
      dongCount: (props['dongCount'] as num?)?.toInt(),
      hint: props['hint'] as String?,
    );
  }
}
