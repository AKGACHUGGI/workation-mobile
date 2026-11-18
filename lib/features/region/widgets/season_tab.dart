import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/region_detail.dart';
import '../region_copy.dart';
import 'monthly_crowd_card.dart';
import 'section_card.dart';
import 'weekend_gap_card.dart';

/// M-03a 시기 탭. 월별 혼잡 막대 · 좋은 달 · 피할 달 · 또래 많고 덜 붐비는 달 · 주말 차이.
class SeasonTab extends StatelessWidget {
  const SeasonTab({super.key, required this.detail});

  final RegionDetail detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final d = detail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s4,
      children: [
        MonthlyCrowdCard(
          months: d.months,
          bestMonths: d.bestMonths,
          avoidMonths: d.avoidMonths,
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              Expanded(
                child: _SignalCard(
                  label: '가기 좋은 달',
                  months: formatMonths(d.bestMonths),
                  note: '${crowdRange(d.months, d.bestMonths)} · 연중 가장 한산',
                  color: colors.signalGood,
                  background: colors.signalGoodBg,
                ),
              ),
              Expanded(
                child: _SignalCard(
                  label: '피할 달',
                  months: formatMonths(d.avoidMonths),
                  note: '${crowdRange(d.months, d.avoidMonths)} · 성수기',
                  color: colors.signalAvoid,
                  background: colors.signalAvoidBg,
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          icon: LucideIcons.bed,
          title: '또래 많고 덜 붐비는 달',
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatMonths(d.peerOffpeakMonths),
                    style: AppTextStyles.headingXl.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ),
                Text(
                  '또래 비중 ↑  혼잡 ↓',
                  style: AppTextStyles.captionXs.copyWith(
                    color: colors.textTertiary,
                  ),
                ),
              ],
            ),
            Text(
              '20~40대 방문 비중은 연중 상위권이면서 혼잡은 낮은 달입니다. '
              '또래와 어울리면서 한산하게 머물고 싶다면 이때가 좋아요.',
              style: AppTextStyles.bodySm.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        WeekendGapCard(ratio: d.stats.weekendRatio),
      ],
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({
    required this.label,
    required this.months,
    required this.note,
    required this.color,
    required this.background,
  });

  final String label;
  final String months;
  final String note;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.xlAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s1,
        children: [
          Text(
            label,
            style: AppTextStyles.captionXsMedium.copyWith(color: color),
          ),
          Text(months, style: AppTextStyles.headingXl),
          Text(
            note,
            style: AppTextStyles.captionXs.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
