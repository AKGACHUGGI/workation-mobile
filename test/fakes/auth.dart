import 'dart:async';

import 'package:workation_mobile/data/repositories/auth_repository.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';

const fakeMe = AuthUser(
  id: 'u_9',
  nickname: '카카오사용자',
  initial: '카',
  provider: AuthProviderKind.kakao,
  emailMasked: 'ka***@kakao.com',
);

/// Supabase 처럼 동작하는 가짜: [signIn] 은 브라우저만 띄우고(null), 결과는 [complete] 가
/// [AuthEvent.signedIn] 을 흘려서 알립니다. 호출은 [calls] 에 쌓입니다.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    this.me = fakeMe,
    this.hasSession = false,
    this.failFetch = false,
    this.failLaunch = false,
  });

  /// `/api/me` 가 돌려줄 사용자. null 이면 401.
  AuthUser? me;

  @override
  bool hasSession;

  bool failFetch;
  bool failLaunch;

  final calls = <String>[];
  final _events = StreamController<AuthEvent>.broadcast();

  @override
  Stream<AuthEvent> get events => _events.stream;

  /// 딥링크 복귀를 흉내 냅니다.
  void complete() {
    hasSession = true;
    _events.add(AuthEvent.signedIn);
  }

  /// refresh 만료 · 다른 곳 로그아웃을 흉내 냅니다.
  void expire() {
    hasSession = false;
    _events.add(AuthEvent.signedOut);
  }

  @override
  Future<AuthUser?> signIn(AuthProviderKind provider) async {
    calls.add('signIn ${provider.name}');
    if (failLaunch) throw StateError('no browser');
    return null;
  }

  @override
  Future<AuthUser?> fetchMe() async {
    calls.add('GET /api/me');
    if (failFetch) throw StateError('network');
    return me;
  }

  @override
  Future<AuthUser> updateMe({String? nickname, String? agreedAt}) async {
    calls.add('PATCH /api/me $nickname ${agreedAt != null}');
    return me = me!.copyWith(nickname: nickname, needsOnboarding: false);
  }

  @override
  Future<void> signOut() async {
    calls.add('signOut');
    hasSession = false;
  }
}
