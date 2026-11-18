import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 지도 히트맵 범례 7단계 (Figma HeatLegend, heat/100~700). 낮음 0 · 점수 · 100 높음.
class HeatLegend extends StatelessWidget {
  const HeatLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;

    return Semantics(
      label: '점수 범례, 낮음 0에서 높음 100',
      excludeSemantics: true,
      child: SizedBox(
        width: 208,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Row(
              spacing: 2,
              children: [
                for (final c in semantic.heat)
                  Expanded(
                    child: SizedBox(height: 10, child: ColoredBox(color: c)),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '낮음 0',
                  style: AppTextStyles.captionXs.copyWith(
                    color: semantic.textTertiary,
                  ),
                ),
                Text(
                  '점수',
                  style: AppTextStyles.captionXsMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '100 높음',
                  style: AppTextStyles.captionXs.copyWith(
                    color: semantic.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
