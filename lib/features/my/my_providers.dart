import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';
import '../../core/network/retry.dart';
import '../../data/models/community.dart';
import '../../data/models/me.dart';
import '../../data/repositories/me_repository.dart';
import '../auth/auth_providers.dart';
import '../community/community_providers.dart';

/// 알림 설정 항목 (`PATCH /api/me/settings` 의 키와 같습니다).
enum NotifySetting {
  bestMonth('notifyBestMonth', '가기 좋은 달 알림', '즐겨찾기 지역의 추천 월이 다가오면 알려드려요'),
  tipReaction('notifyTipReaction', '내 팁 반응 알림', '도움돼요·답글이 달리면 알려드려요'),
  photoSelected(
    'notifyPhotoSelected',
    '이달의 사진 선정 알림',
    '내 사진이 지역 헤더로 선정되면 알려드려요',
  );

  const NotifySetting(this.key, this.label, this.hint);

  final String key;
  final String label;
  final String hint;

  bool valueOf(MeSettings s) => switch (this) {
    bestMonth => s.notifyBestMonth,
    tipReaction => s.notifyTipReaction,
    photoSelected => s.notifyPhotoSelected,
  };

  MeSettings apply(MeSettings s, bool value) => switch (this) {
    bestMonth => s.copyWith(notifyBestMonth: value),
    tipReaction => s.copyWith(notifyTipReaction: value),
    photoSelected => s.copyWith(notifyPhotoSelected: value),
  };
}

/// 알림 설정. 바꾸면 먼저 화면에 반영하고 `PATCH` 한 뒤, 실패하면 되돌립니다.
/// 로그아웃 · 재로그인하면 다시 읽습니다.
class MeSettingsNotifier extends AsyncNotifier<MeSettings> {
  @override
  Future<MeSettings> build() {
    ref.watch(sessionProvider);
    return ref.read(meRepositoryProvider).settings();
  }

  /// 저장하지 못하면 false(화면은 이전 값으로 돌아갑니다).
  Future<bool> set(NotifySetting setting, bool value) async {
    final current = state.value;
    if (current == null) return false;
    state = AsyncData(setting.apply(current, value));
    try {
      final saved = await ref
          .read(meRepositoryProvider)
          .patchSettings(
            notifyBestMonth: setting == NotifySetting.bestMonth ? value : null,
            notifyTipReaction: setting == NotifySetting.tipReaction
                ? value
                : null,
            notifyPhotoSelected: setting == NotifySetting.photoSelected
                ? value
                : null,
          );
      if (ref.mounted) state = AsyncData(saved);
      return true;
    } on Object {
      if (ref.mounted) {
        state = AsyncData(setting.apply(state.value ?? current, !value));
      }
      return false;
    }
  }
}

// 설정 · 내 팁 · 내 사진은 화면에 [다시 시도] 가 있어 저절로 다시 부르지 않습니다.
final meSettingsProvider =
    AsyncNotifierProvider<MeSettingsNotifier, MeSettings>(
      MeSettingsNotifier.new,
      retry: noRetry,
    );

/// 서버에 아직 없는 기능인지(501). 다시 불러도 소용없어 "준비 중"으로 보여 줍니다.
bool isNotImplemented(Object? error) =>
    error is ServerException && error.statusCode == 501;

/// 프로필 요약(체류 기록 · 가입일 · 활동 수). [다시 시도] 가 없는 자리라 연결 실패 ·
/// 5xx 만 저절로 다시 부릅니다.
final meSummaryProvider = FutureProvider<MeSummary>((ref) {
  ref.watch(sessionProvider);
  return ref.read(meRepositoryProvider).summary();
}, retry: retryTransient);

/// 내가 쓴 팁. 첫 쪽을 읽고 [loadMore] 로 다음 쪽을 이어 붙입니다.
/// 로그아웃 · 재로그인하면 다시 읽습니다.
class MyTipsNotifier extends AsyncNotifier<MyTipsResponse> {
  bool _loadingMore = false;

  @override
  Future<MyTipsResponse> build() {
    ref.watch(sessionProvider);
    return ref.read(meRepositoryProvider).tips();
  }

  /// 다음 쪽을 이어 붙입니다. 다음 쪽이 없으면 아무 일도 하지 않습니다.
  /// 읽지 못하면 false(목록은 그대로).
  Future<bool> loadMore() async {
    final current = state.value;
    final cursor = current?.nextCursor;
    if (current == null || cursor == null || _loadingMore) return true;
    _loadingMore = true;
    try {
      final next = await ref.read(meRepositoryProvider).tips(cursor: cursor);
      // 읽는 사이 목록이 새로 읽혔으면 이어 붙이지 않습니다.
      if (!ref.mounted || !identical(state.value, current)) return true;
      // helpfulSum 은 어느 쪽에서나 전체 합계라 첫 쪽 값을 그대로 둡니다.
      state = AsyncData(
        current.copyWith(
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

  /// 내 팁을 지웁니다. 지우지 못하면 false(목록은 그대로).
  ///
  /// 성공하면 목록 · 합계에서 빼고, 요약(팁 수)과 그 지역 · 동네의 팁 목록을 다시
  /// 읽게 합니다. 서버의 `cursor` 는 읽은 개수라 다음 쪽이 남아 있으면 한 칸이 밀려
  /// 빠지는 팁이 생기므로, 그때는 첫 쪽부터 다시 읽어 바꿉니다.
  Future<bool> deleteTip(MyTip tip) async {
    final repo = ref.read(meRepositoryProvider);
    try {
      await repo.deleteTip(tip.id);
    } on ApiException {
      return false;
    }
    if (!ref.mounted) return true;
    ref.invalidate(meSummaryProvider);
    ref.invalidate(
      tipsProvider(
        tip.target.kind == TipTargetKind.region
            ? CommunityTarget.region(tip.target.id)
            : CommunityTarget.dong(tip.target.id),
      ),
    );
    final current = state.value;
    if (current == null) return true;
    final left = [
      for (final t in current.items)
        if (t.id != tip.id) t,
    ];
    var next = current.copyWith(
      items: left,
      helpfulSum: current.helpfulSum - tip.helpful,
    );
    if (current.nextCursor != null) {
      try {
        next = await repo.tips();
      } on ApiException {
        // 다시 읽지 못하면 빼기만 합니다.
      }
      if (!ref.mounted) return true;
    }
    state = AsyncData(next);
    return true;
  }
}

final myTipsProvider = AsyncNotifierProvider<MyTipsNotifier, MyTipsResponse>(
  MyTipsNotifier.new,
  retry: noRetry,
);

final myPhotosProvider = FutureProvider<MyPhotosResponse>((ref) {
  ref.watch(sessionProvider);
  return ref.read(meRepositoryProvider).photos();
}, retry: noRetry);
