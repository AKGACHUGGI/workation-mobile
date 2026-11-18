import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;
import 'package:url_launcher/url_launcher.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/auth_user.dart';

/// 로그인 상태 변화 중 앱이 신경 쓰는 두 가지.
enum AuthEvent {
  /// OAuth 를 마치고 세션이 생김(딥링크 복귀)
  signedIn,

  /// 세션이 끝남(로그아웃 · refresh token 만료)
  signedOut,
}

/// 로그인(M-06) · 내 정보(`/api/me`).
///
/// 로그인 · 토큰 저장 · 갱신은 Supabase Auth 가 하고, 백엔드는 `Authorization: Bearer`
/// 로 받은 Supabase JWT 를 검증합니다(workation-backend #25, 웹 #22 와 같은 방식).
abstract class AuthRepository {
  /// 앱을 켰을 때 저장된 세션이 있는지. 있으면 `/api/me` 로 사용자를 다시 읽습니다.
  bool get hasSession;

  Stream<AuthEvent> get events;

  /// 로그인을 시작합니다. mock 은 사용자를 바로 돌려주고, Supabase 는 브라우저를 띄운 뒤
  /// null 을 돌려줍니다(결과는 [events] 의 [AuthEvent.signedIn] 으로 옵니다).
  Future<AuthUser?> signIn(AuthProviderKind provider);

  /// `GET /api/me` — 첫 호출이면 백엔드가 사용자를 만듭니다. 401 이면 null.
  Future<AuthUser?> fetchMe();

  /// `PATCH /api/me` — 닉네임 · 약관 동의 시각(`agreedAt`, ISO 8601).
  Future<AuthUser> updateMe({String? nickname, String? agreedAt});

  Future<void> signOut();
}

/// Supabase Auth + 백엔드 `/api/me`. [_auth] 가 null 이면 Supabase 값이 없는 빌드라
/// 로그인을 시작할 수 없습니다(비로그인으로만 동작).
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth, this._client);

  final GoTrueClient? _auth;
  final ApiClient _client;

  @override
  bool get hasSession => _auth?.currentSession != null;

  @override
  Stream<AuthEvent> get events {
    final auth = _auth;
    if (auth == null) return const Stream.empty();
    return auth.onAuthStateChange
        .map(
          (s) => switch (s.event) {
            AuthChangeEvent.signedIn => AuthEvent.signedIn,
            AuthChangeEvent.signedOut => AuthEvent.signedOut,
            _ => null,
          },
        )
        .where((e) => e != null)
        .cast<AuthEvent>()
        .map((e) {
          // 딥링크로 돌아오면 iOS 의 인앱 브라우저(SFSafariViewController)를 닫습니다.
          if (e == AuthEvent.signedIn) unawaited(_closeBrowser());
          return e;
        });
  }

  static Future<void> _closeBrowser() async {
    try {
      await closeInAppWebView();
    } catch (_) {
      // 인앱 브라우저가 아니었으면(외부 브라우저 · Android) 닫을 것이 없습니다.
    }
  }

  @override
  Future<AuthUser?> signIn(AuthProviderKind provider) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('Supabase 설정이 없습니다 (SUPABASE_URL · SUPABASE_ANON_KEY)');
    }
    final launched = await auth.signInWithOAuth(switch (provider) {
      AuthProviderKind.kakao => OAuthProvider.kakao,
      AuthProviderKind.google => OAuthProvider.google,
    }, redirectTo: ApiConfig.authRedirectUrl);
    if (!launched) throw StateError('로그인 페이지를 열지 못했습니다');
    return null;
  }

  @override
  Future<AuthUser?> fetchMe() async {
    try {
      return AuthUser.fromJson(
        await _client.get('/api/me') as Map<String, dynamic>,
      );
    } on UnauthorizedException {
      return null;
    }
  }

  @override
  Future<AuthUser> updateMe({String? nickname, String? agreedAt}) async =>
      AuthUser.fromJson(
        await _client.patch(
          '/api/me',
          body: {'nickname': ?nickname, 'agreedAt': ?agreedAt},
        ) as Map<String, dynamic>,
      );

  @override
  Future<void> signOut() async => _auth?.signOut();
}

/// mock 로그인이 끝나기까지 보이는 짧은 로딩.
const loginMockDelay = Duration(milliseconds: 600);

/// mock 사용자 "두이"(웹 mock 과 같음). 브라우저 없이 바로 로그인됩니다.
AuthUser mockUser(AuthProviderKind provider) => AuthUser(
  id: 'u_1',
  nickname: '두이',
  initial: '두',
  provider: provider,
  emailMasked: provider == AuthProviderKind.kakao
      ? 'du***@kakao.com'
      : 'du***@gmail.com',
);

class MockAuthRepository implements AuthRepository {
  AuthUser? _me;

  @override
  bool get hasSession => false;

  @override
  Stream<AuthEvent> get events => const Stream.empty();

  @override
  Future<AuthUser?> signIn(AuthProviderKind provider) async {
    await Future<void>.delayed(loginMockDelay);
    return _me = mockUser(provider);
  }

  @override
  Future<AuthUser?> fetchMe() async => _me;

  @override
  Future<AuthUser> updateMe({String? nickname, String? agreedAt}) async {
    final me = _me;
    if (me == null) throw const UnauthorizedException('/api/me');
    return _me = me.copyWith(
      nickname: nickname,
      needsOnboarding: agreedAt != null ? false : null,
    );
  }

  @override
  Future<void> signOut() async => _me = null;
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (ApiConfig.useMock) return MockAuthRepository();
  return SupabaseAuthRepository(
    ApiConfig.authEnabled ? Supabase.instance.client.auth : null,
    ref.watch(apiClientProvider),
  );
});
