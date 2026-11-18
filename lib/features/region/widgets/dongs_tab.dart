import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/metric.dart';
import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/region_detail.dart';
import '../../../shared/widgets/app_chip.dart';
import '../../../shared/widgets/dong_row.dart';
import '../../../shared/widgets/tag.dart';
import '../region_copy.dart';

/// M-03b 동네 탭. 행정동을 동네 조용함순으로 보여주고 생활권 · 관광지로 거릅니다.
///
/// Figma 의 `또래순` · `저녁 활기순` 칩은 아직 없습니다. 지역 상세 응답의 행정동에는
/// 동네 조용함 점수만 있어서입니다(웹 W-03 도 조용함순 하나).
class DongsTab extends StatefulWidget {
  const DongsTab({super.key, required this.detail, required this.onDongTap});

  final RegionDetail detail;
  final ValueChanged<RegionDong> onDongTap;

  @override
  State<DongsTab> createState() => _DongsTabState();
}

class _DongsTabState extends State<DongsTab> {
  /// null 이면 거르지 않습니다.
  DongKind? _kind;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final d = widget.detail;
    final monthLabel = Months.label(d.month);
    final month = Months.numberOf(d.month);
    final dongs = [
      for (final dong in d.dongs)
        if (_kind == null || dong.kind == _kind) dong,
    ]..sort((a, b) => b.quietScore.compareTo(a.quietScore));
    final excluded = d.excludedDongs.map((e) => e.name).join('·');
    const gutter = EdgeInsets.symmetric(horizontal: AppSpacing.s4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: [
        Padding(
          padding: gutter,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '행정동 ${d.dongs.length}곳',
                  style: AppTextStyles.headingLg,
                ),
              ),
              Text(
                [
                  if (excluded.isNotEmpty) '$excluded 제외',
                  '$monthLabel 기준',
                ].join(' · '),
                style: AppTextStyles.captionXs.copyWith(color: tertiary),
              ),
            ],
          ),
        ),
        AppChipRow(
          children: [
            AppChip(
              label: '동네 조용함순',
              selected: _kind == null,
              onTap: () => setState(() => _kind = null),
            ),
            for (final kind in DongKind.values)
              AppChip(
                label: kind.label,
                selected: _kind == kind,
                onTap: () =>
                    setState(() => _kind = _kind == kind ? null : kind),
              ),
          ],
        ),
        Padding(
          padding: gutter,
          child: dongs.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s6),
                  child: Text(
                    '${_kind?.label ?? ''} 동네가 없어요',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySm.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                )
              : Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.xlAll,
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      for (final (i, dong) in dongs.indexed)
                        DongRow(
                          key: ValueKey(dong.id),
                          name: dong.name,
                          kindLabel: dong.kind.label,
                          kindTone: dong.kind == DongKind.living
                              ? TagTone.brand
                              : TagTone.neutral,
                          caption: dongCaption(
                            dong,
                            month: month,
                            monthLabel: monthLabel,
                          ),
                          metricLabel: MetricKey.quiet.label,
                          grade: metricGrade(dong.quietScore),
                          showDivider: i < dongs.length - 1,
                          onTap: () => widget.onDongTap(dong),
                        ),
                    ],
                  ),
                ),
        ),
        Padding(
          padding: gutter,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.s3),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: AppRadius.xlAll,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s2,
              children: [
                Icon(LucideIcons.mapPin, size: 16, color: scheme.primary),
                Expanded(
                  child: Text(
                    '행정동을 누르면 24시간 붐빔 곡선과 생활권 태그가 있는 동네 프로필로 이동합니다.',
                    style: AppTextStyles.captionXs.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
