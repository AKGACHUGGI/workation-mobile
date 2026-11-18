import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// 정보 · 동네 화면 섹션 머리. 제목(18 Bold) + 오른쪽 설명(12).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.caption});

  final String title;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: AppSpacing.s2,
      children: [
        Expanded(child: Text(title, style: AppTextStyles.headingLg)),
        if (caption != null)
          Text(
            caption!,
            style: AppTextStyles.captionXs.copyWith(color: tertiary),
          ),
      ],
    );
  }
}

/// 섹션 안에서 불러오는 중 · 실패 · 비어 있음을 보여주는 한 줄.
class SectionNotice extends StatelessWidget {
  const SectionNotice(this.message, {super.key, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.s2,
        children: [
          Text(
            message,
            style: AppTextStyles.bodySm.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('다시 시도')),
        ],
      ),
    );
  }
}
