import '../../data/models/region_detail.dart';

/// `[2, 3]` → `2 · 3월`. 비어 있으면 `—` (웹 `region/format.ts`).
String formatMonths(List<int> months) =>
    months.isEmpty ? '—' : '${months.join(' · ')}월';

/// 고른 달들의 혼잡 지수 범위. 예: `혼잡 80~100`, 값이 하나면 `혼잡 41`.
String crowdRange(List<MonthCrowd> months, List<int> picked) {
  final values = [
    for (final m in months)
      if (picked.contains(m.month)) m.crowd,
  ]..sort();
  if (values.isEmpty) return '혼잡 —';
  return values.first == values.last
      ? '혼잡 ${values.first}'
      : '혼잡 ${values.first}~${values.last}';
}

/// 주말 ÷ 주중 낮 체류 비율 설명 (웹 `region/copy.ts` weekendSentence 와 같은 구간).
String weekendSentence(double ratio) {
  final p = ((ratio - 1) * 100).round();
  if (ratio < 0.9) {
    return '주말에 낮 체류인구가 ${p.abs()}% 줄어듭니다. 주말이 오히려 한산한 지역입니다.';
  }
  if (ratio < 1.15) {
    final verb = p >= 0 ? '늘어나는' : '줄어드는';
    return '주말에 낮 체류인구가 ${p.abs()}% $verb 수준으로 주중·주말 차이가 작습니다. '
        '요일과 상관없이 비슷한 밀도를 기대할 수 있습니다.';
  }
  return '주말에 낮 체류인구가 $p% 늘어납니다. '
      '조용한 체류가 목적이면 주중 도착·주말 외곽 동네 이동을 권합니다.';
}

/// 행정동 줄의 설명. 예: `거진항 · 8월 피크의 72%`
/// 고른 달 혼잡이 그 동의 가장 붐비는 달(피크)의 몇 %인지입니다. 줄이 좁아 웹보다 짧게 씁니다.
/// [month] 는 고른 달 숫자(연간이면 null), [monthLabel] 은 `10월` · `연간`.
String dongCaption(
  RegionDong dong, {
  required int? month,
  required String monthLabel,
}) {
  final peak = month != null && dong.peakMonth == month
      ? '$monthLabel이 피크'
      : '${dong.peakMonth}월 피크의 ${dong.crowdOfPeak}%';
  return '${dong.landmark} · $peak';
}
