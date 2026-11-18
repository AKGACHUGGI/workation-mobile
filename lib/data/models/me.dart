import 'package:freezed_annotation/freezed_annotation.dart';

import 'popular_region.dart';
import 'region_detail.dart';

part 'me.freezed.dart';
part 'me.g.dart';

/// 즐겨찾기 종류. [path] 는 `PUT /api/me/favorites/{path}/{id}` 의 경로 조각입니다.
enum FavoriteKind {
  regions('regions'),
  dongs('dongs');

  const FavoriteKind(this.path);

  final String path;
}

/// 즐겨찾기 상한(웹과 같음)
const favoriteLimit = 50;

/// 즐겨찾기한 지역 (`GET /api/me/favorites` 의 `regions[]`).
@freezed
abstract class FavoriteRegion with _$FavoriteRegion {
  const factory FavoriteRegion({
    required String id,
    required String name,
    required String province,
    String? photoUrl,

    /// 고른 달 기준(백엔드가 넣음)
    required MetricScores scores,
    @Default(<String>[]) List<String> tags,

    /// 메모. 예: `11월 2주 체류 예정`
    String? note,

    /// 방문 예정 월. 예: `2025-11`
    String? visitMonth,
    required String addedAt,
  }) = _FavoriteRegion;

  factory FavoriteRegion.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRegionFromJson(json);
}

@freezed
abstract class FavoriteSigungu with _$FavoriteSigungu {
  const factory FavoriteSigungu({required String id, required String name}) =
      _FavoriteSigungu;

  factory FavoriteSigungu.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSigunguFromJson(json);
}

/// 즐겨찾기한 행정동 (`GET /api/me/favorites` 의 `dongs[]`).
@freezed
abstract class FavoriteDong with _$FavoriteDong {
  const factory FavoriteDong({
    required String id,
    required String name,
    required DongKind kind,
    required FavoriteSigungu sigungu,
    required MetricScores scores,
    required String addedAt,
  }) = _FavoriteDong;

  factory FavoriteDong.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDongFromJson(json);
}

@freezed
abstract class FavoritesResponse with _$FavoritesResponse {
  const factory FavoritesResponse({
    required String month,
    @Default(<FavoriteRegion>[]) List<FavoriteRegion> regions,
    @Default(<FavoriteDong>[]) List<FavoriteDong> dongs,
  }) = _FavoritesResponse;

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritesResponseFromJson(json);
}

/// `GET /api/me/favorites/ids` — 하트 상태를 그릴 때 쓰는 가벼운 응답.
@freezed
abstract class FavoriteIds with _$FavoriteIds {
  const FavoriteIds._();

  const factory FavoriteIds({
    @Default(<String>[]) List<String> regions,
    @Default(<String>[]) List<String> dongs,
  }) = _FavoriteIds;

  factory FavoriteIds.fromJson(Map<String, dynamic> json) =>
      _$FavoriteIdsFromJson(json);

  List<String> of(FavoriteKind kind) => switch (kind) {
    FavoriteKind.regions => regions,
    FavoriteKind.dongs => dongs,
  };

  bool contains(FavoriteKind kind, String id) => of(kind).contains(id);

  int get total => regions.length + dongs.length;

  /// [id] 를 넣거나(`saved`) 뺀 새 값. 넣을 때는 맨 뒤에 붙입니다.
  FavoriteIds withSaved(FavoriteKind kind, String id, {required bool saved}) {
    final rest = [
      for (final x in of(kind))
        if (x != id) x,
    ];
    final next = saved ? [...rest, id] : rest;
    return switch (kind) {
      FavoriteKind.regions => copyWith(regions: next),
      FavoriteKind.dongs => copyWith(dongs: next),
    };
  }
}

@freezed
abstract class StayCount with _$StayCount {
  const factory StayCount({required String regionName, required int count}) =
      _StayCount;

  factory StayCount.fromJson(Map<String, dynamic> json) =>
      _$StayCountFromJson(json);
}

/// `GET /api/me/summary` — 프로필 요약과 활동 통계.
@freezed
abstract class MeSummary with _$MeSummary {
  const factory MeSummary({
    @Default(<StayCount>[]) List<StayCount> stays,
    required int tipCount,
    required int photoCount,
    required int favoriteCount,
    required int voteCount,
    required String createdAt,
  }) = _MeSummary;

  factory MeSummary.fromJson(Map<String, dynamic> json) =>
      _$MeSummaryFromJson(json);
}

enum TipTargetKind { region, dong }

@freezed
abstract class MyTipTarget with _$MyTipTarget {
  const factory MyTipTarget({
    required TipTargetKind kind,
    required String id,
    required String name,
  }) = _MyTipTarget;

  factory MyTipTarget.fromJson(Map<String, dynamic> json) =>
      _$MyTipTargetFromJson(json);
}

@freezed
abstract class TipAuthor with _$TipAuthor {
  const factory TipAuthor({required String nickname, required String initial}) =
      _TipAuthor;

  factory TipAuthor.fromJson(Map<String, dynamic> json) =>
      _$TipAuthorFromJson(json);
}

/// 내가 쓴 팁 (`GET /api/me/tips` 의 `items[]`).
@freezed
abstract class MyTip with _$MyTip {
  const factory MyTip({
    required String id,
    required TipAuthor author,
    required String createdAt,
    String? dongName,

    /// 예: `2주 체류`
    String? stayLabel,
    String? visitMonth,
    required String body,
    required int helpful,
    required int replies,
    required MyTipTarget target,
  }) = _MyTip;

  factory MyTip.fromJson(Map<String, dynamic> json) => _$MyTipFromJson(json);
}

@freezed
abstract class MyTipsResponse with _$MyTipsResponse {
  const factory MyTipsResponse({
    @Default(<MyTip>[]) List<MyTip> items,
    String? nextCursor,
    @Default(0) int helpfulSum,
  }) = _MyTipsResponse;

  factory MyTipsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyTipsResponseFromJson(json);
}

enum PhotoStatus { approved, pending }

/// 내가 올린 사진 (`GET /api/me/photos` 의 `items[]`).
@freezed
abstract class MyPhoto with _$MyPhoto {
  const factory MyPhoto({
    required String id,
    required String url,

    /// 예: `2025-10`
    required String month,
    required String regionName,
    required PhotoStatus status,
  }) = _MyPhoto;

  factory MyPhoto.fromJson(Map<String, dynamic> json) =>
      _$MyPhotoFromJson(json);
}

@freezed
abstract class MyPhotosResponse with _$MyPhotosResponse {
  const factory MyPhotosResponse({@Default(<MyPhoto>[]) List<MyPhoto> items}) =
      _MyPhotosResponse;

  factory MyPhotosResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPhotosResponseFromJson(json);
}

/// `GET · PATCH /api/me/settings` — 알림 설정 3개.
@freezed
abstract class MeSettings with _$MeSettings {
  const factory MeSettings({
    required bool notifyBestMonth,
    required bool notifyTipReaction,
    required bool notifyPhotoSelected,
  }) = _MeSettings;

  factory MeSettings.fromJson(Map<String, dynamic> json) =>
      _$MeSettingsFromJson(json);
}
