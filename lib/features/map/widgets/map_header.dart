import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/metric.dart';
import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_chip.dart';
import '../map_logic.dart';

/// M-02 머리글. ⓪ 은 "지도" + 월 + 지표 칩 6종, ① ② 는 뒤로 가기 + 시군구 이름 + 월.
class MapHeader extends StatelessWidget {
  const MapHeader.sigungu({
    super.key,
    required this.month,
    required this.onMonth,
    required this.metric,
    required this.onMetric,
  }) : title = '지도',
       onBack = null,
       _withChips = true;

  const MapHeader.dongs({
    super.key,
    required this.title,
    required this.month,
    required this.onMonth,
    required VoidCallback this.onBack,
  }) : metric = null,
       onMetric = null,
       _withChips = false;

  final String title;
  final String month;
  final ValueChanged<String> onMonth;
  final VoidCallback? onBack;
  final MapMetric metric;
  final ValueChanged<MapMetric>? onMetric;
  final bool _withChips;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.s2,
          bottom: AppSpacing.s3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.s2,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: onBack == null ? AppSpacing.s4 : AppSpacing.s2,
                right: AppSpacing.s4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onBack == null)
                    Text(title, style: AppTextStyles.headingXl)
                  else
                    InkWell(
                      onTap: onBack,
                      borderRadius: AppRadius.lgAll,
                      child: Semantics(
                        button: true,
                        label: '$title 지도에서 전체 지도로',
                        excludeSemantics: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s2,
                            vertical: AppSpacing.s1,
                          ),
                          child: Row(
                            spacing: AppSpacing.s1,
                            children: [
                              const Icon(LucideIcons.chevronLeft, size: 24),
                              Text(title, style: AppTextStyles.headingXl),
                            ],
                          ),
                        ),
                      ),
                    ),
                  MonthButton(month: month, onChanged: onMonth),
                ],
              ),
            ),
            if (_withChips)
              AppChipRow(
                children: [
                  AppChip(
                    label: '종합',
                    selected: metric == null,
                    onTap: () => onMetric?.call(null),
                  ),
                  for (final key in MetricKey.values)
                    AppChip(
                      label: key.label,
                      selected: metric == key,
                      onTap: () => onMetric?.call(key),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// "10월 ⌄" 월 선택 버튼. 누르면 연간 + 12개월 목록 시트가 열립니다.
class MonthButton extends StatelessWidget {
  const MonthButton({super.key, required this.month, required this.onChanged});

  final String month;
  final ValueChanged<String> onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final m in Months.all)
                ListTile(
                  title: Text(
                    Months.label(m),
                    style: AppTextStyles.bodyBaseMedium,
                  ),
                  trailing: m == month
                      ? const Icon(LucideIcons.check, size: 20)
                      : null,
                  onTap: () => Navigator.of(context).pop(m),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
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
          onTap: () => _pick(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.s1,
              children: [
                Text(Months.label(month), style: AppTextStyles.bodySmMedium),
                const Icon(LucideIcons.chevronDown, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
