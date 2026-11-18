import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/dong_detail.dart';
import '../../data/models/explore.dart';
import '../../data/repositories/dong_repository.dart';
import '../../data/repositories/explore_repository.dart';

/// 동네 상세. 인자는 행정동 코드와 월(`2025-10` · `annual`).
final dongDetailProvider =
    FutureProvider.family<DongDetail, ({String id, String month})>(
      (ref, arg) => ref.watch(dongRepositoryProvider).detail(arg.id, arg.month),
    );

/// 워케이션 유형 카드용 동 요약(`GET /api/explore/dongs/{id}`). 실패하면 카드만 숨깁니다.
final dongTypesProvider = FutureProvider.family<ExploreDong, String>(
  (ref, id) => ref.watch(exploreRepositoryProvider).dong(id),
);
