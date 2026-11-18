import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_detail.freezed.dart';
part 'region_detail.g.dart';

/// 계절 유형(월별 방문 패턴 분류). 라벨은 웹 `region/copy.ts` 와 같습니다.
enum SeasonType {
  @JsonValue('summer_beach')
  summerBeach('여름 해변형'),
  @JsonValue('spring_autumn')
  springAutumn('봄·가을형'),
  @JsonValue('second_half_rise')
  secondHalfRise('하반기 상승형'),
  @JsonValue('flat')
  flat('연중 평탄형');

  const SeasonType(this.label);

  final String label;
}

/// 행정동 성격(수동 관리).
enum DongKind {
  living('생활권'),
  tourist('관광지');

  const DongKind(this.label);

  final String label;
}

@freezed
abstract class RegionPhoto with _$RegionPhoto {
  const factory RegionPhoto({required String url, String? credit}) =
      _RegionPhoto;

  factory RegionPhoto.fromJson(Map<String, dynamic> json) =>
      _$RegionPhotoFromJson(json);
}

/// 고른 달의 원 지표.
@freezed
abstract class RegionStats with _$RegionStats {
  const factory RegionStats({
    /// 해당 월 방문 ÷ 연중 최대 × 100 (연간이면 평균)
    required int crowdIndex,

    /// 평일 낮 체류 ÷ 새벽 체류
    required double dayInflow,

    /// 낮 유입 지수 오름차순 순위(시군구 중)
    required int quietRank,

    /// 20~40대 방문 비율 %
    required int peerShare,

    /// 숙박 계수
    required double overnightCoef,

    /// 주말 낮 체류 ÷ 주중 낮 체류
    required double weekendRatio,
  }) = _RegionStats;

  factory RegionStats.fromJson(Map<String, dynamic> json) =>
      _$RegionStatsFromJson(json);
}

/// 월별 혼잡 지수 한 칸. [crowd] 는 0~100(연중 최대 = 100).
@freezed
abstract class MonthCrowd with _$MonthCrowd {
  const factory MonthCrowd({required int month, required int crowd}) =
      _MonthCrowd;

  factory MonthCrowd.fromJson(Map<String, dynamic> json) =>
      _$MonthCrowdFromJson(json);
}

/// 지역 상세의 행정동 한 줄.
@freezed
abstract class RegionDong with _$RegionDong {
  const factory RegionDong({
    /// 행정동 코드 10자리
    required String id,
    required String name,
    required DongKind kind,

    /// 예: `거진항`
    required String landmark,

    /// 전체 행정동 중 낮 유입 지수 백분위 0~100
    required double quietScore,

    /// 동 자체 혼잡이 가장 높은 달
    required int peakMonth,

    /// 고른 달 혼잡 ÷ 자체 최대 × 100
    required int crowdOfPeak,
  }) = _RegionDong;

  factory RegionDong.fromJson(Map<String, dynamic> json) =>
      _$RegionDongFromJson(json);
}

/// 집계에서 뺀 행정동. [reason] 은 `special_facility` · `masked`.
@freezed
abstract class ExcludedDong with _$ExcludedDong {
  const factory ExcludedDong({required String name, required String reason}) =
      _ExcludedDong;

  factory ExcludedDong.fromJson(Map<String, dynamic> json) =>
      _$ExcludedDongFromJson(json);
}

/// 외부 링크. [kind] 는 `support` · `stay` · `tour` (M-03c 정보 탭에서 씁니다).
@freezed
abstract class RegionLink with _$RegionLink {
  const factory RegionLink({
    required String kind,
    required String title,
    required String url,
  }) = _RegionLink;

  factory RegionLink.fromJson(Map<String, dynamic> json) =>
      _$RegionLinkFromJson(json);
}

/// `GET /api/regions/{id}?month=` (웹 W-03 과 같은 응답).
/// 월별 막대와 행정동 목록이 한 응답에 같이 옵니다.
@freezed
abstract class RegionDetail with _$RegionDetail {
  const factory RegionDetail({
    required String id,
    required String name,
    required String province,
    @Default(<String>[]) List<String> tags,
    required SeasonType seasonType,
    @Default(<RegionPhoto>[]) List<RegionPhoto> photos,
    required String month,
    required RegionStats stats,

    /// 1~12월
    required List<MonthCrowd> months,

    /// 혼잡이 가장 낮은 두 달
    @Default(<int>[]) List<int> bestMonths,

    /// 혼잡이 가장 높은 두 달
    @Default(<int>[]) List<int> avoidMonths,

    /// 또래 비중은 높고 혼잡은 낮은 두 달
    @Default(<int>[]) List<int> peerOffpeakMonths,
    @Default(<RegionDong>[]) List<RegionDong> dongs,
    @Default(<ExcludedDong>[]) List<ExcludedDong> excludedDongs,
    @Default(<RegionLink>[]) List<RegionLink> links,
  }) = _RegionDetail;

  factory RegionDetail.fromJson(Map<String, dynamic> json) =>
      _$RegionDetailFromJson(json);
}
