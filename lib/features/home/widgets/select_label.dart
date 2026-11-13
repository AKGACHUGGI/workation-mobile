import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';

/// 작은 선택 메뉴 (M-01 섹션 제목 옆 프리셋 · 정렬). 글자 12 + 아래 화살표.
class SelectLabel<T> extends StatelessWidget {
  const SelectLabel({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.optionLabel,
    required this.onSelected,
  });

  final String label;
  final T value;
  final List<T> options;
  final String Function(T) optionLabel;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return PopupMenuButton<T>(
      initialValue: value,
      onSelected: onSelected,
      tooltip: label,
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        for (final o in options)
          PopupMenuItem(value: o, child: Text(optionLabel(o))),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            Text(
              label,
              style: AppTextStyles.captionXsMedium.copyWith(color: color),
            ),
            Icon(LucideIcons.chevronDown, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}
