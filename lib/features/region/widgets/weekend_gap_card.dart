import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../region_copy.dart';
import 'section_card.dart';

/// 주중 · 주말 차이 (Figma M-03a WeekendGap). 주중 낮 체류를 1 로 둔 가로 막대 둘.
class WeekendGapCard extends StatelessWidget {
  const WeekendGapCard({super.key, required this.ratio});

  /// 주말 낮 체류 ÷ 주중 낮 체류
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    // 비슷한 값(1.0 대 1.05)이 트랙의 2/3쯤을 채우도록 눈금 끝을 1.6 으로 둡니다.
    final scale = math.max(1.6, ratio);

    return SectionCard(
      title: '주중 · 주말 차이',
      caption: '주말 ÷ 주중 낮 체류',
      children: [
        _RatioBar(
          label: '주중',
          value: '1.0×',
          fraction: 1 / scale,
          color: colors.chartWeekday,
        ),
        _RatioBar(
          label: '주말',
          value: '${ratio.toStringAsFixed(2)}×',
          fraction: ratio / scale,
          color: colors.chartWeekend,
        ),
        Text(
          weekendSentence(ratio),
          style: AppTextStyles.bodySm.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _RatioBar extends StatelessWidget {
  const _RatioBar({
    required this.label,
    required this.value,
    required this.fraction,
    required this.color,
  });

  final String label;
  final String value;
  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(4);

    return Column(
      spacing: AppSpacing.s1,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.captionXsMedium.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            Text(value, style: AppTextStyles.captionXsBold),
          ],
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: radius,
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: fraction.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(color: color, borderRadius: radius),
            ),
          ),
        ),
      ],
    );
  }
}
