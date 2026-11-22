/// 월 파라미터. API 는 `2025-10` 또는 `annual`(연간) 문자열을 씁니다 (웹 `metric/month.ts` 와 같음).
abstract final class Months {
  /// 데이터 범위. 백엔드 메타 API 가 생기면 그 값으로 바꿉니다.
  static const dataYear = 2025;

  static const annual = 'annual';

  /// 데이터의 마지막 달. 연간 화면의 체감 투표 · 이달의 사진이 붙는 달입니다
  /// (웹의 기본 월과 같아, 웹과 같은 투표 · 사진을 봅니다).
  static const latest = '2025-12';

  /// [date] 의 달을 데이터 연도의 같은 달로 옮깁니다. 2026-11-22 → `2025-11`
  static String ofDate(DateTime date) => of(date.month);

  /// 연간 + 12개월. 월 선택 순서와 같습니다.
  static final all = <String>[annual, for (var m = 1; m <= 12; m++) of(m)];

  /// 10 → `2025-10`
  static String of(int month) =>
      '$dataYear-${month.toString().padLeft(2, '0')}';

  /// `2025-10` → 10, `annual` → null
  static int? numberOf(String month) =>
      month == annual ? null : int.tryParse(month.substring(5));

  /// `2025-10` → `10월`, `annual` → `연간`
  static String label(String month) {
    final n = numberOf(month);
    return n == null ? '연간' : '$n월';
  }
}
