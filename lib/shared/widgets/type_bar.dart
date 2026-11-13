import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 워케이션 유형 막대 한 줄 (M-02 ② 시트 · M-04 v3 유형 카드).
/// 이름 · 막대 · 점수. 1위([highlight])만 브랜드 색입니다.
class TypeBar extends StatelessWidget {
  const TypeBar({
    super.key,
    required this.name,
    required this.score,
    this.highlight = false,
    this.reason,
  });

  final String name;

  /// 0~100
  final double score;
  final bool highlight;

  /// 막대 아래 근거 문구. 예: `숙박 성향 64 · 한산한 달 7개`
  final String? reason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semantic = theme.extension<AppSemanticColors>()!;
    final value = (score / 100).clamp(0.0, 1.0);

    return Semantics(
      label: '$name ${score.round()}점',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s1,
        children: [
          ExcludeSemantics(
            child: Row(
              spacing: AppSpacing.s2,
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    name,
                    style: highlight
                        ? AppTextStyles.captionXsBold
                        : AppTextStyles.captionXsMedium,
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppRadius.smAll,
                    child: SizedBox(
                      height: 8,
                      child: ColoredBox(
                        color: semantic.chartBarMuted,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: value,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: highlight
                                  ? scheme.primary
                                  : semantic.chartBar,
                              borderRadius: AppRadius.smAll,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 22,
                  child: Text(
                    score.round().toString(),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.captionXsBold.copyWith(
                      color: highlight ? scheme.primary : scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (reason != null)
            Text(
              reason!,
              style: AppTextStyles.captionXs.copyWith(
                color: semantic.textTertiary,
              ),
            ),
        ],
      ),
    );
  }
}
