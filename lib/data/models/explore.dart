import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/metric/metric.dart';

part 'explore.freezed.dart';
part 'explore.g.dart';

/// 워케이션 유형 4종. 순서는 백엔드 동점 순서와 같습니다.
abstract final class WorkationTypes {
  static const immersive = '몰입형';
  static const networking = '네트워킹형';
  static const local = '로컬살이형';
  static const longStay = '장기체류형';

  static const all = [immersive, networking, local, longStay];
}

@freezed
abstract class GeoPoint with _$GeoPoint {
  const factory GeoPoint({required double lat, required double lng}) =
      _GeoPoint;

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);
}

/// 유형 하나의 점수. 동 상세에는 근거 문구([reason])가 함께 옵니다.
@freezed
abstract class TypeScore with _$TypeScore {
  const factory TypeScore({
    required String name,
    required double score,
    String? reason,
  }) = _TypeScore;

  factory TypeScore.fromJson(Map<String, dynamic> json) =>
      _$TypeScoreFromJson(json);
}

@freezed
abstract class PinGrades with _$PinGrades {
  const factory PinGrades({Grade? quiet, Grade? evening}) = _PinGrades;

  factory PinGrades.fromJson(Map<String, dynamic> json) =>
      _$PinGradesFromJson(json);
}

/// `GET /api/explore/sigungu/{id}/pins` 의 동 하나.
@freezed
abstract class PinDong with _$PinDong {
  const PinDong._();

  const factory PinDong({
    required String id,
    required String name,
    GeoPoint? center,

    /// 관광공사 동 태그 id, 백엔드 순서. 핀 아이콘은 맨 앞 것을 씁니다.
    @Default(<String>[]) List<String> tags,
    String? topType,
    double? topScore,
    @Default(false) bool coastal,

    /// `생활권` 또는 `관광지`
    String? life,
    @Default(PinGrades()) PinGrades grades,

    /// 유형 4종 점수(점수 높은 순). 백엔드 요청 중(workation-backend #16)이라 없을 수 있습니다.
    List<TypeScore>? types,
  }) = _PinDong;

  factory PinDong.fromJson(Map<String, dynamic> json) =>
      _$PinDongFromJson(json);

  /// [type] 유형 점수. [types] 가 없으면 1위 유형일 때만 [topScore] 를 돌려줍니다.
  double? scoreOf(String type) {
    final list = types;
    if (list != null) {
      for (final t in list) {
        if (t.name == type) return t.score;
      }
      return null;
    }
    return type == topType ? topScore : null;
  }
}

@freezed
abstract class PinsResponse with _$PinsResponse {
  const factory PinsResponse({
    required String sigunguId,
    required List<PinDong> dongs,
  }) = _PinsResponse;

  factory PinsResponse.fromJson(Map<String, dynamic> json) =>
      _$PinsResponseFromJson(json);
}

@freezed
abstract class SigunguRef with _$SigunguRef {
  const factory SigunguRef({required String id, required String name}) =
      _SigunguRef;

  factory SigunguRef.fromJson(Map<String, dynamic> json) =>
      _$SigunguRefFromJson(json);
}

/// `GET /api/explore/dongs/{id}` 중 모바일이 쓰는 부분.
/// (시간대 · 월별 · 비슷한 동은 웹 전용이라 읽지 않습니다.)
@freezed
abstract class ExploreDong with _$ExploreDong {
  const factory ExploreDong({
    required String id,
    required String name,
    required SigunguRef sigungu,
    required String sido,
    double? coastKm,

    /// 4개, 점수 높은 순
    @Default(<TypeScore>[]) List<TypeScore> types,

    /// 0개 또는 3개
    @Default(<String>[]) List<String> briefing,
  }) = _ExploreDong;

  factory ExploreDong.fromJson(Map<String, dynamic> json) =>
      _$ExploreDongFromJson(json);
}
