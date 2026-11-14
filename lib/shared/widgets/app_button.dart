import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

enum AppButtonVariant {
  /// brand 배경 + 흰 글자. 화면당 1~2개만.
  primary,

  /// 잉크 1px 외곽선
  secondary,

  /// 잉크 글자만
  ghost,
}

/// 버튼 (Figma Button 3종). 높이 [height] 기본 48, 라운드 8, 좌우 24.
class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    this.variant = AppButtonVariant.primary,
    this.height = 48,
    this.expand = false,
    this.onPressed,
  });

  final String label;
  final AppButtonVariant variant;
  final double height;

  /// true 면 가로를 꽉 채웁니다.
  final bool expand;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shape = RoundedRectangleBorder(borderRadius: AppRadius.lgAll);
    final base = ButtonStyle(
      // 40 높이 버튼이 터치 영역 때문에 48 로 부풀지 않게 합니다(Figma 는 40).
      tapTargetSize: height < kMinInteractiveDimension
          ? MaterialTapTargetSize.shrinkWrap
          : MaterialTapTargetSize.padded,
      minimumSize: WidgetStatePropertyAll(
        Size(expand ? double.infinity : 0, height),
      ),
      maximumSize: WidgetStatePropertyAll(Size(double.infinity, height)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppSpacing.s6),
      ),
      shape: WidgetStatePropertyAll(shape),
      textStyle: WidgetStatePropertyAll(AppTextStyles.bodyBaseMedium),
    );

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        style: base,
        child: Text(label),
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: onPressed,
        style: base.copyWith(
          foregroundColor: WidgetStatePropertyAll(scheme.onSurface),
          side: WidgetStatePropertyAll(BorderSide(color: scheme.onSurface)),
        ),
        child: Text(label),
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: onPressed,
        style: base.copyWith(
          foregroundColor: WidgetStatePropertyAll(scheme.onSurface),
        ),
        child: Text(label),
      ),
    };
  }
}
