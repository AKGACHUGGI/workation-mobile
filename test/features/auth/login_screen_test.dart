import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';
import 'package:workation_mobile/features/auth/login_screen.dart';
import 'package:workation_mobile/features/home/home_providers.dart';
import 'package:workation_mobile/features/home/home_screen.dart';
import 'package:workation_mobile/shared/widgets/icon_button_circle.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';
import 'package:workation_mobile/shared/widgets/social_login_button.dart';

import '../../fakes/account.dart';
import '../../helpers.dart';

void main() {
  ProviderContainer containerOf(WidgetTester tester) =>
      ProviderScope.containerOf(tester.element(find.byType(HomeScreen)));

  Future<void> openLoginFromHome(WidgetTester tester) async {
    await tester.tap(find.byTooltip('로그인'));
    await tester.pumpAndSettle();
  }

  testWidgets('로그인 화면: 카카오 · Google 버튼과 둘러보기 · 닫기 · 약관 문구가 있다', (tester) async {
    await pumpApp(tester, location: AppRoutes.login);

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('당신의 장소를 찾으세요'), findsOneWidget);
    expect(find.text('카카오로 시작하기'), findsOneWidget);
    expect(find.text('Google로 시작하기'), findsOneWidget);
    expect(find.textContaining('Apple'), findsNothing);
    expect(find.text('로그인 없이 둘러보기'), findsOneWidget);
    expect(find.byTooltip('닫기'), findsOneWidget);
    expect(find.textContaining('이용약관 및 개인정보처리방침'), findsOneWidget);
    // 하단 내비 없이 화면 전체를 씁니다.
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('홈 헤더 로그인 버튼 → 카카오로 로그인하면 true 로 닫히고 헤더가 아바타로 바뀐다', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.byTooltip('로그인'), findsOneWidget);
    await openLoginFromHome(tester);
    await tester.tap(find.byType(SocialLoginButton).first);
    await tester.pump(); // 짧은 로딩이 보인다
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsNothing);
    expect(
      containerOf(tester).read(sessionProvider)!.provider,
      AuthProviderKind.kakao,
    );
    expect(find.byTooltip('로그인'), findsNothing);
    expect(find.byTooltip('내 계정'), findsOneWidget);
    expect(find.text('두'), findsOneWidget);
  });

  testWidgets('Google 로 로그인하면 Google 연결 사용자가 된다', (tester) async {
    await pumpApp(tester);

    await openLoginFromHome(tester);
    await tester.tap(find.text('Google로 시작하기'));
    await tester.pumpAndSettle();

    expect(
      containerOf(tester).read(sessionProvider)!.provider,
      AuthProviderKind.google,
    );
  });

  testWidgets('둘러보기 · 닫기는 false 로 돌아가고 로그인하지 않는다', (tester) async {
    await pumpApp(tester);

    await openLoginFromHome(tester);
    await tester.tap(find.text('로그인 없이 둘러보기'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsNothing);
    expect(containerOf(tester).read(sessionProvider), isNull);

    await openLoginFromHome(tester);
    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsNothing);
    expect(containerOf(tester).read(sessionProvider), isNull);
    expect(find.byTooltip('로그인'), findsOneWidget);
  });

  testWidgets('로그인 후 아바타를 누르면 MY 탭으로 간다', (tester) async {
    await pumpApp(tester, loggedIn: true);

    await tester.tap(find.byTooltip('내 계정'));
    await tester.pumpAndSettle();

    expect(find.text('두이'), findsOneWidget);
    expect(find.text('알림 설정'), findsOneWidget);
  });

  testWidgets('비로그인 홈 카드의 북마크 → 로그인 → 이어서 저장된다', (tester) async {
    final favorites = FakeFavoritesRepository();
    await pumpApp(tester, favorites: favorites);

    List<bool> saved() => [
      for (final c in tester.widgetList<ListingCardMobile>(
        find.byType(ListingCardMobile),
      ))
        c.saved,
    ];
    expect(saved(), [false, false, false]);

    // 둘째 카드(양양군)의 북마크
    await tester.tap(find.byIcon(LucideIcons.bookmark).at(1));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    await tester.tap(find.byType(SocialLoginButton).first);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsNothing);
    expect(favorites.calls, ['PUT regions/51830']);
    // 고성군은 서버에 원래 저장돼 있었고, 양양군이 이어서 저장됐다.
    expect(saved(), [true, true, false]);
  });

  testWidgets('로그인을 닫으면 저장하지 않는다', (tester) async {
    final favorites = FakeFavoritesRepository();
    await pumpApp(tester, favorites: favorites);

    await tester.tap(find.byIcon(LucideIcons.bookmark).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();

    expect(favorites.calls, isEmpty);
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('로그인 상태에서 북마크를 누르면 저장이 바뀐다(해제 → 다시 저장)', (tester) async {
    final favorites = FakeFavoritesRepository();
    await pumpApp(tester, favorites: favorites, loggedIn: true);

    // 고성군(첫째 카드)은 저장 상태 → 해제
    await tester.tap(find.byType(IconButtonCircle).first);
    await tester.pumpAndSettle();
    expect(favorites.calls, ['DELETE regions/51820']);
    expect(
      tester
          .widgetList<ListingCardMobile>(find.byType(ListingCardMobile))
          .first
          .saved,
      isFalse,
    );

    await tester.tap(find.byType(IconButtonCircle).first);
    await tester.pumpAndSettle();
    expect(favorites.calls.last, 'PUT regions/51820');
  });

  testWidgets('헤더 가중치 버튼 → 시트에서 직접 맞추면 프리셋이 직접 설정이 된다', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('가중치'));
    await tester.pumpAndSettle();
    expect(find.text('종합 점수 가중치'), findsOneWidget);
    expect(find.byType(Slider), findsNWidgets(MetricKey.values.length));

    // 처음 값은 지금 프리셋(조용한 곳 3·3·1·1·0). 첫 슬라이더(동네 조용함)를 0 으로.
    await tester.drag(find.byType(Slider).first, const Offset(-600, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('적용'));
    await tester.pumpAndSettle();

    final filter = containerOf(tester).read(homeFilterProvider);
    expect(filter.preset, PresetKey.custom);
    expect(filter.weights.quiet, 0);
    expect(filter.weights.crowd, 3);
    expect(find.text('직접 설정 프리셋'), findsOneWidget);
  });

  testWidgets('가중치를 모두 0 으로 두면 적용할 수 없다', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('가중치'));
    await tester.pumpAndSettle();
    for (var i = 0; i < MetricKey.values.length; i++) {
      // 슬라이더 왼쪽 끝 근처를 눌러 0 으로 맞춥니다.
      final box = find.byType(Slider).at(i);
      final left =
          tester.getTopLeft(box) + Offset(26, tester.getSize(box).height / 2);
      await tester.tapAt(left);
      await tester.pumpAndSettle();
    }

    expect(find.text('하나 이상은 0보다 크게 맞춰 주세요'), findsOneWidget);
    final apply = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, '적용'),
    );
    expect(apply.onPressed, isNull);
  });
}
