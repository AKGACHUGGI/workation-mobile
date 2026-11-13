import 'package:flutter/material.dart';

/// 원시 색상 — Figma 01 Foundations > Tokens > primitive/*.
/// 위젯에서 직접 쓰지 않고 [AppSemantic] 또는 `Theme.of(context).colorScheme` 을 통해 사용합니다.
abstract final class AppPalette {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const rausch50 = Color(0xFFFFF1F3);
  static const rausch100 = Color(0xFFFFD1DA);
  static const rausch200 = Color(0xFFFFA6B6);
  static const rausch300 = Color(0xFFFF7A92);
  static const rausch400 = Color(0xFFFF5675);
  static const rausch500 = Color(0xFFFF385C);
  static const rausch600 = Color(0xFFE00B41);
  static const rausch700 = Color(0xFFC0083A);
  static const rausch800 = Color(0xFF9A0630);
  static const rausch900 = Color(0xFF70051F);

  static const gray50 = Color(0xFFF7F7F7);
  static const gray100 = Color(0xFFF2F2F2);
  static const gray200 = Color(0xFFEBEBEB);
  static const gray300 = Color(0xFFDDDDDD);
  static const gray400 = Color(0xFFC1C1C1);
  static const gray500 = Color(0xFF929292);
  static const gray600 = Color(0xFF6A6A6A);
  static const gray700 = Color(0xFF3F3F3F);
  static const gray800 = Color(0xFF222222);
  static const gray900 = Color(0xFF111111);

  static const babu50 = Color(0xFFE0F5F3);
  static const babu400 = Color(0xFF4FC3B8);
  static const babu600 = Color(0xFF00A699);

  static const green50 = Color(0xFFE6F4E6);
  static const green600 = Color(0xFF008A05);

  static const arches50 = Color(0xFFFFECE4);
  static const arches500 = Color(0xFFFC642D);
  static const arches600 = Color(0xFFE0511F);

  static const error50 = Color(0xFFFBE9E7);
  static const error500 = Color(0xFFC13515);

  static const legalLink = Color(0xFF428BFF);
}

/// 의미 토큰 — Figma Tokens 의 bg/* text/* border/* brand/* selected/* accent/* grade/* signal/* chart/* heat/* 와 1:1.
/// ColorScheme 에 자리가 있는 것은 [AppTheme] 에서 매핑하고, 없는 것(grade·signal·chart·heat 등)은
/// [AppSemanticColors] ThemeExtension 으로 노출합니다. 두 곳 모두 이 상수를 참조합니다.
abstract final class AppSemantic {
  // bg/*
  static const bgPage = AppPalette.white;
  static const bgSurface = AppPalette.white;
  static const bgSubtle = AppPalette.gray50;
  static const bgSurfaceStrong = AppPalette.gray100;
  static const bgInverse = AppPalette.gray800;

  // text/*
  static const textPrimary = AppPalette.gray800;
  static const textSecondary = AppPalette.gray600;
  static const textTertiary = AppPalette.gray500;
  static const textInverse = AppPalette.white;
  static const textBrand = AppPalette.rausch500;

  // border/*
  static const borderDefault = AppPalette.gray300;
  static const borderStrong = AppPalette.gray400;

  // brand/* — 검색 오브, 화면당 CTA 1개, 저장 상태에만
  static const brandPrimary = AppPalette.rausch500;
  static const brandHover = AppPalette.rausch600;
  static const brandSoft = AppPalette.rausch50;
  static const brandSoftBorder = AppPalette.rausch100;

  // selected/* — 칩·세그먼트·탭 선택 상태는 잉크
  static const selectedBg = AppPalette.gray800;
  static const selectedFg = AppPalette.white;

  // accent/*
  static const accentSave = AppPalette.rausch500;

  // grade/*
  static const gradeSFg = AppPalette.babu600;
  static const gradeSBg = AppPalette.babu50;
  static const gradeAFg = AppPalette.green600;
  static const gradeABg = AppPalette.green50;
  static const gradeBFg = AppPalette.arches600;
  static const gradeBBg = AppPalette.arches50;
  static const gradeCFg = AppPalette.gray600;
  static const gradeCBg = AppPalette.gray100;

  // signal/*
  static const signalGood = AppPalette.green600;
  static const signalGoodBg = AppPalette.green50;
  static const signalAvoid = AppPalette.error500;
  static const signalAvoidBg = AppPalette.error50;

  // chart/*
  static const chartBar = AppPalette.gray800;
  static const chartBarMuted = AppPalette.gray300;
  static const chartWeekday = AppPalette.gray800;
  static const chartWeekend = AppPalette.rausch500;
  static const chartGrid = AppPalette.gray200;

