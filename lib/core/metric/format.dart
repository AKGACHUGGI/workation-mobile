/// 소수 1자리 버림, `.0` 생략.
String _trim1(double v) {
  final t = (v * 10).floor() / 10;
  return t == t.roundToDouble() ? t.toStringAsFixed(0) : t.toStringAsFixed(1);
}

/// 1,000 미만 그대로 · 1,000 이상 `X.Y천` · 10,000 이상 `X.Y만` (웹 `popular/format.ts` 와 같음).
String formatCount(int n) {
  if (n < 1000) return '$n';
  if (n < 10000) return '${_trim1(n / 1000)}천';
  return '${_trim1(n / 10000)}만';
}
