import 'package:flutter/material.dart';

import '../../core/metric/metric.dart';
import '../../core/theme/app_theme.dart';
import 'grade_badge.dart';

/// 지표 카드 (Figma MetricCard, M-03c · M-04). 라벨 + 등급 배지 / 점수 / 부제.
/// 점수는 등급 색이 아니라 잉크입니다. [score] 가 null 이면 `—`(값 없음)입니다.
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.score,
    required this.grade,
    this.subtitle,
  });

  final String label;

  /// 0~100
  final double? score;
  final Grade? grade;

  /// 산출 근거 한 줄. 예: `낮 유입 지수 0.79 · 백분위 31`
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final value = score;

    return Semantics(
      container: true,
      label: [
        label,
        if (value != null) '${value.round()}점',
        if (grade != null) '${grade!.label} 등급',
        ?subtitle,
      ].join(', '),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppRadius.xlAll,
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.s2,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: AppTextStyles.bodySmMedium.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (grade != null) GradeBadge(grade!),
              ],
            ),
            if (value == null)
              Text(
                '—',
                style: AppTextStyles.number2xl.copyWith(color: tertiary),
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 2,
                children: [
                  Text(
                    value.round().toString(),
                    style: AppTextStyles.number2xl,
                  ),
                  Text(
                    '점',
                    style: AppTextStyles.bodySm.copyWith(color: tertiary),
                  ),
                ],
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: AppTextStyles.captionXs.copyWith(color: tertiary),
              ),
          ],
        ),
      ),
    );
  }
}

/// 지표 카드를 두 열로 늘어놓습니다(Figma MetricGrid). 홀수면 마지막 줄은 한 칸이 빕니다.
class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key, required this.cards});

  final List<MetricCard> cards;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s3,
      children: [
        for (var i = 0; i < cards.length; i += 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              Expanded(child: cards[i]),
              Expanded(
                child: i + 1 < cards.length ? cards[i + 1] : const SizedBox(),
              ),
            ],
          ),
      ],
    );
  }
}
