import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/metric.dart';
import '../../core/theme/app_theme.dart';
import 'grade_badge.dart';
import 'icon_button_circle.dart';
import 'photo_carousel.dart';

/// 모바일 사진 우선 지역 카드 (Figma ListingCardMobile, M-01 · M-05).
/// 사진 4:3 + 제목 · 종합 점수 + 메타 2줄 + 세부 등급.
class ListingCardMobile extends StatelessWidget {
  const ListingCardMobile({
    super.key,
    required this.title,
    required this.score,
    required this.meta,
    this.meta2,
    this.photos = const [],
    this.grades = const [],
    this.badge,
    this.saved = false,
    this.onToggleSave,
    this.onTap,
  });

  /// 예: `고성군, 강원특별자치도`
  final String title;

  /// 종합 점수(0~100). 정수로 반올림해 보여줍니다.
  final double score;

  /// 예: `해안 · 속초시 인접`
  final String meta;

  /// 예: `즐겨찾기 1284 · 조회 8.2천 · 10월` (Figma Meta2, 없으면 숨김)
  final String? meta2;
  final List<String?> photos;

  /// 세부 등급 줄. 예: `[(조용, A), (또래, B), (숙박, S)]`
  final List<(String label, Grade grade)> grades;

  /// 사진 왼쪽 위 배지. 예: `즐겨찾기 1위`
  final String? badge;
  final bool saved;
  final VoidCallback? onToggleSave;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final secondary = scheme.onSurfaceVariant;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppRadius.xlAll,
            child: AspectRatio(
              aspectRatio: 358 / 268,
              child: PhotoCarousel(
                photos: photos,
                overlay: Padding(
                  padding: const EdgeInsets.all(AppSpacing.s3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (badge != null) _FloatBadge(badge!),
                      const Spacer(),
                      IconButtonCircle.save(
                        saved: saved,
                        size: IconButtonCircleSize.sm,
                        onPressed: onToggleSave,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
              const SizedBox(width: AppSpacing.s2),
              Icon(LucideIcons.sparkles, size: 14, color: scheme.onSurface),
              const SizedBox(width: AppSpacing.s1),
              Text(
                score.round().toString(),
                style: AppTextStyles.bodySmBold,
                semanticsLabel: '종합 점수 ${score.round()}점',
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            meta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySm.copyWith(color: secondary),
          ),
          if (meta2 != null) ...[
            const SizedBox(height: 2),
            Text(
              meta2!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySm.copyWith(color: secondary),
            ),
          ],
          if (grades.isNotEmpty) ...[
            const SizedBox(height: 2),
            Row(
              spacing: 6,
              children: [
                for (final (label, grade) in grades) ...[
                  Text(
                    label,
                    style: AppTextStyles.captionXs.copyWith(color: secondary),
                  ),
                  GradeBadge(grade),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _FloatBadge extends StatelessWidget {
  const _FloatBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.fullAll,
        boxShadow: AppShadows.cardFloat,
      ),
      child: Text(label, style: AppTextStyles.captionBadge),
    );
  }
}
