import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_text_styles.dart';

export 'app_colors.dart';
export 'app_dimens.dart';
export 'app_text_styles.dart';

/// 앱 테마 — Figma 01 Foundations Tokens(Light) 를 Material 3 ThemeData 로 매핑합니다.
/// 기준 문서: workation-docs/디자인/디자인-원칙.md
///
/// 사용 예
///   Theme.of(context).colorScheme.primary            // brand/primary
///   Theme.of(context).colorScheme.onSurface          // text/primary
///   `Theme.of(context).extension<AppSemanticColors>()!.gradeS.fg`
///   AppTextStyles.headingXl, AppRadius.xlAll, AppSpacing.s4, AppShadows.cardFloat
abstract final class AppTheme {
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    // brand/* — CTA 1개, 검색 오브, 저장 상태에만
    primary: AppSemantic.brandPrimary,
    onPrimary: AppSemantic.textInverse,
    primaryContainer: AppSemantic.brandSoft,
    onPrimaryContainer: AppPalette.rausch700,
    // selected/* — 선택 상태는 잉크
    secondary: AppSemantic.selectedBg,
    onSecondary: AppSemantic.selectedFg,
    secondaryContainer: AppSemantic.selectedBg,
    onSecondaryContainer: AppSemantic.selectedFg,
    tertiary: AppPalette.babu600,
    onTertiary: AppPalette.white,
    tertiaryContainer: AppPalette.babu50,
    onTertiaryContainer: AppPalette.babu600,
    // signal/avoid
    error: AppSemantic.signalAvoid,
    onError: AppPalette.white,
    errorContainer: AppSemantic.signalAvoidBg,
    onErrorContainer: AppSemantic.signalAvoid,
    // bg/* text/*
    surface: AppSemantic.bgSurface,
    onSurface: AppSemantic.textPrimary,
    onSurfaceVariant: AppSemantic.textSecondary,
    surfaceContainerLowest: AppPalette.white,
    surfaceContainerLow: AppSemantic.bgSubtle,
    surfaceContainer: AppSemantic.bgSurfaceStrong,
    surfaceContainerHigh: AppPalette.gray200,
    surfaceContainerHighest: AppPalette.gray300,
    surfaceDim: AppPalette.gray100,
    surfaceBright: AppPalette.white,
    inverseSurface: AppSemantic.bgInverse,
    onInverseSurface: AppSemantic.textInverse,
    inversePrimary: AppPalette.rausch200,
    // border/*
    outline: AppSemantic.borderStrong,
    outlineVariant: AppSemantic.borderDefault,
    shadow: AppPalette.black,
    scrim: AppSemantic.scrim,
    surfaceTint: Colors.transparent, // M3 틴트 비활성 — 흰 캔버스 유지
  );

  static ThemeData get light {
    final scheme = lightScheme;
    final text = AppTextStyles.textTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppTextStyles.sans,
      textTheme: text,
      scaffoldBackgroundColor: AppSemantic.bgPage,
      canvasColor: AppSemantic.bgSurface,
      dividerColor: AppSemantic.borderDefault,
      splashFactory: InkSparkle.splashFactory,
      extensions: const [AppSemanticColors.light],
      visualDensity: VisualDensity.standard,

      appBarTheme: AppBarTheme(
        backgroundColor: AppSemantic.bgSurface,
        foregroundColor: AppSemantic.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headingLg,
      ),

      // 카드: 테두리와 그림자를 동시에 쓰지 않음. 기본은 둘 다 없음(사진 라운드 클리핑만).
      cardTheme: CardThemeData(
        color: AppSemantic.bgSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      ),

      dividerTheme: const DividerThemeData(
        color: AppSemantic.borderDefault,
        thickness: 1,
        space: 1,
      ),

      // 칩: 선택 = 잉크 배경 + 흰 글자, 기본 = 헤어라인
      chipTheme: ChipThemeData(
        backgroundColor: AppSemantic.bgSurface,
        selectedColor: AppSemantic.selectedBg,
        side: const BorderSide(color: AppSemantic.borderDefault),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
        labelStyle: AppTextStyles.captionSegment,
        secondaryLabelStyle: AppTextStyles.captionSegment.copyWith(
          color: AppSemantic.selectedFg,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        showCheckmark: false,
      ),

      // 버튼: radius lg(8), 높이 48. Filled = brand(화면당 1개), Outlined = 잉크 외곽선
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppSemantic.brandPrimary,
          foregroundColor: AppSemantic.textInverse,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
          textStyle: AppTextStyles.bodySmMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppSemantic.textPrimary,
          side: const BorderSide(color: AppSemantic.textPrimary),
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
          textStyle: AppTextStyles.bodySmMedium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppSemantic.textPrimary,
          textStyle: AppTextStyles.bodySmMedium,
        ),
      ),

      // 입력: 헤어라인, 포커스는 2px 잉크(글로우 없음)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppSemantic.bgSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        hintStyle: AppTextStyles.bodySm.copyWith(
          color: AppSemantic.textTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.lgAll,
          borderSide: const BorderSide(color: AppSemantic.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.lgAll,
          borderSide: const BorderSide(color: AppSemantic.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.lgAll,
          borderSide: const BorderSide(
            color: AppSemantic.textPrimary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.lgAll,
          borderSide: const BorderSide(color: AppSemantic.signalAvoid),
        ),
      ),

      // 하단 탭: 선택 잉크, 비선택 tertiary, brand 색 사용 안 함
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppSemantic.bgSurface,
        selectedItemColor: AppSemantic.textPrimary,
        unselectedItemColor: AppSemantic.textTertiary,
        selectedLabelStyle: AppTextStyles.captionXsMedium,
        unselectedLabelStyle: AppTextStyles.captionXs,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppSemantic.bgSurface,
        indicatorColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppTextStyles.captionXsMedium
              : AppTextStyles.captionXs.copyWith(
                  color: AppSemantic.textTertiary,
                ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppSemantic.textPrimary
                : AppSemantic.textTertiary,
          ),
        ),
      ),

      // 바텀시트·다이얼로그: radius 2xl(20), 그림자 대신 스크림
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppSemantic.bgSurface,
        modalBackgroundColor: AppSemantic.bgSurface,
        modalBarrierColor: AppSemantic.scrim.withValues(alpha: 0.5),
        showDragHandle: true,
        dragHandleColor: AppSemantic.borderStrong,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xxl),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppSemantic.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xxlAll),
        titleTextStyle: AppTextStyles.headingLg,
        contentTextStyle: AppTextStyles.bodyBase.copyWith(
          color: AppSemantic.textSecondary,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppSemantic.bgInverse,
        contentTextStyle: AppTextStyles.bodySm.copyWith(
          color: AppSemantic.textInverse,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      ),

      iconTheme: const IconThemeData(color: AppSemantic.textPrimary, size: 24),
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppTextStyles.bodyBaseMedium,
        subtitleTextStyle: AppTextStyles.bodySm.copyWith(
          color: AppSemantic.textSecondary,
        ),
        iconColor: AppSemantic.textPrimary,
      ),
    );
  }
}
