import 'package:freezed_annotation/freezed_annotation.dart';

import 'region_detail.dart';

part 'dong_detail.freezed.dart';
part 'dong_detail.g.dart';

@freezed
abstract class DongRef with _$DongRef {
  const factory DongRef({required String id, required String name}) = _DongRef;

  factory DongRef.fromJson(Map<String, dynamic> json) =>
      _$DongRefFromJson(json);
}

/// 동네 원 지표(웹 `DongDetailResponse.stats` 와 같음).
@freezed
abstract class DongStats with _$DongStats {
  const factory DongStats({
    /// 평일 낮 체류 ÷ 새벽 체류
    required double dayInflow,

    /// (거주+근무) ÷ 전체 × 100, 정수
    required int localLife,

    /// 20~40대 방문 비율 %
    required int peerShare,

    /// 평일 저녁 보행 ÷ 평일 저녁 체류
    required double eveningVibe,

    /// 실제 ÷ 예측 저녁 보행
    required double eveningSurplus,
  }) = _DongStats;

  factory DongStats.fromJson(Map<String, dynamic> json) =>
      _$DongStatsFromJson(json);
}

/// 행정동 전체 중 백분위(0~100). 웹은 `/api/tier` 에서 따로 받지만 앱은 상세 응답에 함께 받습니다.
@freezed
abstract class DongScores with _$DongScores {
  const factory DongScores({
    required double quiet,
    required double vibe,
    required double peer,
  }) = _DongScores;

  factory DongScores.fromJson(Map<String, dynamic> json) =>
      _$DongScoresFromJson(json);
}

/// 24시간 보행 곡선. 길이 24, 0~100, 두 배열 중 최대 = 100.
@freezed
abstract class Hourly with _$Hourly {
  const factory Hourly({
    required List<int> weekday,
    required List<int> weekend,
  }) = _Hourly;

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}

@freezed
abstract class Peak with _$Peak {
  const factory Peak({
    required int peakHour,
    required int lowHour,
    required int lowValue,
  }) = _Peak;

  factory Peak.fromJson(Map<String, dynamic> json) => _$PeakFromJson(json);
}

@freezed
abstract class Peaks with _$Peaks {
  const factory Peaks({required Peak weekday, required Peak weekend}) = _Peaks;

  factory Peaks.fromJson(Map<String, dynamic> json) => _$PeaksFromJson(json);
}

/// 동네 성격 4유형 비중(합 100).
enum ActivityKey {
  eveningDowntown('저녁 상권형'),
  weekendTourist('주말 관광형'),
  weekdayWork('평일 업무형'),
  dawnResidential('새벽 주거형');

  const ActivityKey(this.label);

  final String label;
}

/// `GET /api/dongs/{id}?month=` 중 모바일이 쓰는 부분.
/// (웹 응답의 `quieterTwins` · `bbox` 는 읽지 않습니다. 지도 · 비교는 웹 전용입니다.)
@freezed
abstract class DongDetail with _$DongDetail {
  const factory DongDetail({
    required String id,
    required String name,
    required DongRef sigungu,
    required String province,
    required DongKind kind,
    @Default(<String>[]) List<String> tags,
    @Default(<RegionPhoto>[]) List<RegionPhoto> photos,
    @Default(<String>[]) List<String> landmarks,

    /// 예: `강릉시 북부 · 바닷가 0.0km`
    @Default('') String accessNote,
    required String month,
    required DongStats stats,

    /// 특수시설 동처럼 집계에서 빠지면 null
    DongScores? scores,

    /// 백분위를 매긴 행정동 수(특수시설 제외)
    @Default(0) int dongCount,
    required Hourly hourly,
    required Peaks peaks,

    /// 키는 [ActivityKey.name]
    @Default(<String, int>{}) Map<String, int> activityMix,
    required SeasonType seasonType,
  }) = _DongDetail;

  factory DongDetail.fromJson(Map<String, dynamic> json) =>
      _$DongDetailFromJson(json);
}
