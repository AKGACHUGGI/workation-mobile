import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 세그먼트 탭 (Figma Mobile/SegmentedTabs · DayToggle).
/// M-03 의 시기 · 동네 · 정보, M-04 의 주중 · 주말.
class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.labels,
    required this.index,
    required this.onChanged,
  });

  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s1),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: AppRadius.lgAll,
      ),
      child: Row(
        spacing: AppSpacing.s1,
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: _Segment(
                label: labels[i],
                selected: i == index,
                onTap: () => onChanged(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? scheme.surface
                : scheme.surface.withValues(alpha: 0),
            borderRadius: AppRadius.mdAll,
            boxShadow: selected ? AppShadows.segment : null,
          ),
          child: Text(
            label,
            style: AppTextStyles.bodySmMedium.copyWith(
              color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
