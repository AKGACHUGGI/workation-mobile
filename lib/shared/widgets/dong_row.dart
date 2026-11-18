import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/metric.dart';
import '../../core/theme/app_theme.dart';
import 'grade_badge.dart';
import 'tag.dart';

/// 행정동 한 줄 (Figma DongRow, M-03b · M-05). 누르면 동네 프로필로 갑니다.
class DongRow extends StatelessWidget {
  const DongRow({
    super.key,
    required this.name,
    required this.kindLabel,
    required this.caption,
    required this.metricLabel,
    required this.grade,
    this.kindTone = TagTone.neutral,
    this.showDivider = true,
    this.trailing,
    this.onTap,
  });

  final String name;

  /// 생활권 · 관광지
  final String kindLabel;
  final TagTone kindTone;

  /// 예: `거진항 · 8월 피크 · 10월 88%`
  final String caption;

  /// 지금 정렬 기준인 지표 이름. 예: `동네 조용함`
  final String metricLabel;
  final Grade grade;
  final bool showDivider;

  /// 오른쪽 끝 위젯. 없으면 `>` 화살표(M-05 편집 중에는 저장 해제 버튼).
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return _RowShell(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      showDivider: showDivider,
      onTap: onTap,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s1,
            children: [
              Text(name, style: AppTextStyles.bodyBaseMedium),
              Row(
                children: [
                  Tag(kindLabel, tone: kindTone),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.captionXs.copyWith(color: tertiary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          metricLabel,
          style: AppTextStyles.captionXs.copyWith(color: tertiary),
        ),
        const SizedBox(width: 6),
        GradeBadge(grade),
        const SizedBox(width: AppSpacing.s3),
        trailing ?? const Icon(LucideIcons.chevronRight, size: 20),
      ],
    );
  }
}

/// 행정동 한 줄의 지도 탐색 변형 (M-02 ① 시트 목록).
/// 이름 · 사실 필([facts]) + 점수 · 유형.
class DongScoreRow extends StatelessWidget {
  const DongScoreRow({
    super.key,
    required this.name,
    required this.facts,
    this.score,
    this.scoreLabel,
    this.showDivider = true,
    this.onTap,
  });

  final String name;

  /// `FactPill` 목록
  final List<Widget> facts;

  /// 유형 점수. 없으면 점수 칸을 비웁니다.
  final double? score;

  /// 점수 아래 유형 이름. 예: `장기체류형`
  final String? scoreLabel;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _RowShell(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
      showDivider: showDivider,
      onTap: onTap,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(name, style: AppTextStyles.titleMd),
              if (facts.isNotEmpty)
                Wrap(spacing: 6, runSpacing: 6, children: facts),
            ],
          ),
        ),
        if (score != null) ...[
          const SizedBox(width: AppSpacing.s3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score!.round().toString(), style: AppTextStyles.headingLg),
              if (scoreLabel != null)
                Text(
                  scoreLabel!,
                  style: AppTextStyles.captionXs.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(width: AppSpacing.s3),
        const Icon(LucideIcons.chevronRight, size: 24),
      ],
    );
  }
}

class _RowShell extends StatelessWidget {
  const _RowShell({
    required this.padding,
    required this.showDivider,
    required this.children,
    this.onTap,
  });

  final EdgeInsets padding;
  final bool showDivider;
  final List<Widget> children;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: showDivider
                ? Border(bottom: BorderSide(color: scheme.outlineVariant))
                : null,
          ),
          child: Padding(
            padding: padding,
            child: Row(children: children),
          ),
        ),
      ),
    );
  }
}
