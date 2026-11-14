import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/metric/metric.dart';

part 'popular_region.freezed.dart';
part 'popular_region.g.dart';

/// 지형 분류(수동 관리). 홈 카테고리 필터에 씁니다.
enum Terrain {
  coast('해안'),
  mountain('산간'),
  city('도시');

  const Terrain(this.label);

  final String label;
}

/// 지표별 점수 0~100 (같은 월 · 같은 범위 안의 백분위).
@freezed
abstract class MetricScores with _$MetricScores {
  const MetricScores._();

  const factory MetricScores({
    required double quiet,
    required double crowd,
    required double peer,
    required double overnight,
    required double vibe,
  }) = _MetricScores;

  factory MetricScores.fromJson(Map<String, dynamic> json) =>
      _$MetricScoresFromJson(json);

  double operator [](MetricKey key) => switch (key) {
    MetricKey.quiet => quiet,
    MetricKey.crowd => crowd,
    MetricKey.peer => peer,
    MetricKey.overnight => overnight,
    MetricKey.vibe => vibe,
  };
}

/// `GET /api/regions/popular?month=` 의 항목 (12곳 전부, 정렬 없음).
@freezed
abstract class PopularRegion with _$PopularRegion {
  const factory PopularRegion({
    required String id,
    required String name,
    required String province,
    String? photoUrl,
    @Default(<String>[]) List<String> tags,
    @Default(<Terrain>[]) List<Terrain> terrain,
    required MetricScores scores,
    required int favoriteCount,
    required int viewCount,
  }) = _PopularRegion;

  factory PopularRegion.fromJson(Map<String, dynamic> json) =>
      _$PopularRegionFromJson(json);
}

@freezed
abstract class PopularResponse with _$PopularResponse {
  const factory PopularResponse({
    required String month,
    required String asOf,
    required List<PopularRegion> items,
  }) = _PopularResponse;

  factory PopularResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularResponseFromJson(json);
}
