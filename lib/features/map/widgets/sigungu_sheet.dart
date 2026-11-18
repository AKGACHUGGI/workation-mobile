import 'package:flutter/material.dart';

import '../../../core/metric/metric.dart';
import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/geo_area.dart';
import '../../../data/models/popular_region.dart';
import '../../../shared/widgets/app_photo.dart';
import '../../../shared/widgets/grade_badge.dart';
import '../../../shared/widgets/skeleton.dart';
import 'map_sheet.dart';

/// ⓪ 시트. 안내(고른 시군구 없음) · 요약 카드 + [동네 보기] · 불러오는 중 · 오류.
class SigunguSheet extends StatelessWidget {
  const SigunguSheet({
    super.key,
    required this.area,
    required this.region,
    required this.score,
    required this.month,
    required this.loading,
    required this.onOpen,
    this.onRetry,
  });

  /// 고른 시군구. null 이면 안내 문구
  final GeoArea? area;

  /// 점수 응답에서 찾은 지역. 없으면 이름과 [동네 보기] 만 보여 줍니다.
  final PopularRegion? region;
  final double? score;
  final String month;
  final bool loading;
  final VoidCallback onOpen;

  /// 점수를 못 받았을 때 [다시 시도]
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final a = area;
    return MapSheet(
      child: a == null
          ? const SheetMessage('지도에서 시군구를 눌러 보세요')
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.s3,
              children: [
                if (loading)
                  const _SummarySkeleton()
                else if (onRetry != null)
                  SheetMessage('${a.name} 점수를 불러오지 못했어요', onRetry: onRetry)
                else
                  _Summary(area: a, region: region, score: score, month: month),
                FilledButton(onPressed: onOpen, child: const Text('동네 보기')),
              ],
            ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.area,
    required this.region,
    required this.score,
    required this.month,
  });

  final GeoArea area;
  final PopularRegion? region;
  final double? score;
  final String month;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final r = region;
    final title = r == null ? area.name : '${area.name}, ${r.province}';
    final caption = [
      if (r != null && r.terrain.isNotEmpty)
        r.terrain.map((t) => t.label).join('·'),
      if (area.dongCount != null) '행정동 ${area.dongCount}곳',
      Months.label(month),
    ].join(' · ');

    return Row(
      spacing: AppSpacing.s3,
      children: [
        _Thumb(url: r?.photoUrl, month: Months.label(month)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleMd,
                    ),
                  ),
                  if (score != null) ...[
                    const SizedBox(width: AppSpacing.s2),
                    Text(
                      score!.round().toString(),
                      style: AppTextStyles.headingLg,
                    ),
                    Text(
                      '점',
                      style: AppTextStyles.captionXs.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                caption,
                style: AppTextStyles.bodySm.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              if (r != null)
                Row(
                  spacing: 6,
                  children: [
                    for (final (key, label) in const [
                      (MetricKey.quiet, '조용'),
                      (MetricKey.peer, '또래'),
                      (MetricKey.overnight, '숙박'),
                    ]) ...[
                      Text(
                        label,
                        style: AppTextStyles.captionXs.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      GradeBadge(metricGrade(r.scores[key])),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 96×72 사진 + 왼쪽 아래 월 칩 (Figma PhotoThumb)
class _Thumb extends StatelessWidget {
  const _Thumb({required this.url, required this.month});

  final String? url;
  final String month;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: SizedBox(
        width: 96,
        height: 72,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppPhoto(url),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.shadow.withValues(alpha: 0),
                    scheme.shadow.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.shadow.withValues(alpha: 0.55),
                  borderRadius: AppRadius.smAll,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: Text(
                    month,
                    style: AppTextStyles.captionXsBold.copyWith(
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: AppSpacing.s3,
      children: [
        Skeleton(width: 96, height: 72, radius: AppRadius.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s2,
            children: [
              Skeleton(width: 140, height: 20),
              Skeleton(height: 16),
              Skeleton(width: 120, height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
