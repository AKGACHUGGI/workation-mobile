import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/format.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/metric/month.dart';

void main() {
  test('metricGrade 는 75 · 50 · 25 를 경계로 S · A · B · C 를 준다', () {
    expect(metricGrade(75), Grade.s);
    expect(metricGrade(74.9), Grade.a);
    expect(metricGrade(50), Grade.a);
    expect(metricGrade(25), Grade.b);
    expect(metricGrade(24), Grade.c);
  });

  test('composite 는 가중 평균이고 가중치 합이 0 이면 0 이다', () {
    const scores = {
      MetricKey.quiet: 55.0,
      MetricKey.crowd: 37.0,
      MetricKey.peer: 48.0,
      MetricKey.overnight: 76.0,
      MetricKey.vibe: 30.0,
    };
    // 고성군 10월 · 조용한 곳 프리셋 = 50 (Figma M-01 카드 값)
    expect(composite((k) => scores[k]!, Weights.quietPreset), 50);
    expect(
      composite(
        (k) => scores[k]!,
        const Weights(quiet: 0, crowd: 0, peer: 0, overnight: 0, vibe: 0),
      ),
      0,
    );
  });

  test('toGrades 는 사분위로 나누고 동점은 같은 등급을 준다', () {
    expect(toGrades([10, 40, 30, 20]), [Grade.c, Grade.s, Grade.a, Grade.b]);
    expect(toGrades([5, 5, 1, 1]), [Grade.s, Grade.s, Grade.b, Grade.b]);
    expect(toGrades([]), isEmpty);
  });

  test('formatCount 는 천 · 만 단위로 줄인다', () {
    expect(formatCount(988), '988');
    expect(formatCount(1284), '1.2천');
    expect(formatCount(8000), '8천');
    expect(formatCount(11200), '1.1만');
  });

  test('Months 는 월 문자열과 라벨을 바꾼다', () {
    expect(Months.of(3), '2025-03');
    expect(Months.numberOf('2025-10'), 10);
    expect(Months.label('2025-10'), '10월');
    expect(Months.label(Months.annual), '연간');
    expect(Months.all, hasLength(13));
  });
}
