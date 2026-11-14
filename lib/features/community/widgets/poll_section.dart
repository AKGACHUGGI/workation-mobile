import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';
import '../../../shared/widgets/reaction_poll.dart';
import '../../auth/login_gate.dart';
import '../community_providers.dart';
import 'section_header.dart';

/// 체감 투표 카드. 누르면 로그인을 확인한 뒤 투표하고, 다시 누르면 바꿉니다.
class PollSection extends ConsumerStatefulWidget {
  const PollSection({
    super.key,
    required this.target,
    required this.month,
    required this.question,
    required this.participationLabel,
  });

  final CommunityTarget target;

  /// 화면의 월(`2025-10` · `annual`). 연간이면 12월로 조회합니다.
  final String month;
  final String question;
  final String participationLabel;

  @override
  ConsumerState<PollSection> createState() => _PollSectionState();
}

class _PollSectionState extends ConsumerState<PollSection> {
  var _saving = false;

  PollArg get _arg => (target: widget.target, month: widget.month);

  Future<void> _vote(PollChoice choice) async {
    if (!await ensureLoggedIn(context, ref)) return;
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    try {
      await ref
          .read(communityRepositoryProvider)
          .vote(widget.target, pollMonthOf(widget.month), choice);
      ref.invalidate(pollProvider(_arg));
    } on ApiException {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('투표하지 못했어요')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final poll = ref.watch(pollProvider(_arg));
    final data = poll.value;

    if (data != null) {
      return ReactionPoll(
        question: widget.question,
        poll: data,
        participationLabel: widget.participationLabel,
        onVote: _saving ? null : _vote,
      );
    }
    return poll.hasError
        ? SectionNotice(
            '투표를 불러오지 못했어요',
            onRetry: () => ref.invalidate(pollProvider(_arg)),
          )
        : const SectionNotice('불러오는 중…');
  }
}
