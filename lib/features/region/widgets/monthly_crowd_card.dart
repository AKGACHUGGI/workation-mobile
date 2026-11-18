import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/region_detail.dart';
import 'section_card.dart';

/// 월별 혼잡 지수 막대 12개 (Figma M-03a MonthlyCrowd).
/// 가기 좋은 달은 초록, 피할 달은 빨강, 나머지는 회색입니다.
class MonthlyCrowdCard extends StatelessWidget {
  const MonthlyCrowdCard({
    super.key,
    required this.months,
    required this.bestMonths,
    required this.avoidMonths,
  });

  final List<MonthCrowd> months;
  final List<int> bestMonths;
  final List<int> avoidMonths;

  static const _barHeight = 110.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return SectionCard(
      title: '월별 혼잡 지수',
      caption: '연중 최대 = 100',
      children: [
        Semantics(
          label: [for (final m in months) '${m.month}월 혼잡 ${m.crowd}']
              .join(', '),
          excludeSemantics: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final m in months)
                _Bar(
                  month: m.month,
                  height: _barHeight * m.crowd.clamp(0, 100) / 100,
                  color: bestMonths.contains(m.month)
                      ? colors.signalGood
                      : avoidMonths.contains(m.month)
                      ? colors.signalAvoid
                      : colors.chartBarMuted,
                  labelColor:
                      bestMonths.contains(m.month) ||
                          avoidMonths.contains(m.month)
                      ? scheme.onSurface
                      : colors.textTertiary,
                ),
            ],
          ),
        ),
        Wrap(
          spacing: AppSpacing.s3,
          runSpacing: AppSpacing.s1,
          children: [
            _Legend(color: colors.chartBarMuted, label: '시기 여유'),
            _Legend(color: colors.signalGood, label: '가기 좋은 달'),
            _Legend(color: colors.signalAvoid, label: '피할 달'),
          ],
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.month,
    required this.height,
    required this.color,
    required this.labelColor,
  });

  final int month;
  final double height;
  final Color color;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        SizedBox(
          width: 18,
          height: MonthlyCrowdCard._barHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 18,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        Text(
          '$month',
          style: AppTextStyles.captionXs.copyWith(color: labelColor),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          label,
          style: AppTextStyles.captionXs.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