  // heat/100~700
  static const heat = [
    AppPalette.rausch100,
    AppPalette.rausch200,
    AppPalette.rausch300,
    AppPalette.rausch400,
    AppPalette.rausch500,
    AppPalette.rausch600,
    AppPalette.rausch700,
  ];

  // explore/fact/* — 지도 탐색 사실 점(유형 · 바닷가 · 생활권/관광지). 웹 --color-explore-fact-* 와 같음
  static const factType = AppPalette.arches500;
  static const factCoast = AppPalette.babu600;
  static const factLife = AppPalette.green600;

  // scrim — 50% 로 사용
  static const scrim = AppPalette.black;
}

/// 등급 배지 색 쌍.
class GradeColors {
  const GradeColors({required this.fg, required this.bg});
  final Color fg;
  final Color bg;
}

/// ColorScheme 으로 표현되지 않는 의미 토큰. `Theme.of(context).extension<AppSemanticColors>()!` 로 접근합니다.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.textTertiary,
    required this.bgSubtle,
    required this.bgSurfaceStrong,
    required this.brandHover,
    required this.brandSoft,
    required this.brandSoftBorder,
    required this.accentSave,
    required this.gradeS,
    required this.gradeA,
    required this.gradeB,
    required this.gradeC,
    required this.signalGood,
    required this.signalGoodBg,
    required this.signalAvoid,
    required this.signalAvoidBg,
    required this.chartBar,
    required this.chartBarMuted,
    required this.chartWeekday,
    required this.chartWeekend,
    required this.chartGrid,
    required this.heat,
    required this.factType,
    required this.factCoast,
    required this.factLife,
    required this.legalLink,
  });

  static const light = AppSemanticColors(
    textTertiary: AppSemantic.textTertiary,
    bgSubtle: AppSemantic.bgSubtle,
    bgSurfaceStrong: AppSemantic.bgSurfaceStrong,
    brandHover: AppSemantic.brandHover,
    brandSoft: AppSemantic.brandSoft,
    brandSoftBorder: AppSemantic.brandSoftBorder,
    accentSave: AppSemantic.accentSave,
    gradeS: GradeColors(fg: AppSemantic.gradeSFg, bg: AppSemantic.gradeSBg),
    gradeA: GradeColors(fg: AppSemantic.gradeAFg, bg: AppSemantic.gradeABg),
    gradeB: GradeColors(fg: AppSemantic.gradeBFg, bg: AppSemantic.gradeBBg),
    gradeC: GradeColors(fg: AppSemantic.gradeCFg, bg: AppSemantic.gradeCBg),
    signalGood: AppSemantic.signalGood,
    signalGoodBg: AppSemantic.signalGoodBg,
    signalAvoid: AppSemantic.signalAvoid,
    signalAvoidBg: AppSemantic.signalAvoidBg,
    chartBar: AppSemantic.chartBar,
    chartBarMuted: AppSemantic.chartBarMuted,
    chartWeekday: AppSemantic.chartWeekday,
    chartWeekend: AppSemantic.chartWeekend,
    chartGrid: AppSemantic.chartGrid,
    heat: AppSemantic.heat,
    factType: AppSemantic.factType,
    factCoast: AppSemantic.factCoast,
    factLife: AppSemantic.factLife,
    legalLink: AppPalette.legalLink,
  );

  final Color textTertiary;
  final Color bgSubtle;
  final Color bgSurfaceStrong;
  final Color brandHover;
  final Color brandSoft;
  final Color brandSoftBorder;
  final Color accentSave;
  final GradeColors gradeS;
  final GradeColors gradeA;
  final GradeColors gradeB;
  final GradeColors gradeC;
  final Color signalGood;
  final Color signalGoodBg;
  final Color signalAvoid;
  final Color signalAvoidBg;
  final Color chartBar;
  final Color chartBarMuted;
  final Color chartWeekday;
  final Color chartWeekend;
  final Color chartGrid;
  final List<Color> heat;
  final Color factType;
  final Color factCoast;
  final Color factLife;
  final Color legalLink;

  /// 'S' | 'A' | 'B' | 'C' 문자열로 등급 색을 얻습니다. 그 외 값은 C 로 취급합니다.
  GradeColors gradeOf(String grade) => switch (grade.toUpperCase()) {
    'S' => gradeS,
    'A' => gradeA,
    'B' => gradeB,
    _ => gradeC,
  };

  @override
  AppSemanticColors copyWith() => this; // Light 모드 단일. 다크 모드 추가 시 확장.

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) =>
      this;
}
