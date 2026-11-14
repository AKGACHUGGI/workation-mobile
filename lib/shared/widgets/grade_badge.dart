import 'package:flutter/material.dart';

import '../../core/metric/metric.dart';
import '../../core/theme/app_theme.dart';

enum GradeBadgeSize { sm, md }

/// 지표 등급 배지 (Figma GradeBadge). S · A · B · C.
class GradeBadge extends StatelessWidget {
  const GradeBadge(this.grade, {super.key, this.size = GradeBadgeSize.sm});

  final Grade grade;
  final GradeBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context)
        .extension<AppSemanticColors>()!
        .gradeOf(grade.label);
    final md = size == GradeBadgeSize.md;

    return Semantics(
      label: '${grade.label} 등급',
      excludeSemantics: true,
      child: Container(
        padding: md
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            : const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: colors.bg,
          borderRadius: AppRadius.smAll,
        ),
        child: Text(
          grade.label,
          style: (md ? AppTextStyles.bodySmBold : AppTextStyles.captionXsBold)
              .copyWith(color: colors.fg),
        ),
      ),
    );
  }
}
