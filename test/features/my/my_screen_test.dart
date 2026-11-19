import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/data/models/me.dart';
import 'package:workation_mobile/features/my/my_screen.dart';
import 'package:workation_mobile/features/my/widgets/my_photo_tile.dart';
import 'package:workation_mobile/features/my/widgets/my_tip_tile.dart';
import 'package:workation_mobile/shared/widgets/app_toggle.dart';
import 'package:workation_mobile/shared/widgets/social_login_button.dart';

import '../../fakes/account.dart';
import '../../helpers.dart';

void main() {
  testWidgets('비로그인: 안내와 로그인 버튼, 로그인하면 프로필이 나온다', (tester) async {
    await pumpApp(tester, location: AppRoutes.my);

    expect(find.text('로그인이 필요해요'), findsOneWidget);
    expect(find.text('연결된 계정'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, '로그인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SocialLoginButton).first);
    await tester.pumpAndSettle();

    expect(find.text('로그인이 필요해요'), findsNothing);
    expect(find.byType(MyScreen), findsOneWidget);
    expect(find.text('두이'), findsOneWidget);
    expect(find.text('카카오 연결됨'), findsOneWidget);
    expect(find.text('강릉 2회 · 고성 1회 체류 · 2025.03 가입'), findsOneWidget);
  });

  testWidgets('활동 통계: 즐겨찾기 · 팁 · 사진 수', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);

    // 즐겨찾기 = 저장한 지역 1 + 동네 1, 팁 2, 사진 3. 통계 숫자만 24px 입니다.
    final numbers = [
      for (final t in tester.widgetList<Text>(find.byType(Text)))
        if (t.style?.fontSize == 24 && t.data != 'MY') t.data,
    ];
    expect(numbers, ['2', '2', '3']);
    expect(find.text('즐겨찾기'), findsWidgets);
  });

  testWidgets('사진 탭(기본): 사진 3장 · 검수 상태 · 올리기 칸', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);

    expect(find.text('내가 올린 사진 3장'), findsOneWidget);
    expect(find.text('검수 완료 2 · 대기 1'), findsOneWidget);
    expect(find.byType(MyPhotoTile), findsNWidgets(3));
    expect(find.text('10월 · 고성군'), findsOneWidget);
    expect(find.text('7월 · 강릉시'), findsOneWidget);
    expect(find.text('검수 대기'), findsOneWidget);
    expect(find.text('이달의 사진 올리기'), findsOneWidget);

    await tester.ensureVisible(find.text('이달의 사진 올리기'));
    await tester.tap(find.text('이달의 사진 올리기'));
    await tester.pump();
    expect(find.text('사진 올리기는 준비 중이에요'), findsOneWidget);
  });

  testWidgets('팁 탭: 내가 쓴 팁과 도움돼요 합계', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);

    await tester.tap(find.widgetWithText(GestureDetector, '팁').first);
    await tester.pumpAndSettle();

    expect(find.text('내가 쓴 팁 2개'), findsOneWidget);
    expect(find.text('도움돼요 합계 17'), findsOneWidget);
    expect(find.byType(MyTipTile), findsNWidgets(2));
    expect(find.text('거진항 근처 카페는 평일 오전이 제일 조용해요.'), findsOneWidget);
    expect(find.text('도움돼요 12 · 답글 2 · 2025.10.20'), findsOneWidget);
    expect(find.text('거진읍 · 2주 체류 · 10월 방문'), findsOneWidget);
  });

  group('팁 탭 다음 쪽', () {
    const third = MyTip(
      id: 'tip-3',
      author: TipAuthor(nickname: '두이', initial: '두'),
      createdAt: '2025-06-01T09:00:00+09:00',
      body: '양양은 서핑 강습이 오전에 몰려요.',
      helpful: 0,
      replies: 0,
      target: MyTipTarget(kind: TipTargetKind.region, id: '51830', name: '양양군'),
    );

    Future<void> openTips(WidgetTester tester, FakeMeRepository me) async {
      await pumpApp(tester, location: AppRoutes.my, loggedIn: true, me: me);
      await tester.tap(find.widgetWithText(GestureDetector, '팁').first);
      await tester.pumpAndSettle();
    }

    testWidgets('다음 쪽이 없으면 [팁 더 보기] 가 없다', (tester) async {
      final me = FakeMeRepository();
      await openTips(tester, me);

      expect(find.text('팁 더 보기'), findsNothing);
      expect(me.tipCursors, [null]);
    });

    testWidgets('[팁 더 보기] 를 누르면 nextCursor 로 다음 쪽을 이어 붙인다', (tester) async {
      final me = FakeMeRepository(moreTips: [third]);
      await openTips(tester, me);

      expect(find.byType(MyTipTile), findsNWidgets(2));
      // 다 읽기 전에는 요약의 팁 수를 씁니다.
      expect(find.text('내가 쓴 팁 2개'), findsOneWidget);

      await tester.ensureVisible(find.text('팁 더 보기'));
      await tester.tap(find.text('팁 더 보기'));
      await tester.pumpAndSettle();

      expect(me.tipCursors, [null, '20']);
      expect(find.byType(MyTipTile), findsNWidgets(3));
      expect(find.text('양양은 서핑 강습이 오전에 몰려요.'), findsOneWidget);
      expect(find.text('내가 쓴 팁 3개'), findsOneWidget);
      // 합계는 첫 쪽 값 그대로
      expect(find.text('도움돼요 합계 17'), findsOneWidget);
      expect(find.text('팁 더 보기'), findsNothing);
    });

    testWidgets('다음 쪽을 읽지 못하면 안내하고 목록은 그대로 둔다', (tester) async {
      final me = FakeMeRepository(moreTips: [third], failMoreTips: true);
      await openTips(tester, me);

      await tester.ensureVisible(find.text('팁 더 보기'));
      await tester.tap(find.text('팁 더 보기'));
      await tester.pumpAndSettle();

      expect(find.text('더 불러오지 못했어요'), findsOneWidget);
      expect(find.byType(MyTipTile), findsNWidgets(2));

      // 다시 누르면 같은 커서로 다시 읽습니다.
      me.failMoreTips = false;
      await tester.tap(find.text('팁 더 보기'));
      await tester.pumpAndSettle();
      expect(me.tipCursors, [null, '20', '20']);
      expect(find.byType(MyTipTile), findsNWidgets(3));
    });
  });

  testWidgets('즐겨찾기 탭: 저장한 이름들과 즐겨찾기로 가는 버튼', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);

    // 세그먼트 탭의 첫 칸(통계 카드의 '즐겨찾기' 글자와 구분하려고 SegmentedTabs 안에서 찾는다)
    await tester.tap(find.widgetWithText(GestureDetector, '즐겨찾기').first);
    await tester.pumpAndSettle();

    expect(find.text('저장한 지역 1 · 동네 1'), findsOneWidget);
    expect(find.text('고성군'), findsOneWidget);
    expect(find.text('거진읍'), findsOneWidget);

    await tester.tap(find.text('즐겨찾기에서 보기'));
    await tester.pumpAndSettle();
    expect(find.text('두이님 · 웹·앱 동기화됨 · 지역 1 · 동네 1'), findsOneWidget);
  });

  testWidgets('연결된 계정 줄은 로그인한 제공자를 보여준다', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);
    await tester.ensureVisible(find.text('연결된 계정'));

    expect(find.text('연결된 계정'), findsOneWidget);
    expect(find.text('카카오'), findsOneWidget);
    // 푸시알림을 넣지 않기로 해 알림 설정은 없습니다.
    expect(find.text('알림 설정'), findsNothing);
    expect(find.byType(AppToggle), findsNothing);
  });

  testWidgets('로그아웃은 확인을 거치고, 취소하면 그대로다', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);
    await tester.ensureVisible(find.text('로그아웃'));

    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();
    expect(find.text('로그아웃할까요?'), findsOneWidget);
    await tester.tap(find.text('취소'));
    await tester.pumpAndSettle();

    expect(find.text('로그아웃할까요?'), findsNothing);
    expect(find.text('두이'), findsOneWidget);
  });

  testWidgets('로그아웃을 확인하면 비로그인 안내로 돌아가고 즐겨찾기도 비워진다', (tester) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true);
    await tester.ensureVisible(find.text('로그아웃'));

    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, '로그아웃'));
    await tester.pumpAndSettle();

    expect(find.text('로그인이 필요해요'), findsOneWidget);
    expect(find.text('두이'), findsNothing);
    expect(find.text('로그아웃했습니다'), findsOneWidget);

    // 즐겨찾기 탭도 비로그인 안내
    await tester.tap(find.text('즐겨찾기'));
    await tester.pumpAndSettle();
    expect(find.text('로그인하고 저장해 보세요'), findsOneWidget);
  });
}
