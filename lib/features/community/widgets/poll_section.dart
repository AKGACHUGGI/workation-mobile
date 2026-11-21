import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/metric/metric.dart';
import '../../../core/network/api_exception.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';
import '../../../shared/widgets/reaction_poll.dart';
import '../../auth/login_gate.dart';
import '../community_providers.dart';
import 'section_header.dart';

/// 체감 투표 카드. 누르면 로그인을 확인한 뒤 투표합니다. 다른 쪽을 누르면 바꾸고,
/// 고른 쪽을 다시 누르면 취소합니다.
class PollSection extends ConsumerStatefulWidget {
  const PollSection({
    super.key,
    required this.target,
    required this.month,
    required this.question,
    required this.participationLabel,
    this.preset,
  });

  final CommunityTarget target;

  /// 화면의 월(`2025-10` · `annual`). 연간이면 12월로 조회합니다.
  final String month;
  final String question;
  final String participationLabel;

  /// 지역의 프리셋. 프리셋마다 다른 투표입니다. 동네는 null
  final PresetKey? preset;

  @override
  ConsumerState<PollSection> createState() => _PollSectionState();
}

class _PollSectionState extends ConsumerState<PollSection> {
  var _saving = false;

  PollArg get _arg =>
      (target: widget.target, month: widget.month, preset: widget.preset);

  Future<void> _vote(PollChoice choice) async {
    if (!await ensureLoggedIn(context, ref)) return;
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final arg = _arg;
    setState(() => _saving = true);
    try {
      // 로그인하고 돌아왔으면 내 투표가 새로 읽힙니다. 그 값을 보고 취소인지 정합니다.
      final mine = (await ref.read(pollProvider(arg).future)).myVote;
      await ref
          .read(communityRepositoryProvider)
          .vote(
            arg.target,
            pollMonthOf(arg.month),
            mine == choice ? null : choice,
            preset: arg.preset,
          );
      ref.invalidate(pollProvider(arg));
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
        // 지역 질문은 서버가 프리셋에 맞춰 줍니다. 비어 있으면(mock) 화면이 만든 문구를 씁니다.
        question: widget.preset != null && data.question.isNotEmpty
            ? data.question
            : widget.question,
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
