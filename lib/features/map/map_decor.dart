import '../../data/models/explore.dart';

/// 지도 장식(mock). 경계 데이터에 없는 바다 · 서비스 밖 이웃 지역 이름입니다.
/// Google Maps 로 바꾸면 타일이 그려 주므로 이 파일은 지웁니다.

/// 동해안 바다 면. 고성군~동해시 경계의 동쪽 끝을 따라 만든 해안선(북 → 남)에
/// 동쪽 모서리를 이어 닫았습니다.
const kSeaPolygon = <GeoPoint>[
  GeoPoint(lat: 38.70, lng: 128.34),
  GeoPoint(lat: 38.64, lng: 128.362),
  GeoPoint(lat: 38.58, lng: 128.414),
  GeoPoint(lat: 38.52, lng: 128.435),
  GeoPoint(lat: 38.46, lng: 128.473),
  GeoPoint(lat: 38.40, lng: 128.52),
  GeoPoint(lat: 38.34, lng: 128.555),
  GeoPoint(lat: 38.28, lng: 128.587),
  GeoPoint(lat: 38.22, lng: 128.607),
  GeoPoint(lat: 38.16, lng: 128.628),
  GeoPoint(lat: 38.10, lng: 128.682),
  GeoPoint(lat: 38.04, lng: 128.741),
  GeoPoint(lat: 37.98, lng: 128.777),
  GeoPoint(lat: 37.92, lng: 128.839),
  GeoPoint(lat: 37.86, lng: 128.882),
  GeoPoint(lat: 37.80, lng: 128.955),
  GeoPoint(lat: 37.74, lng: 129.016),
  GeoPoint(lat: 37.68, lng: 129.062),
  GeoPoint(lat: 37.62, lng: 129.077),
  GeoPoint(lat: 37.56, lng: 129.126),
  GeoPoint(lat: 37.50, lng: 129.165),
  GeoPoint(lat: 37.44, lng: 129.153),
  GeoPoint(lat: 37.20, lng: 129.35),
  GeoPoint(lat: 37.20, lng: 131.0),
  GeoPoint(lat: 38.70, lng: 131.0),
];

/// 지도 위에 흐리게 놓는 이웃 지역 · 바다 이름.
class MapContextLabel {
  const MapContextLabel(this.name, this.at, {this.sea = false});

  final String name;
  final GeoPoint at;
  final bool sea;
}

const kContextLabels = <MapContextLabel>[
  MapContextLabel('인제군', GeoPoint(lat: 38.05, lng: 128.27)),
  MapContextLabel('홍천군', GeoPoint(lat: 37.70, lng: 128.12)),
  MapContextLabel('평창군', GeoPoint(lat: 37.45, lng: 128.45)),
  MapContextLabel('동해', GeoPoint(lat: 37.85, lng: 129.4), sea: true),
];

/// ⓪ 에서 집계에서 빠진 동(경계 자료가 없어 라벨만 둠). 고성군 수동면.
class ExcludedArea {
  const ExcludedArea(this.name, this.at);

  final String name;
  final GeoPoint at;
}

const kExcludedAreas = <ExcludedArea>[
  ExcludedArea('수동면', GeoPoint(lat: 38.28, lng: 128.28)),
];
