import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/month.dart';
import '../../core/theme/app_theme.dart';
import '../../core/time/relative_time.dart';
import '../../data/models/community.dart';
import 'avatar.dart';
import 'tag.dart';

/// 한 줄 팁 카드 (Figma TipCard, 워케이션 노트 1건).
/// 도움돼요는 내가 눌렀으면 강조됩니다. [onHelpful] · [onReplies] 가 null 이면 숫자만 보입니다.
/// 신고는 모양만 있고 아직 누를 수 없습니다.
class TipCard extends StatelessWidget {
  const TipCard(
    this.tip, {
    super.key,
    this.now,
    this.onHelpful,
    this.onReplies,
  });

  final Tip tip;

  /// 도움돼요를 눌렀을 때(켜기 · 끄기는 부모가 [Tip.myHelpful] 로 정합니다)
  final VoidCallback? onHelpful;

  /// 답글을 눌렀을 때
  final VoidCallback? onReplies;

  /// 상대 시간 기준. 테스트에서 고정합니다.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final meta = [
      relativeTime(tip.createdAt, now: now),
      ?tip.dongName,
      ?tip.stayLabel,
    ].where((s) => s.isNotEmpty).join(' · ');
    final visit = tip.visitMonth;
    final secondary = AppTextStyles.captionXsMedium.copyWith(
      color: scheme.onSurfaceVariant,
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Avatar(initial: tip.author.initial),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tip.author.nickname, style: AppTextStyles.bodySmBold),
                    Text(
                      meta,
                      style: AppTextStyles.captionXs.copyWith(color: tertiary),
                    ),
                  ],
                ),
              ),
              if (visit != null)
                Tag('${Months.label(visit)} 방문', tone: TagTone.brand),
            ],
          ),
          Text(tip.body, style: AppTextStyles.bodySm),
          Row(
            spacing: AppSpacing.s4,
            children: [
              _Stat(
                icon: LucideIcons.thumbsUp,
                label: '도움돼요 ${tip.helpful}',
                style: tip.myHelpful
                    ? AppTextStyles.captionXsBold.copyWith(
                        color: scheme.primary,
                      )
                    : secondary,
                color: tip.myHelpful ? scheme.primary : scheme.onSurfaceVariant,
                selected: tip.myHelpful,
                onTap: onHelpful,
              ),
              _Stat(
                icon: LucideIcons.messageCircle,
                label: '답글 ${tip.replies}',
                style: secondary,
                color: scheme.onSurfaceVariant,
                onTap: onReplies,
              ),
              const Spacer(),
              _Stat(
                icon: LucideIcons.flag,
                size: 14,
                label: '신고',
                style: AppTextStyles.captionXs.copyWith(color: tertiary),
                color: tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.label,
    required this.style,
    required this.color,
    this.size = 16,
    this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final TextStyle style;
  final Color color;
  final double size;

  /// 켜고 끄는 버튼이면 지금 상태. 아니면 null
  final bool? selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s1,
      children: [
        Icon(icon, size: size, color: color),
        Text(label, style: style),
      ],
    );
    if (onTap == null) return row;

    // 글자는 작아도 누르는 곳은 넉넉하게: 위아래로 넓히고 카드 여백 쪽으로 겹칩니다.
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
          child: row,
        ),
      ),
    );
  }
}
