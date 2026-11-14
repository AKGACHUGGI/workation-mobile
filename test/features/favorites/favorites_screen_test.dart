import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';
import 'package:workation_mobile/features/dong/dong_screen.dart';
import 'package:workation_mobile/features/favorites/favorites_screen.dart';
import 'package:workation_mobile/features/region/region_screen.dart';
import 'package:workation_mobile/shared/widgets/dong_row.dart';
import 'package:workation_mobile/shared/widgets/icon_button_circle.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';
import 'package:workation_mobile/shared/widgets/social_login_button.dart';

import '../../fakes/account.dart';
import '../../helpers.dart';

void main() {
  ProviderContainer containerOf(WidgetTester tester) =>
      ProviderScope.containerOf(tester.element(find.byType(FavoritesScreen)));

  testWidgets('비로그인: 안내와 로그인 버튼만 보이고, 로그인하면 저장한 것이 나온다', (tester) async {
    await pumpApp(tester, location: AppRoutes.favorites);

    expect(find.text('로그인하고 저장해 보세요'), findsOneWidget);
    expect(find.byType(ListingCardMobile), findsNothing);
    expect(find.byType(DongRow), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, '로그인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SocialLoginButton).first);
    await tester.pumpAndSettle();

    expect(find.text('로그인하고 저장해 보세요'), findsNothing);
    expect(find.text('즐겨찾기'), findsWidgets);
    expect(find.text('두이님 · 웹·앱 동기화됨 · 지역 1 · 동네 1'), findsOneWidget);
    expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
    expect(find.text('해안 · 속초시 인접'), findsOneWidget);
    expect(find.text('11월 2주 체류 예정'), findsOneWidget);
    expect(find.text('거진읍'), findsOneWidget);
    expect(find.text('생활권'), findsOneWidget);
    expect(find.text('고성군 · 저녁 활기 B · 또래 B'), findsOneWidget);
    expect(find.text('12월 기준'), findsOneWidget);
    expect(find.textContaining('웹에서도 같은 즐겨찾기를 볼 수 있어요'), findsOneWidget);
  });

  testWidgets('메모가 없으면 시기 여유 줄을 보여준다', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.favorites,
      loggedIn: true,
      favorites: FakeFavoritesRepository(
        regions: [fakeFavoriteRegion('51830', '양양군')],
        dongs: [],
      ),
    );

    expect(find.text('12월 시기 여유 B · 혼잡 37'), findsOneWidget);
    expect(find.text('동네'), findsNothing); // 동네가 없으면 섹션도 없다
  });

  testWidgets('지역 카드의 북마크로 해제하고 되돌리기로 다시 저장한다', (tester) async {
    final favorites = FakeFavoritesRepository();
    await pumpApp(
      tester,
      location: AppRoutes.favorites,
      loggedIn: true,
      favorites: favorites,
    );

    await tester.tap(find.byType(IconButtonCircle));
    await tester.pumpAndSettle();

    expect(favorites.calls, ['DELETE regions/51820']);
    expect(find.byType(ListingCardMobile), findsNothing);
    expect(find.text('즐겨찾기에서 뺐어요'), findsOneWidget);
    expect(find.text('두이님 · 웹·앱 동기화됨 · 지역 0 · 동네 1'), findsOneWidget);

    await tester.tap(find.text('되돌리기'));
    await tester.pumpAndSettle();

    expect(favorites.calls.last, 'PUT regions/51820');
    expect(find.byType(ListingCardMobile), findsOneWidget);
  });

  testWidgets('편집에서 동네를 해제하고, 다 비면 빈 상태가 된다', (tester) async {
    final favorites = FakeFavoritesRepository(regions: []);
    await pumpApp(
      tester,
      location: AppRoutes.favorites,
      loggedIn: true,
      favorites: favorites,
    );

    // 지역이 없으면 동네 쪽에 편집이 붙는다
    expect(find.byType(IconButtonCircle), findsNothing);
    await tester.tap(find.text('편집'));
    await tester.pumpAndSettle();
    expect(find.text('완료'), findsOneWidget);

    await tester.tap(find.byType(IconButtonCircle));
    await tester.pumpAndSettle();

    expect(favorites.calls, ['DELETE dongs/5182025300']);
    expect(find.byType(DongRow), findsNothing);
    expect(find.text('아직 즐겨찾기가 없어요'), findsOneWidget);
    expect(find.text('탐색하기'), findsOneWidget);
  });

  testWidgets('저장 목록이 비어 있으면 빈 상태의 탐색하기가 홈으로 보낸다', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.favorites,
      loggedIn: true,
      favorites: FakeFavoritesRepository(regions: [], dongs: []),
    );

    expect(find.text('아직 즐겨찾기가 없어요'), findsOneWidget);
    await tester.tap(find.text('탐색하기'));
    await tester.pumpAndSettle();

    expect(find.text('인기 지역 3곳'), findsOneWidget);
  });

  testWidgets('카드는 지역 상세로, 동네는 동네 프로필로 간다', (tester) async {
    await pumpApp(tester, location: AppRoutes.favorites, loggedIn: true);

    await tester.tap(find.text('고성군, 강원특별자치도'));
    await tester.pumpAndSettle();
    expect(find.byType(RegionScreen), findsOneWidget);
    expect(find.text('하반기 상승형'), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.chevronLeft));
    await tester.pumpAndSettle();
    await tester.tap(find.text('거진읍'));
    await tester.pumpAndSettle();
    expect(find.byType(DongScreen), findsOneWidget);
  });

  testWidgets('로그아웃하면 화면이 비워지고 안내로 돌아간다', (tester) async {
    await pumpApp(tester, location: AppRoutes.favorites, loggedIn: true);
    expect(find.byType(ListingCardMobile), findsOneWidget);

    containerOf(tester).read(sessionProvider.notifier).signOut();
    await tester.pumpAndSettle();

    expect(find.byType(ListingCardMobile), findsNothing);
    expect(find.byType(DongRow), findsNothing);
    expect(find.text('로그인하고 저장해 보세요'), findsOneWidget);
  });

  testWidgets('목록을 읽지 못하면 다시 시도로 복구한다', (tester) async {
    final favorites = FakeFavoritesRepository(failList: true);
    await pumpApp(
      tester,
      location: AppRoutes.favorites,
      loggedIn: true,
      favorites: favorites,
    );

    expect(find.text('즐겨찾기를 불러오지 못했습니다'), findsOneWidget);
    favorites.failList = false;
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();

    expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
  });

  testWidgets('지역 상세의 북마크: 비로그인이면 로그인 후 저장되고 버튼이 저장됨으로 바뀐다', (tester) async {
    final favorites = FakeFavoritesRepository(regions: [], dongs: []);
    await pumpApp(
      tester,
      location: AppRoutes.region('51820'),
      favorites: favorites,
    );

    expect(find.widgetWithText(FilledButton, '즐겨찾기'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, '즐겨찾기'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SocialLoginButton).first);
    await tester.pumpAndSettle();

    expect(favorites.calls, ['PUT regions/51820']);
    expect(find.widgetWithText(FilledButton, '저장됨'), findsOneWidget);

    // 헤더의 북마크로 해제
    await tester.tap(find.byType(IconButtonCircle).last);
    await tester.pumpAndSettle();
    expect(favorites.calls.last, 'DELETE regions/51820');
    expect(find.widgetWithText(FilledButton, '즐겨찾기'), findsOneWidget);
  });

  testWidgets('저장 상한이면 안내 문구를 보여주고 저장하지 않는다', (tester) async {
    final favorites = FakeFavoritesRepository(
      regions: [],
      dongs: [],
      limitReached: true,
    );
    await pumpApp(
      tester,
      location: AppRoutes.region('51820'),
      favorites: favorites,
      loggedIn: true,
    );

    await tester.tap(find.widgetWithText(FilledButton, '즐겨찾기'));
    await tester.pumpAndSettle();

    expect(find.text('최대 50개까지 저장할 수 있어요'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '즐겨찾기'), findsOneWidget);
  });
}
