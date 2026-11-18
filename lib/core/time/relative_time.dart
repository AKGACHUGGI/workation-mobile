/// `3일 전` · `2개월 전` · `방금` (웹 `region/relativeTime.ts` 와 같음).
String relativeTime(String iso, {DateTime? now}) {
  final at = DateTime.tryParse(iso);
  if (at == null) return '';
  final diff = (now ?? DateTime.now()).difference(at);
  const day = Duration(days: 1);
  if (diff < const Duration(hours: 1)) return '방금';
  if (diff < day) return '${diff.inHours}시간 전';
  if (diff < const Duration(days: 30)) return '${diff.inDays}일 전';
  if (diff < const Duration(days: 365)) return '${diff.inDays ~/ 30}개월 전';
  return '${diff.inDays ~/ 365}년 전';
}
