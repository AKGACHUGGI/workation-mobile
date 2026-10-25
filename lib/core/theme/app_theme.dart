import 'package:flutter/material.dart';

/// 디자인 토큰은 docs/디자인-원칙.md 기준으로 정의합니다.
/// 아래는 자리표시자이며 Figma Foundations 확정 후 교체합니다.
abstract final class AppColors {
  static const ink = Color(0xFF222222);
  static const hairline = Color(0xFFDDDDDD);
  static const rausch = Color(0xFFFF385C);
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.rausch,
      primary: AppColors.rausch,
      onSurface: AppColors.ink,
    ),
    scaffoldBackgroundColor: Colors.white,
    dividerColor: AppColors.hairline,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
