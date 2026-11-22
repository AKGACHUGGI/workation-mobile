import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/month.dart';
import '../../core/theme/app_theme.dart';
import '../../core/time/relative_time.dart';
import '../../data/models/community.dart';
import 'avatar.dart';
import 'photo_gallery.dart';
import 'tag.dart';

/// 한 줄 팁 카드 (Figma TipCard, 워케이션 노트 1건).
/// 붙인 사진은 본문 아래 한 줄로 보이고, 누르면 크게 봅니다.
/// 도움돼요는 내가 눌렀으면 강조됩니다. [onHelpful] · [onReplies] 가 null 이면 숫자만 보입니다.
/// 남의 팁의 신고는 모양만 있고 아직 누를 수 없습니다. 내 팁([Tip.mine])이면 신고 자리에
/// ⋯ 메뉴([수정] · [삭제])를 둡니다([onEdit] · [onDelete] 가 모두 null 이면 그리지 않습니다).
class TipCard extends StatelessWidget {
  const TipCard(
    this.tip, {
    super.key,
    this.now,
    this.onHelpful,
    this.onReplies,
    this.onEdit,
    this.onDelete,
  });

  final Tip tip;

  /// 도움돼요를 눌렀을 때(켜기 · 끄기는 부모가 [Tip.myHelpful] 로 정합니다)
  final VoidCallback? onHelpful;

  /// 답글을 눌렀을 때
  final VoidCallback? onReplies;

  /// 내 팁의 ⋯ 메뉴 [수정] · [삭제]
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
          if (tip.photos.isNotEmpty)
            PhotoThumbRow(
              urls: [for (final p in tip.photos) p.url],
              semanticLabel: '${tip.author.nickname} 님의 사진',
            ),
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
              if (!tip.mine)
                _Stat(
                  icon: LucideIcons.flag,
                  size: 14,
                  label: '신고',
                  style: AppTextStyles.captionXs.copyWith(color: tertiary),
                  color: tertiary,
                )
              else if (onEdit != null || onDelete != null)
                _OwnerMenu(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}

enum _OwnerAction { edit, delete }

/// 내 팁의 ⋯ 메뉴. 줄 높이를 늘리지 않게 아이콘 크기만큼만 자리를 잡습니다.
class _OwnerMenu extends StatelessWidget {
  const _OwnerMenu({required this.onEdit, required this.onDelete});

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: AppSpacing.s6,
      child: PopupMenuButton<_OwnerAction>(
        tooltip: '내 팁 메뉴',
        padding: EdgeInsets.zero,
        icon: Icon(
          LucideIcons.ellipsis,
          size: AppSpacing.s5,
          color: scheme.onSurfaceVariant,
        ),
        onSelected: (action) => switch (action) {
          _OwnerAction.edit => onEdit?.call(),
          _OwnerAction.delete => onDelete?.call(),
        },
        itemBuilder: (context) => [
          if (onEdit != null)
            const PopupMenuItem(value: _OwnerAction.edit, child: Text('수정')),
          if (onDelete != null)
            PopupMenuItem(
              value: _OwnerAction.delete,
              child: Text('삭제', style: TextStyle(color: scheme.error)),
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
