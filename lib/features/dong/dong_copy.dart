import '../../core/metric/metric.dart';
import '../../data/models/dong_detail.dart';
import '../../data/models/region_detail.dart';

/// 최대 비중 유형. 동점이면 [ActivityKey.values] 앞쪽(웹 `dominantActivity` 와 같음).
ActivityKey dominantActivity(Map<String, int> mix) {
  var best = ActivityKey.values.first;
  for (final key in ActivityKey.values) {
    if ((mix[key.name] ?? 0) > (mix[best.name] ?? 0)) best = key;
  }
  return best;
}

/// 제목 아래 한 줄 요약 (웹 `dong/summary.ts` 의 `buildDongSummary` 와 같은 문장).
String buildDongSummary({
  required ActivityKey dominant,
  required int weekdayPeakHour,
  required Grade vibeGrade,
  required DongKind kind,
}) {
  final h = weekdayPeakHour;
  switch (dominant) {
    case ActivityKey.weekendTourist:
      final evening = vibeGrade == Grade.s || vibeGrade == Grade.a
          ? '저녁까지 활기가 이어집니다'
          : '저녁엔 일찍 조용해집니다';
      return '주말에 사람이 몰리고 평일 낮 $h시가 피크인 ${kind.label} 동네, $evening';
    case ActivityKey.eveningDowntown:
      return '저녁 $h시에 가장 붐비는 상권형 동네, 낮엔 상대적으로 조용합니다';
    case ActivityKey.weekdayWork:
      return '평일 낮 $h시에 붐비고 주말엔 한산한 업무형 동네';
    case ActivityKey.dawnResidential:
      return '아침·밤에 사람이 있고 낮엔 비는 주거형 동네, 일하기엔 가장 조용합니다';
  }
}

/// 생활권 지수는 티어 지표가 아니라 고정 경계(≥70 A, ≥50 B, 그 외 C)입니다.
Grade localLifeGrade(int v) => v >= 70
    ? Grade.a
    : v >= 50
    ? Grade.b
    : Grade.c;

/// 70 이상 생활권, 50 이상 혼합, 그 밖은 방문지.
String localLifeLabel(int v) => v >= 70
    ? '생활권'
    : v >= 50
    ? '혼합'
    : '방문지';

/// 체감 투표 질문. 저녁 활기가 S · A 면 활기, 아니면 조용함을 묻습니다.
String dongPollQuestion(String name, Grade vibeGrade) =>
    vibeGrade == Grade.s || vibeGrade == Grade.a
    ? '$name 저녁, 정말 활기찬가요?'
    : '$name 저녁, 정말 조용한가요?';
