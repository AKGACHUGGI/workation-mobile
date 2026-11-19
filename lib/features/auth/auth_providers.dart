import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/auth_user.dart';
import '../../data/repositories/auth_repository.dart';

export '../../data/models/auth_user.dart';

/// 지금 로그인한 사용자. 로그인하지 않았거나 온보딩 전이면 null 입니다.
///
/// - 앱을 켤 때 저장된 Supabase 세션이 있으면 `/api/me` 로 다시 읽습니다.
///   온보딩을 마치지 않은 세션이면 약관 미동의 세션을 남기지 않도록 로그아웃합니다(웹과 같음).
/// - OAuth 복귀([AuthEvent.signedIn]) → `/api/me` → 온보딩이 필요하면 [pendingOnboardingProvider],
///   아니면 로그인 완료.
/// - 세션이 끝나면([AuthEvent.signedOut]: 로그아웃 · refresh 만료) 비로그인으로 돌아갑니다.
class SessionNotifier extends Notifier<AuthUser?> {
  @override
  AuthUser? build() {
    final repo = ref.watch(authRepositoryProvider);
    final sub = repo.events.listen(_onEvent);
    ref.onDispose(sub.cancel);
    if (repo.hasSession) Future.microtask(() => _loadMe(restoring: true));
    return null;
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  void _onEvent(AuthEvent event) {
    switch (event) {
      case AuthEvent.signedIn:
        if (state == null) unawaited(_loadMe(restoring: false));
      case AuthEvent.signedOut:
        state = null;
        ref.read(pendingOnboardingProvider.notifier).set(null);
    }
  }

  Future<void> _loadMe({required bool restoring}) async {
    try {
      final me = await _repo.fetchMe();
      if (me == null) {
        // 토큰을 백엔드가 받지 않음(만료 · 다른 프로젝트) — 세션을 정리합니다.
        await _repo.signOut();
        if (!restoring) _fail();
      } else if (me.needsOnboarding) {
        if (restoring) {
          await _repo.signOut();
        } else {
          ref.read(pendingOnboardingProvider.notifier).set(me);
        }
      } else {
        state = me;
      }
    } catch (_) {
      // 앱을 켤 때의 네트워크 실패는 세션을 남겨 두고 다음 실행에 다시 읽습니다.
      if (!restoring) {
        await _repo.signOut();
        _fail();
      }
    }
  }

  void _fail() => ref.read(loginFailureProvider.notifier).bump();

  /// 로그인을 시작합니다. mock 은 바로 로그인되고, Supabase 는 브라우저를 띄운 뒤
  /// 딥링크로 돌아왔을 때 [_onEvent] 에서 마무리합니다. 시작하지 못하면 던집니다.
  Future<void> signIn(AuthProviderKind provider) async {
    final me = await _repo.signIn(provider);
    if (me == null) return;
    if (me.needsOnboarding) {
      ref.read(pendingOnboardingProvider.notifier).set(me);
    } else {
      state = me;
    }
  }

  /// mock 로그인(테스트용). 웹 mock 의 가짜 사용자 "두이" 로 바로 들어갑니다.
  void signInMock(AuthProviderKind provider) => state = mockUser(provider);

  /// 온보딩 완료: 닉네임 + 약관 동의 시각을 저장하고 로그인을 끝냅니다. 실패하면 던집니다.
  Future<void> completeOnboarding(String nickname) async {
    final me = await _repo.updateMe(
      nickname: nickname.trim(),
      agreedAt: DateTime.now().toUtc().toIso8601String(),
    );
    ref.read(pendingOnboardingProvider.notifier).set(null);
    state = me.needsOnboarding ? null : me;
  }

  /// 온보딩을 그만둠: 약관 미동의 세션을 남기지 않도록 로그아웃합니다.
  Future<void> cancelOnboarding() async {
    ref.read(pendingOnboardingProvider.notifier).set(null);
    await _signOutQuietly();
  }

  void signOut() {
    state = null;
    ref.read(pendingOnboardingProvider.notifier).set(null);
    unawaited(_signOutQuietly());
  }

  /// 계정을 삭제하고 비로그인으로 돌아갑니다(정리는 [signOut] 과 같음). 서버가 거절하면
  /// 던지고 로그인 상태를 그대로 둡니다.
  Future<void> deleteAccount() async {
    await _repo.deleteAccount();
    state = null;
    ref.read(pendingOnboardingProvider.notifier).set(null);
  }

  Future<void> _signOutQuietly() async {
    try {
      await _repo.signOut();
    } catch (_) {
      // 네트워크가 없어도 기기의 세션은 지워집니다(supabase 가 로컬부터 지움).
    }
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, AuthUser?>(
  SessionNotifier.new,
);

final isLoggedInProvider = Provider<bool>(
  (ref) => ref.watch(sessionProvider) != null,
);

/// OAuth 는 마쳤지만 닉네임 · 약관 동의가 남은 사용자. 로그인 화면이 온보딩을 띄웁니다.
class PendingOnboardingNotifier extends Notifier<AuthUser?> {
  @override
  AuthUser? build() => null;

  void set(AuthUser? user) => state = user;
}

final pendingOnboardingProvider =
    NotifierProvider<PendingOnboardingNotifier, AuthUser?>(
      PendingOnboardingNotifier.new,
    );

/// 딥링크로 돌아온 뒤 `/api/me` 를 읽지 못한 횟수. 로그인 화면이 바뀔 때 안내를 띄웁니다.
class LoginFailureNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final loginFailureProvider = NotifierProvider<LoginFailureNotifier, int>(
  LoginFailureNotifier.new,
);
