import '../../core/metric/metric.dart';
import 'region_copy.dart';

/// 추천 사유 문장 4개(웹 `region/reason.ts` 의 규칙 기반 템플릿과 같음). 2차에 LLM 문장으로 바꿉니다.
List<String> buildReason({
  required String monthLabel,
  required String presetLabel,

  /// 반올림한 종합 점수
  required int composite,
  required int rank,
  required int total,
  required Grade grade,
  required double overnightCoef,
  required double dayInflow,
  required int crowdIndex,
  required Grade crowdGrade,
  required List<int> bestMonths,
  required List<int> peerOffpeakMonths,
}) {
  final coef = overnightCoef.toStringAsFixed(2);
  final inflow = dayInflow.toStringAsFixed(2);

  final s1 =
      '$monthLabel $presetLabel 프리셋 종합 $composite점으로 $total곳 중 $rank위(${grade.label})입니다.';
  final s2 = overnightCoef >= 0.9
      ? '숙박 계수 $coef로 방문객 대부분이 밤에도 머무는 숙박형 지역이고,'
      : overnightCoef >= 0.7
      ? '숙박 계수 $coef로 숙박과 당일 방문이 섞여 있고,'
      : '숙박 계수 $coef로 당일 방문 비중이 큰 지역이고,';
  final s3 = dayInflow < 0.8
      ? '낮 유입 지수 $inflow로 근무 시간에 사람이 몰리지 않습니다.'
      : dayInflow <= 1.0
      ? '낮 유입 지수 $inflow로 낮 인구 변화가 크지 않습니다.'
      : '낮 유입 지수 $inflow로 낮에 사람이 몰리는 편입니다.';
  final s4 = crowdGrade == Grade.s || crowdGrade == Grade.a
      ? '$monthLabel은 연중 최대의 $crowdIndex%로 한산한 편입니다.'
      : '다만 $monthLabel 혼잡은 연중 최대의 $crowdIndex%로 시기 여유는 ${crowdGrade.label}입니다. '
            '더 한산한 때를 원하면 ${formatMonths(bestMonths)}, '
            '또래가 많으면서 덜 붐비는 때는 ${formatMonths(peerOffpeakMonths)}입니다.';
  return [s1, s2, s3, s4];
}

/// 숙박 계수 구간 문구.
String overnightCopy(double coef) => coef >= 0.9
    ? '방문객 대부분 숙박'
    : coef >= 0.7
    ? '숙박·당일 혼합'
    : '당일 방문 위주';

/// 백분위 구간 문구.
String rankCopy(double percentile) => percentile >= 75
    ? '상위권'
    : percentile >= 50
    ? '중상위'
    : percentile >= 25
    ? '중하위'
    : '하위권';

/// 외부 링크 종류(`support` · `stay` · `tour`)의 라벨.
String linkKindLabel(String kind) => switch (kind) {
  'support' => '지원사업',
  'stay' => '숙박',
  'tour' => '관광',
  _ => '링크',
};
