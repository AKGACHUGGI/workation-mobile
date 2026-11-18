import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/data/repositories/auth_repository.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';

import '../../fakes/auth.dart';

void main() {
  test('처음에는 로그인하지 않은 상태다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(sessionProvider), isNull);
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('mock 로그인하면 제공자에 맞는 사용자가 들어오고, 로그아웃하면 비워진다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final session = container.read(sessionProvider.notifier);

    session.signInMock(AuthProviderKind.google);
    final user = container.read(sessionProvider)!;
    expect(user.nickname, '두이');
    expect(user.initial, '두');
    expect(user.provider, AuthProviderKind.google);
    expect(user.emailMasked, 'du***@gmail.com');
    expect(container.read(isLoggedInProvider), isTrue);

    session.signOut();
    expect(container.read(sessionProvider), isNull);
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('로그인 제공자는 카카오와 Google 둘뿐이다(Apple 없음)', () {
    expect(AuthProviderKind.values.map((k) => k.label), ['카카오', 'Google']);
  });

  test('AuthUser.fromJson 은 /api/me 의 Me 를 읽는다', () {
    final me = AuthUser.fromJson({
      'id': 'b1f0',
      'nickname': '워케이션러',
      'initial': '워',
      'provider': 'google',
      'emailMasked': 'du***@gmail.com',
      'needsOnboarding': true,
      'createdAt': '2026-11-17T10:00:00+09:00',
    });
    expect(me.provider, AuthProviderKind.google);
    expect(me.needsOnboarding, isTrue);
    expect(me.copyWith(nickname: '바다').initial, '바');
  });

  group('Supabase 흐름 (가짜 리포지토리)', () {
    late FakeAuthRepository repo;
    late ProviderContainer container;

    ProviderContainer make() {
      final c = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(c.dispose);
      c.read(sessionProvider); // build → 이벤트 구독
      return c;
    }

    Future<void> flush() => Future<void>.delayed(Duration.zero);

    test('signIn 은 브라우저만 띄우고, 딥링크 복귀(signedIn) 뒤 /api/me 로 로그인된다', () async {
      repo = FakeAuthRepository();
      container = make();

      await container
          .read(sessionProvider.notifier)
          .signIn(AuthProviderKind.kakao);
      expect(container.read(sessionProvider), isNull);

      repo.complete();
      await flush();
      expect(container.read(sessionProvider)!.nickname, '카카오사용자');
      expect(repo.calls, ['signIn kakao', 'GET /api/me']);
    });

    test('첫 로그인이면 온보딩 대기 → 닉네임 · 약관 저장 후 로그인된다', () async {
      repo = FakeAuthRepository(me: fakeMe.copyWith(needsOnboarding: true));
      container = make();

      repo.complete();
      await flush();
      expect(container.read(sessionProvider), isNull);
      expect(container.read(pendingOnboardingProvider), isNotNull);

      await container
          .read(sessionProvider.notifier)
          .completeOnboarding('  바다사람 ');
      expect(container.read(pendingOnboardingProvider), isNull);
      expect(container.read(sessionProvider)!.nickname, '바다사람');
      expect(repo.calls.last, 'PATCH /api/me 바다사람 true');
    });

    test('온보딩을 그만두면 로그아웃한다', () async {
      repo = FakeAuthRepository(me: fakeMe.copyWith(needsOnboarding: true));
      container = make();
      repo.complete();
      await flush();

      await container.read(sessionProvider.notifier).cancelOnboarding();
      expect(container.read(pendingOnboardingProvider), isNull);
      expect(container.read(sessionProvider), isNull);
      expect(repo.calls.last, 'signOut');
    });

    test('앱을 켤 때 저장된 세션이 있으면 사용자를 되살린다', () async {
      repo = FakeAuthRepository(hasSession: true);
      container = make();
      await flush();
      expect(container.read(sessionProvider)!.id, 'u_9');
    });

    test('되살린 세션이 온보딩 전이면 로그아웃한다(약관 미동의 세션을 남기지 않음)', () async {
      repo = FakeAuthRepository(
        hasSession: true,
        me: fakeMe.copyWith(needsOnboarding: true),
      );
      container = make();
      await flush();
      expect(container.read(sessionProvider), isNull);
      expect(container.read(pendingOnboardingProvider), isNull);
      expect(repo.calls, ['GET /api/me', 'signOut']);
    });

    test('복귀 뒤 /api/me 를 못 읽으면 로그아웃하고 실패를 알린다', () async {
      repo = FakeAuthRepository(failFetch: true);
      container = make();
      repo.complete();
      await flush();
      expect(container.read(sessionProvider), isNull);
      expect(container.read(loginFailureProvider), 1);
      expect(repo.calls.last, 'signOut');
    });

    test('세션이 끝나면(signedOut) 비로그인으로 돌아간다', () async {
      repo = FakeAuthRepository();
      container = make();
      repo.complete();
      await flush();
      expect(container.read(isLoggedInProvider), isTrue);

      repo.expire();
      await flush();
      expect(container.read(isLoggedInProvider), isFalse);
    });

    test('브라우저를 못 띄우면 signIn 이 던진다', () async {
      repo = FakeAuthRepository(failLaunch: true);
      container = make();
      await expectLater(
        container
            .read(sessionProvider.notifier)
            .signIn(AuthProviderKind.google),
        throwsStateError,
      );
    });
  });

  test('MockAuthRepository: 로그인하면 두이, 약관 저장 · 로그아웃이 메모리에 반영된다', () async {
    final repo = MockAuthRepository();
    expect(repo.hasSession, isFalse);
    final me = await repo.signIn(AuthProviderKind.kakao);
    expect(me!.nickname, '두이');
    expect((await repo.updateMe(nickname: '두이두이')).nickname, '두이두이');
    await repo.signOut();
    expect(await repo.fetchMe(), isNull);
  });
}
