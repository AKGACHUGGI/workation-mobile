import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 상세 화면 하단 고정 바 (Figma MobileStickyBar, M-03 · M-04).
/// 점수 요약 + 화면의 하나뿐인 primary CTA.
class MobileStickyBar extends StatelessWidget {
  const MobileStickyBar({
    super.key,
    required this.score,
    required this.scoreSuffix,
    required this.sub,
    required this.actionLabel,
    this.onAction,
  });

  final double score;

  /// 점수 옆 문구. 예: `점 · 10월`
  final String scoreSuffix;

  /// 예: `조용한 곳 · 12곳 중 3위 · S`
  final String sub;

  /// 예: `즐겨찾기`
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final secondary = scheme.onSurfaceVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: AppSpacing.s3),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s4,
            AppSpacing.s3,
            AppSpacing.s4,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: AppSpacing.s1,
                      children: [
                        Text(
                          score.round().toString(),
                          style: AppTextStyles.headingXl,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            scoreSuffix,
                            style: AppTextStyles.bodySm.copyWith(
                              color: secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.captionXs.copyWith(color: secondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s3),
              FilledButton(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s6,
                  ),
                  textStyle: AppTextStyles.bodyBaseMedium,
                ),
                child: Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
