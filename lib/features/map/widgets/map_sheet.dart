import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// 지도 아래 고정 시트 (Figma BottomSheet). 끌어도 펼쳐지지 않고 높이는 내용에 맞춥니다.
class MapSheet extends StatelessWidget {
  const MapSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
        boxShadow: AppShadows.cardFloat,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s4,
          AppSpacing.s2,
          AppSpacing.s4,
          AppSpacing.s4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.s3,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

/// 시트 안의 안내 문구(빈 상태 · 오류). [onRetry] 가 있으면 [다시 시도] 를 붙입니다.
class SheetMessage extends StatelessWidget {
  const SheetMessage(this.message, {super.key, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s3,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        if (onRetry != null)
          OutlinedButton(onPressed: onRetry, child: const Text('다시 시도')),
      ],
    );
  }
}
