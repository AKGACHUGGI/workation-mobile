import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// 지역 상세의 테두리 카드. 제목(18 Bold) + 오른쪽 설명(12) + 내용.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    this.icon,
    this.caption,
    required this.children,
  });

  final String title;
  final IconData? icon;
  final String? caption;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s3,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.s2),
              ],
              Expanded(child: Text(title, style: AppTextStyles.headingLg)),
              if (caption != null)
                Text(
                  caption!,
                  style: AppTextStyles.captionXs.copyWith(
                    color: Theme.of(context)
                        .extension<AppSemanticColors>()!
                        .textTertiary,
                  ),
                ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}
