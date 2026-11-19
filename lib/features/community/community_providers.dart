import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/month.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/retry.dart';
import '../../data/models/community.dart';
import '../../data/repositories/community_repository.dart';

/// 한 줄 팁 목록(도움순). 첫 쪽을 읽고 [loadMore] 로 다음 쪽을 이어 붙입니다.
/// 등록하면 invalidate 해서 첫 쪽부터 다시 읽습니다.
class TipsNotifier extends AsyncNotifier<TipsResponse> {
  TipsNotifier(this.target);

  final CommunityTarget target;
  bool _loadingMore = false;

  @override
  Future<TipsResponse> build() =>
      ref.watch(communityRepositoryProvider).tips(target);

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

/// 체감 투표 결과 · 이달의 사진. 연간이면 최신 달(12월) 기준입니다(웹과 같음).
typedef PollArg = ({CommunityTarget target, String month});

String pollMonthOf(String month) =>
    month == Months.annual ? Months.defaultMonth : month;

final pollProvider = FutureProvider.family<PollResponse, PollArg>(
  (ref, arg) => ref
      .watch(communityRepositoryProvider)
      .poll(arg.target, pollMonthOf(arg.month)),
);
