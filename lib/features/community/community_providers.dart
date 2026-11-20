import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/retry.dart';
import '../../data/models/community.dart';
import '../../data/repositories/community_repository.dart';
import '../auth/auth_providers.dart';

/// 로그인한 사용자 id. 내 표시(`mine` · `myHelpful` · `myVote`)가 사용자마다 달라서,
/// 커뮤니티 목록은 이 값을 지켜보다가 로그인 · 로그아웃하면 다시 읽습니다.
final _viewerProvider = Provider<String?>(
  (ref) => ref.watch(sessionProvider.select((user) => user?.id)),
);

/// 한 줄 팁 목록(도움순). 첫 쪽을 읽고 [loadMore] 로 다음 쪽을 이어 붙입니다.
/// 등록하면 invalidate 해서 첫 쪽부터 다시 읽습니다. 도움돼요 · 답글 수는 목록을
/// 다시 읽지 않고 그 팁만 바꿉니다(다시 읽으면 도움순이 바뀌어 카드가 움직입니다).
class TipsNotifier extends AsyncNotifier<TipsResponse> {
  TipsNotifier(this.target);

  final CommunityTarget target;
  bool _loadingMore = false;

  @override
  Future<TipsResponse> build() {
    ref.watch(_viewerProvider);
    return ref.watch(communityRepositoryProvider).tips(target);
  }

  void _replace(String tipId, Tip Function(Tip) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        items: [
          for (final tip in current.items) tip.id == tipId ? change(tip) : tip,
        ],
      ),
    );
  }

  /// 도움돼요를 켜거나 끕니다. 숫자를 먼저 바꾸고 서버 값으로 맞춥니다.
  /// 실패하면 되돌리고 false.
  Future<bool> toggleHelpful(Tip tip) async {
    final on = !tip.myHelpful;
    _replace(
      tip.id,
      (t) => t.copyWith(helpful: t.helpful + (on ? 1 : -1), myHelpful: on),
    );
    try {
      final res = await ref
          .read(communityRepositoryProvider)
          .setHelpful(tip.id, on: on);
      if (!ref.mounted) return true;
      _replace(
        tip.id,
        (t) => t.copyWith(helpful: res.helpful, myHelpful: res.myHelpful),
      );
      return true;
    } on ApiException {
      if (ref.mounted) {
        _replace(
          tip.id,
          (t) => t.copyWith(helpful: tip.helpful, myHelpful: tip.myHelpful),
        );
      }
      return false;
    }
  }

  /// 답글을 쓰거나 지운 뒤 카드의 답글 수를 맞춥니다.
  void setReplyCount(String tipId, int count) =>
      _replace(tipId, (t) => t.copyWith(replies: count));

  /// 다음 쪽을 이어 붙입니다. 다음 쪽이 없으면 아무 일도 하지 않습니다.
  /// 읽지 못하면 false(목록은 그대로).
  Future<bool> loadMore() async {
    final current = state.value;
    final cursor = current?.nextCursor;
    if (current == null || cursor == null || _loadingMore) return true;
    _loadingMore = true;
    try {
      final next = await ref
          .read(communityRepositoryProvider)
          .tips(target, cursor: cursor);
      // 읽는 사이 목록이 새로 읽혔으면(등록 등) 이어 붙이지 않습니다.
      if (!ref.mounted || !identical(state.value, current)) return true;
      state = AsyncData(
        current.copyWith(
          total: next.total,
          items: [...current.items, ...next.items],
          nextCursor: next.nextCursor,
        ),
      );
      return true;
    } on ApiException {
      return false;
    } finally {
      _loadingMore = false;
    }
  }
}

final tipsProvider =
    AsyncNotifierProvider.family<TipsNotifier, TipsResponse, CommunityTarget>(
      TipsNotifier.new,
      retry: noRetry,
    );

/// 팁의 답글 목록(오래된 순). 시트를 닫으면 버리고, 열 때마다 새로 읽습니다.
class RepliesNotifier extends AsyncNotifier<List<Reply>> {
  RepliesNotifier(this.tipId);

  final String tipId;

  @override
  Future<List<Reply>> build() {
    ref.watch(_viewerProvider);
    return ref.watch(communityRepositoryProvider).replies(tipId);
  }

  /// 답글을 올리고 목록 끝에 붙입니다. 실패는 [ApiException] 으로 던집니다.
  Future<void> post(String body, {required String authorName}) async {
    final reply = await ref
        .read(communityRepositoryProvider)
        .postReply(tipId, body: body, authorName: authorName);
    if (!ref.mounted) return;
    state = AsyncData([...?state.value, reply]);
  }

  /// 내 답글을 지우고 목록에서 뺍니다. 실패는 [ApiException] 으로 던집니다.
  Future<void> delete(String replyId) async {
    await ref.read(communityRepositoryProvider).deleteReply(tipId, replyId);
    if (!ref.mounted) return;
    state = AsyncData([
      for (final r in state.value ?? const <Reply>[])
        if (r.id != replyId) r,
    ]);
  }
}

final repliesProvider = AsyncNotifierProvider.autoDispose
    .family<RepliesNotifier, List<Reply>, String>(
      RepliesNotifier.new,
      retry: noRetry,
    );

/// 체감 투표 결과 · 이달의 사진. 연간이면 최신 달(12월) 기준입니다(웹과 같음).
/// 지역은 프리셋마다 다른 투표입니다([preset] 이 null 이면 조용한 곳). 동네는 프리셋이 없습니다.
typedef PollArg = ({CommunityTarget target, String month, PresetKey? preset});

String pollMonthOf(String month) =>
    month == Months.annual ? Months.defaultMonth : month;

/// 지역 체감 투표 질문. 서버 `webapi/poll.py` 의 `question` 과 같은 문구입니다.
String regionPollQuestion(String month, String name, PresetKey? preset) {
  final tail = switch (preset ?? PresetKey.quiet) {
    PresetKey.quiet => '실제로 조용했나요?',
    PresetKey.lively => '실제로 활기 있었나요?',
    PresetKey.custom => '어땠나요?',
  };
  return '${Months.label(pollMonthOf(month))} $name, $tail';
}

final pollProvider = FutureProvider.family<PollResponse, PollArg>((ref, arg) {
  ref.watch(_viewerProvider);
  return ref
      .watch(communityRepositoryProvider)
      .poll(arg.target, pollMonthOf(arg.month), preset: arg.preset);
});
