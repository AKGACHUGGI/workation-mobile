import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'month.dart';

/// 오늘 날짜(기기 시각). 테스트에서는 override 해서 고정합니다.
/// 앱을 켠 때의 값을 쓰고, 켜 둔 채 달이 바뀌어도 다시 읽지 않습니다.
final todayProvider = Provider<DateTime>((ref) => DateTime.now());

/// 기본 달: 오늘의 달(`2025-11` 같은 데이터 연도의 같은 달).
/// 홈 · 지역 상세에는 달을 고르는 UI 가 없어, 달을 말하지 않고 들어오면 이 달 기준으로 봅니다.
/// 지도 탭 · 동네 화면도 여기서 시작해 사용자가 바꿉니다.
final defaultMonthProvider = Provider<String>(
  (ref) => Months.ofDate(ref.watch(todayProvider)),
);
