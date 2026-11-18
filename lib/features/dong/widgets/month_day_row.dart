import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/segmented_tabs.dart';

/// 월 선택 버튼 + 주중 · 주말 토글(Figma DayToggle) 한 줄.
class MonthDayRow extends StatelessWidget {
  const MonthDayRow({
    super.key,
    required this.month,
    required this.weekend,
    required this.onMonthChanged,
    required this.onWeekendChanged,
  });

  final String month;
  final bool weekend;
  final ValueChanged<String> onMonthChanged;
  final ValueChanged<bool> onWeekendChanged;

  Future<void> _pickMonth(BuildContext context) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => _MonthSheet(selected: month),
    );
    if (picked != null) onMonthChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Semantics(
          button: true,
          label: '월 선택, ${Months.label(month)}',
          excludeSemantics: true,
          child: Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.lgAll,
              side: BorderSide(color: scheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _pickMonth(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.s1,
                  children: [
                    Text(
                      Months.label(month),
                      style: AppTextStyles.bodySmMedium,
                    ),
                    const Icon(LucideIcons.chevronDown, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 144,
          child: SegmentedTabs(
            labels: const ['주중', '주말'],
            index: weekend ? 1 : 0,
            onChanged: (i) => onWeekendChanged(i == 1),
          ),
        ),
      ],
    );
  }
}

class _MonthSheet extends StatelessWidget {
  const _MonthSheet({required this.selected});

  final String selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final m in Months.all)
            ListTile(
              title: Text(Months.label(m), style: AppTextStyles.bodySmMedium),
              trailing: m == selected
                  ? Icon(LucideIcons.check, size: 18, color: scheme.primary)
                  : null,
              onTap: () => Navigator.of(context).pop(m),
            ),
        ],
      ),
    );
  }
}
