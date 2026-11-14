import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/month.dart';
import '../../data/models/community.dart';
import '../../data/repositories/community_repository.dart';

/// 한 줄 팁 목록(도움순). 등록하면 invalidate 해서 다시 읽습니다.
final tipsProvider = FutureProvider.family<TipsResponse, CommunityTarget>(
  (ref, target) => ref.watch(communityRepositoryProvider).tips(target),
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
