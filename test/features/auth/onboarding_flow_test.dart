import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';
import 'package:workation_mobile/features/auth/login_screen.dart';
import 'package:workation_mobile/features/auth/onboarding_screen.dart';
import 'package:workation_mobile/features/home/home_screen.dart';

import '../../fakes/auth.dart';
import '../../helpers.dart';

void main() {
  ProviderContainer containerOf(WidgetTester tester) =>
      ProviderScope.containerOf(
        tester.element(find.byType(HomeScreen, skipOffstage: false)),
      );

  Future<void> openLogin(WidgetTester tester) async {
    await tester.tap(find.byTooltip('로그인'));
    await tester.pumpAndSettle();
  }

  FilledButton startButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, '시작하기'));

  test('닉네임은 공백을 다듬고 2~12자', () {
    expect(validateNickname(' 바 '), isNotNull);
    expect(validateNickname('바다'), isNull);
    expect(validateNickname('가' * 12), isNull);
    expect(validateNickname('가' * 13), '닉네임은 2~12자로 입력해 주세요');
  });

  testWidgets('브라우저 로그인 → 딥링크 복귀 → 로그인 화면이 true 로 닫힌다', (tester) async {
    final auth = FakeAuthRepository();
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('Google로 시작하기'));
    await tester.pump();
    // 브라우저가 떠 있는 동안 버튼에 진행 표시
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(LoginScreen), findsOneWidget);

    auth.complete();
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsNothing);
    expect(containerOf(tester).read(sessionProvider)!.id, 'u_9');
    expect(find.byTooltip('내 계정'), findsOneWidget);
  });

  testWidgets('첫 로그인: 온보딩에서 닉네임 · 약관 2개를 마치면 로그인된다', (tester) async {
    final auth = FakeAuthRepository(me: fakeMe.copyWith(needsOnboarding: true));
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pump();
    auth.complete();
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('거의 다 됐어요'), findsOneWidget);
    expect(find.text('카카오사용자'), findsOneWidget); // 제공자 이름이 기본 닉네임
    expect(startButton(tester).onPressed, isNull);

    await tester.tap(find.text('이용약관에 동의합니다'));
    await tester.pump();
    expect(startButton(tester).onPressed, isNull); // 하나 더 남음
    await tester.tap(find.text('개인정보 처리방침에 동의합니다'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), '바');
    await tester.pump();
    expect(find.text('닉네임은 2~12자로 입력해 주세요'), findsOneWidget);
    expect(startButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '바다사람');
    await tester.pump();
    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsNothing);
    expect(find.byType(LoginScreen), findsNothing);
    expect(containerOf(tester).read(sessionProvider)!.nickname, '바다사람');
    expect(auth.calls.last, 'PATCH /api/me 바다사람 true');
  });

  testWidgets('온보딩을 닫으면 로그아웃하고 로그인 화면으로 돌아간다', (tester) async {
    final auth = FakeAuthRepository(me: fakeMe.copyWith(needsOnboarding: true));
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pump();
    auth.complete();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('닫기').last);
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('약관에 동의해야 이용할 수 있어요'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(auth.calls.last, 'signOut');
    expect(containerOf(tester).read(sessionProvider), isNull);
  });

  testWidgets('브라우저를 못 띄우면 안내하고 버튼을 되돌린다', (tester) async {
    final auth = FakeAuthRepository(failLaunch: true);
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();

    expect(find.text('로그인을 시작하지 못했어요. 잠시 후 다시 시도해 주세요'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('복귀 뒤 /api/me 를 못 읽으면 안내하고 버튼을 되돌린다', (tester) async {
    final auth = FakeAuthRepository(failFetch: true);
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pump();
    auth.complete();
    await tester.pumpAndSettle();

    expect(find.text('로그인하지 못했어요. 다시 시도해 주세요'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(containerOf(tester).read(sessionProvider), isNull);
  });

  testWidgets('브라우저를 닫고 돌아오면 잠시 뒤 진행 표시를 거둔다', (tester) async {
    final auth = FakeAuthRepository();
    await pumpApp(tester, auth: auth);

    await openLogin(tester);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(loginResumeGrace);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
