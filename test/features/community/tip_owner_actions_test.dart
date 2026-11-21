import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/features/my/my_providers.dart';
import 'package:workation_mobile/shared/widgets/tip_card.dart';

import '../../fakes/account.dart';
import '../../fakes/community.dart';
import '../../fakes/dong.dart';
import '../../helpers.dart';

/// 지역 · 동네 화면의 팁 카드에서 내 팁을 고치고 지웁니다(M-03c · M-04).
void main() {
  const myBody = '거진항 근처 카페는 평일 오전이 한산해요.';

  /// 주문진읍 동네 화면을 로그인한 채로 엽니다. 첫 팁(t1)이 내 팁입니다.
  Future<void> open(
    WidgetTester tester,
    FakeCommunityRepository community, {
    FakeMeRepository? me,
  }) async {
    await pumpApp(
      tester,
      location: AppRoutes.dong(jumunjinId),
      loggedIn: true,
      community: community,
      me: me,
    );
    await tester.ensureVisible(find.byType(TipCard).first);
    await tester.pumpAndSettle();
  }

  FakeCommunityRepository repo({List<Tip>? moreTips}) =>
      FakeCommunityRepository(mineTipIds: {'t1'}, moreTips: moreTips);

  Future<void> openMenu(WidgetTester tester, String item) async {
    await tester.tap(find.byTooltip('내 팁 메뉴'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(item));
    await tester.pumpAndSettle();
  }

  FilledButton saveButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, '저장'));

  testWidgets('내 팁에는 신고 대신 ⋯ 메뉴가 있고, 남의 팁에는 신고가 있다', (tester) async {
    await open(tester, repo());

    final cards = find.byType(TipCard);
    expect(cards, findsNWidgets(2));
    Finder inCard(int i, Finder f) =>
        find.descendant(of: cards.at(i), matching: f);
    expect(inCard(0, find.byTooltip('내 팁 메뉴')), findsOneWidget);
    expect(inCard(0, find.text('신고')), findsNothing);
    expect(inCard(1, find.byTooltip('내 팁 메뉴')), findsNothing);
    expect(inCard(1, find.text('신고')), findsOneWidget);

    await tester.tap(find.byTooltip('내 팁 메뉴'));
    await tester.pumpAndSettle();
    expect(find.text('수정'), findsOneWidget);
    expect(find.text('삭제'), findsOneWidget);
  });

  testWidgets('비로그인이면 내 팁이 없어 메뉴가 보이지 않는다', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.dong(jumunjinId),
      community: FakeCommunityRepository(),
    );
    expect(find.byType(TipCard), findsNWidgets(2));
    expect(find.byTooltip('내 팁 메뉴'), findsNothing);
    expect(find.text('신고'), findsNWidgets(2));
  });

  testWidgets('수정: 본문을 채운 시트가 열리고, 바꿔서 저장하면 그 카드만 바뀐다', (tester) async {
    final community = repo();
    final me = FakeMeRepository();
    await open(tester, community, me: me);
    final readsBefore = community.tipCursors.length;

    await openMenu(tester, '수정');
    expect(find.text('팁 수정'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      myBody,
    );
    // 고칠 때는 방문 월을 고르지 않습니다(서버가 본문만 고칩니다).
    expect(find.text('방문 월'), findsNothing);
    // 그대로면 저장할 수 없습니다.
    expect(saveButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '   ');
    await tester.pump();
    expect(saveButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '  오후엔 붐벼요  ');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();

    expect(community.editedTips, [('t1', '오후엔 붐벼요')]);
    expect(find.text('팁 수정'), findsNothing);
    expect(find.text('팁을 고쳤어요'), findsOneWidget);
    final cards = tester.widgetList<TipCard>(find.byType(TipCard)).toList();
    expect(cards.first.tip.body, '오후엔 붐벼요');
    expect(cards.first.tip.mine, isTrue);
    // 도움돼요 · 방문 월 같은 나머지는 그대로이고, 목록을 다시 읽지 않습니다.
    expect(cards.first.tip.helpful, 12);
    expect(cards.first.tip.visitMonth, '2025-10');
    expect(community.tipCursors, hasLength(readsBefore));
    expect(find.text('팁 2개 · 도움순'), findsOneWidget);
  });

  testWidgets('수정 실패: 시트 안에서 알리고 쓴 내용 · 카드는 그대로다', (tester) async {
    final community = repo()..failOwnerActions = true;
    await open(tester, community);

    await openMenu(tester, '수정');
    await tester.enterText(find.byType(TextField), '고친 본문');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();

    expect(find.text('팁을 고치지 못했어요'), findsOneWidget);
    expect(find.text('팁 수정'), findsOneWidget);
    expect(find.text('고친 본문'), findsOneWidget);
    expect(
      tester.widgetList<TipCard>(find.byType(TipCard)).first.tip.body,
      myBody,
    );

    community.failOwnerActions = false;
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();
    expect(find.text('팁 수정'), findsNothing);
    expect(community.editedTips, [('t1', '고친 본문')]);
  });

  testWidgets('삭제: 확인하면 목록 · 개수에서 빠지고 MY 요약을 다시 읽는다', (tester) async {
    final community = repo();
    final me = FakeMeRepository();
    await open(tester, community, me: me);
    // MY 요약 · 내 팁 목록이 읽혀 있었다고 칩니다.
    final container = ProviderScope.containerOf(
      tester.element(find.byType(TipCard).first),
    );
    final subs = [
      container.listen(meSummaryProvider, (_, _) {}),
      container.listen(myTipsProvider, (_, _) {}),
    ];
    addTearDown(() {
      for (final sub in subs) {
        sub.close();
      }
    });
    await tester.pumpAndSettle();
    final summaryBefore = me.summaryReads;
    final myTipsBefore = me.tipCursors.length;

    await openMenu(tester, '삭제');
    expect(find.text('이 팁을 삭제할까요?'), findsOneWidget);
    expect(find.textContaining('붙인 사진과 답글도 함께'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(community.deletedTips, ['t1']);
    expect(find.text('팁을 삭제했어요'), findsOneWidget);
    expect(find.byType(TipCard), findsOneWidget);
    expect(find.text(myBody), findsNothing);
    expect(find.text('팁 1개 · 도움순'), findsOneWidget);
    expect(me.summaryReads, summaryBefore + 1);
    expect(me.tipCursors, hasLength(myTipsBefore + 1));
  });

  testWidgets('삭제를 취소하면 아무것도 지우지 않는다', (tester) async {
    final community = repo();
    await open(tester, community);

    await openMenu(tester, '삭제');
    await tester.tap(find.widgetWithText(TextButton, '취소'));
    await tester.pumpAndSettle();

    expect(community.deletedTips, isEmpty);
    expect(find.byType(TipCard), findsNWidgets(2));
  });

  testWidgets('삭제 실패: 안내하고 목록은 그대로 둔다', (tester) async {
    final community = repo()..failOwnerActions = true;
    await open(tester, community);

    await openMenu(tester, '삭제');
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.text('팁을 삭제하지 못했어요'), findsOneWidget);
    expect(find.byType(TipCard), findsNWidgets(2));
    expect(find.text('팁 2개 · 도움순'), findsOneWidget);
  });

  testWidgets('다음 쪽이 남아 있을 때 지우면 첫 쪽부터 다시 읽는다', (tester) async {
    final community = repo(
      moreTips: const [
        Tip(
          id: 't3',
          author: TipAuthor(nickname: '느린오후', initial: '느'),
          createdAt: '2026-09-01T09:00:00+09:00',
          body: '다음 쪽 팁',
        ),
      ],
    );
    await open(tester, community);
    expect(find.text('팁 3개 · 도움순'), findsOneWidget);
    expect(find.text('팁 더 보기'), findsOneWidget);
    final readsBefore = community.tipCursors.length;

    await openMenu(tester, '삭제');
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    // 커서 없이(첫 쪽) 한 번 더 읽습니다.
    expect(community.tipCursors.sublist(readsBefore), [null]);
    expect(find.byType(TipCard), findsOneWidget);
    expect(find.text('팁 2개 · 도움순'), findsOneWidget);
    expect(find.text('팁 더 보기'), findsOneWidget);
  });
}
