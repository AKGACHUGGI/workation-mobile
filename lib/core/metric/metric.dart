import 'package:json_annotation/json_annotation.dart';

/// 핵심 지표 5종. 라벨 · 프리셋 · 등급 규칙은 웹(workation-web `src/features/metric`)과 같습니다.
enum MetricKey {
  quiet('동네 조용함', '조용'),
  crowd('시기 여유', '시기'),
  peer('또래 밀도', '또래'),
  overnight('숙박 성향', '숙박'),
  vibe('저녁 활기', '활기');

  const MetricKey(this.label, this.shortLabel);

  /// 화면 라벨. 예: `동네 조용함`
  final String label;

  /// 카드 세부 등급 줄에 쓰는 짧은 라벨. 예: `조용`
  final String shortLabel;
}

/// 등급 S · A · B · C.
enum Grade {
  @JsonValue('S')
  s('S'),
  @JsonValue('A')
  a('A'),
  @JsonValue('B')
  b('B'),
  @JsonValue('C')
  c('C');

  const Grade(this.label);

  final String label;
}

/// 종합 점수 프리셋.
enum PresetKey {
  quiet('조용한 곳'),
  lively('활기 있는 한 달'),
  custom('직접 설정');

  const PresetKey(this.label);

  final String label;
}

/// 지표별 가중치(0 이상).
class Weights {
  const Weights({
    required this.quiet,
    required this.crowd,
    required this.peer,
    required this.overnight,
    required this.vibe,
  });

  /// 조용한 곳 프리셋.
  static const quietPreset = Weights(
    quiet: 3,
    crowd: 3,
    peer: 1,
    overnight: 1,
    vibe: 0,
  );

  /// 활기 있는 한 달 프리셋.
  static const livelyPreset = Weights(
    quiet: 0,
    crowd: 1,
    peer: 3,
    overnight: 2,
    vibe: 3,
  );

  final double quiet;
  final double crowd;
  final double peer;
  final double overnight;
  final double vibe;

  double operator [](MetricKey key) => switch (key) {
    MetricKey.quiet => quiet,
    MetricKey.crowd => crowd,
    MetricKey.peer => peer,
    MetricKey.overnight => overnight,
    MetricKey.vibe => vibe,
  };
}

/// 개별 지표 등급. 점수가 이미 백분위(0~100)라 고정 경계를 씁니다.
Grade metricGrade(num score) {
  if (score >= 75) return Grade.s;
  if (score >= 50) return Grade.a;
  if (score >= 25) return Grade.b;
  return Grade.c;
}

/// 가중 평균. [scoreOf] 는 지표별 점수(0~100)를 돌려줍니다.
/// 가중치 합이 0 이면 0 입니다.
double composite(double Function(MetricKey key) scoreOf, Weights weights) {
  var sum = 0.0;
  var total = 0.0;
  for (final key in MetricKey.values) {
    sum += scoreOf(key) * weights[key];
    total += weights[key];
  }
  return total == 0 ? 0 : sum / total;
}

/// 사분위 등급. 값을 내림차순으로 순위 매긴 뒤 순위 비율로
/// 상위 25% S, 50% A, 75% B, 그 외 C. 동점은 같은(더 높은) 순위를 받습니다.
/// 결과는 입력 순서를 유지합니다.
List<Grade> toGrades(List<double> values) {
  final n = values.length;
  if (n == 0) return const [];
  final sorted = [...values]..sort((a, b) => b.compareTo(a));
  return [
    for (final v in values)
      switch (sorted.indexOf(v) / n) {
        < 0.25 => Grade.s,
        < 0.5 => Grade.a,
        < 0.75 => Grade.b,
        _ => Grade.c,
      },
  ];
}
