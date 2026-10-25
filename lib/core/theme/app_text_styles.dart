import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 텍스트 스타일 — Figma 01 Foundations 의 로컬 텍스트 스타일 20개와 1:1.
/// 색은 기본 잉크(text/primary)이며 필요 시 `copyWith(color: …)` 로 바꿉니다.
abstract final class AppTextStyles {
  static const String sans = 'Noto Sans KR';
  static const String display = 'Black Han Sans';
  static const String hand = 'Gaegu';

  static const TextStyle _base = TextStyle(
    fontFamily: sans,
    color: AppSemantic.textPrimary,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle _s(double size, double lineHeight, FontWeight weight) =>
      _base.copyWith(
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
      );

  // display — Black Han Sans 는 로고·히어로·공유 카드 제목에만
  static final displayHero = _s(
    40,
    44,
    FontWeight.w400,
  ).copyWith(fontFamily: display);
  static final displayLogo = _s(
    22,
    28,
    FontWeight.w400,
  ).copyWith(fontFamily: display);
  static final display3xl = _s(30, 36, FontWeight.w700);

  // heading
  static final heading2xl = _s(24, 32, FontWeight.w700);
  static final headingXl = _s(20, 28, FontWeight.w700);
  static final headingLg = _s(18, 28, FontWeight.w700);

  // title
  static final titleMd = _s(16, 20, FontWeight.w500);

  // body
  static final bodyBase = _s(16, 24, FontWeight.w400);
  static final bodyBaseMedium = _s(16, 24, FontWeight.w500);
  static final bodySm = _s(14, 20, FontWeight.w400);
  static final bodySmMedium = _s(14, 20, FontWeight.w500);
  static final bodySmBold = _s(14, 20, FontWeight.w700);

  // caption
  static final captionXs = _s(12, 16, FontWeight.w400);
  static final captionXsMedium = _s(12, 16, FontWeight.w500);
  static final captionXsBold = _s(12, 16, FontWeight.w700);
  static final captionSegment = _s(12, 16, FontWeight.w500);
  static final captionBadge = _s(11, 13, FontWeight.w700);

  // number — 숫자는 잉크색. 종합 점수(ScoreDisplay)만 64px
  static final numberRating = _s(64, 70, FontWeight.w700);
  static final number4xl = _s(36, 40, FontWeight.w700);
  static final number2xl = _s(24, 28, FontWeight.w700);

  /// Material TextTheme 매핑. 위젯 기본값(AppBar 제목, ListTile 등)에 적용됩니다.
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayHero,
    displayMedium: number4xl,
    displaySmall: display3xl,
    headlineLarge: heading2xl,
    headlineMedium: headingXl,
    headlineSmall: headingLg,
    titleLarge: headingLg,
    titleMedium: titleMd,
    titleSmall: bodySmMedium,
    bodyLarge: bodyBase,
    bodyMedium: bodySm,
    bodySmall: captionXs,
    labelLarge: bodySmMedium,
    labelMedium: captionSegment,
    labelSmall: captionBadge,
  );
}
