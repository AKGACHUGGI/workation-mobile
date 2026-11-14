import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/me.dart';
import '../../data/repositories/me_repository.dart';
import '../auth/auth_providers.dart';

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

final meSettingsProvider =
    AsyncNotifierProvider<MeSettingsNotifier, MeSettings>(
      MeSettingsNotifier.new,
    );

/// 프로필 요약(체류 기록 · 가입일 · 활동 수).
final meSummaryProvider = FutureProvider<MeSummary>((ref) {
  ref.watch(sessionProvider);
  return ref.read(meRepositoryProvider).summary();
});

final myTipsProvider = FutureProvider<MyTipsResponse>((ref) {
  ref.watch(sessionProvider);
  return ref.read(meRepositoryProvider).tips();
});

final myPhotosProvider = FutureProvider<MyPhotosResponse>((ref) {
  ref.watch(sessionProvider);
  return ref.read(meRepositoryProvider).photos();
});
