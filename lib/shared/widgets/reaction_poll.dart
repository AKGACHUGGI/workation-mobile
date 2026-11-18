import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/community.dart';

/// 체감 투표 (Figma ReactionPoll). 질문 · 그래요 비율 막대 · 그래요 / 아니요 버튼 · 참여 수.
/// 결과 막대는 처음부터 보이고, 고른 쪽 버튼에 테두리가 생깁니다. 다른 쪽을 누르면 바꿉니다.
class ReactionPoll extends StatelessWidget {
  const ReactionPoll({
    super.key,
    required this.question,
    required this.poll,
    required this.participationLabel,
    this.onVote,
  });

  final String question;
  final PollResponse poll;

  /// `{n}명 참여 · ` 뒤에 붙는 문구. 예: `지표 검증에 반영돼요`
  final String participationLabel;

  /// null 이면 누를 수 없습니다(저장 중).
  final ValueChanged<PollChoice>? onVote;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final mine = poll.myVote;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: [
          Text(question, style: AppTextStyles.bodySmBold),
          ClipRRect(
            borderRadius: AppRadius.smAll,
            child: SizedBox(
              height: 8,
              child: ColoredBox(
                color: colors.bgSubtle,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: poll.yesPercent / 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.signalGood,
                      borderRadius: AppRadius.smAll,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            spacing: AppSpacing.s2,
            children: [
              Expanded(
                child: _VoteButton(
                  icon: LucideIcons.thumbsUp,
                  label: '그래요 ${poll.yesPercent}%',
                  background: colors.signalGoodBg,
                  foreground: colors.signalGood,
                  selected: mine == PollChoice.yes,
                  onTap: onVote == null ? null : () => onVote!(PollChoice.yes),
                ),
              ),
              Expanded(
                child: _VoteButton(
                  icon: LucideIcons.thumbsDown,
                  label: '아니요 ${poll.noPercent}%',
                  background: colors.bgSubtle,
                  foreground: scheme.onSurfaceVariant,
                  selected: mine == PollChoice.no,
                  onTap: onVote == null ? null : () => onVote!(PollChoice.no),
                ),
              ),
            ],
          ),
          Text(
            '${poll.total}명 참여 · $participationLabel',
            style: AppTextStyles.captionXs.copyWith(color: colors.textTertiary),
          ),
        ],
      ),
    );
  }
}

class _VoteButton extends StatelessWidget {
  const _VoteButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: selected
              ? BorderSide(color: foreground, width: 1.5)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s3,
              vertical: AppSpacing.s2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                Icon(icon, size: 16, color: foreground),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmMedium.copyWith(
                      color: foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
