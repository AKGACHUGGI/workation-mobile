import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/data/models/community.dart'
    show CommunityTarget;
import 'package:workation_mobile/data/models/me.dart';
import 'package:workation_mobile/features/community/community_providers.dart';
import 'package:workation_mobile/features/my/my_screen.dart';
import 'package:workation_mobile/features/my/widgets/my_tip_tile.dart';

import '../../fakes/account.dart';
import '../../fakes/community.dart';
import '../../helpers.dart';

void main() {
  const third = MyTip(
    id: 'tip-3',
    author: TipAuthor(nickname: '두이', initial: '두'),
    createdAt: '2025-06-01T09:00:00+09:00',
    body: '양양은 서핑 강습이 오전에 몰려요.',
    helpful: 0,
    replies: 0,
    target: MyTipTarget(kind: TipTargetKind.region, id: '51830', name: '양양군'),
  );

  const firstBody = '거진항 근처 카페는 평일 오전이 제일 조용해요.';

  Future<void> openTips(
    WidgetTester tester,
    FakeMeRepository me, {
    FakeCommunityRepository? community,
  }) async {
    await pumpApp(
      tester,
      location: AppRoutes.my,
      loggedIn: true,
      me: me,
      community: community,
    );
    await tester.tap(find.widgetWithText(GestureDetector, '팁').first);
    await tester.pumpAndSettle();
  }

  /// 첫 번째 팁의 ⋯ 메뉴 → [삭제]
  Future<void> openDeleteDialog(WidgetTester tester) async {
    await tester.tap(find.byTooltip('팁 메뉴').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('삭제'));
    await tester.pumpAndSettle();
  }

  testWidgets('삭제: 확인하면 목록 · 개수 · 합계가 줄고 지역 팁 목록을 다시 읽는다', (tester) async {
    final me = FakeMeRepository();
    final community = FakeCommunityRepository();
    await openTips(tester, me, community: community);
    // 지운 팁의 지역(고성군 51820) 팁 목록이 열려 있었다고 칩니다.
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MyScreen)),
    );
    const target = CommunityTarget.region('51820');
    final sub = container.listen(tipsProvider(target), (_, _) {});
    addTearDown(sub.close);
    await tester.pumpAndSettle();
    final readsBefore = community.tipCursors.length;

    expect(find.text('내가 쓴 팁 2개'), findsOneWidget);
    expect(find.text('도움돼요 합계 17'), findsOneWidget);

    await openDeleteDialog(tester);
    expect(find.text('이 팁을 삭제할까요?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(me.deletedTips, ['tip-1']);
    expect(find.text(firstBody), findsNothing);
    expect(find.byType(MyTipTile), findsOneWidget);
    expect(find.text('내가 쓴 팁 1개'), findsOneWidget);
    expect(find.text('도움돼요 합계 5'), findsOneWidget);
    expect(find.text('팁을 삭제했어요'), findsOneWidget);
    expect(community.tipCursors.length, greaterThan(readsBefore));
  });

  testWidgets('삭제: 통계 카드의 팁 수도 줄어든다', (tester) async {
    final me = FakeMeRepository();
    await openTips(tester, me);
    await openDeleteDialog(tester);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    final numbers = [
      for (final t in tester.widgetList<Text>(find.byType(Text)))
        if (t.style?.fontSize == 24 && t.data != 'MY') t.data,
    ];
    expect(numbers, ['2', '1', '3']);
  });

  testWidgets('취소: 아무것도 지우지 않는다', (tester) async {
    final me = FakeMeRepository();
    await openTips(tester, me);
    await openDeleteDialog(tester);
    await tester.tap(find.widgetWithText(TextButton, '취소'));
    await tester.pumpAndSettle();

    expect(me.deletedTips, isEmpty);
    expect(find.text('이 팁을 삭제할까요?'), findsNothing);
    expect(find.byType(MyTipTile), findsNWidgets(2));
    expect(find.text('내가 쓴 팁 2개'), findsOneWidget);
  });

  testWidgets('실패: 안내하고 목록은 그대로 둔다', (tester) async {
    final me = FakeMeRepository(failDelete: true);
    await openTips(tester, me);
    await openDeleteDialog(tester);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.text('팁을 삭제하지 못했어요'), findsOneWidget);
    expect(find.byType(MyTipTile), findsNWidgets(2));
    expect(find.text(firstBody), findsOneWidget);
    expect(find.text('도움돼요 합계 17'), findsOneWidget);
  });

  testWidgets('다음 쪽이 남아 있으면 첫 쪽부터 다시 읽고, 이어서 더 볼 수 있다', (tester) async {
    final me = FakeMeRepository(moreTips: [third]);
    await openTips(tester, me);

    await openDeleteDialog(tester);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    // 서버 cursor 가 한 칸 밀리지 않도록 첫 쪽을 다시 읽습니다.
    expect(me.tipCursors, [null, null]);
    expect(find.text(firstBody), findsNothing);
    expect(find.byType(MyTipTile), findsOneWidget);
    expect(find.text('내가 쓴 팁 1개'), findsOneWidget);

    await tester.ensureVisible(find.text('팁 더 보기'));
    await tester.tap(find.text('팁 더 보기'));
    await tester.pumpAndSettle();
    expect(me.tipCursors, [null, null, '20']);
    expect(find.byType(MyTipTile), findsNWidgets(2));
  });

  testWidgets('다음 쪽까지 이어 붙인 뒤 지우면 그 자리에서 뺀다', (tester) async {
    final me = FakeMeRepository(moreTips: [third]);
    await openTips(tester, me);
    await tester.ensureVisible(find.text('팁 더 보기'));
    await tester.tap(find.text('팁 더 보기'));
    await tester.pumpAndSettle();
    expect(find.byType(MyTipTile), findsNWidgets(3));

    await openDeleteDialog(tester);
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(me.tipCursors, [null, '20']);
    expect(find.byType(MyTipTile), findsNWidgets(2));
    expect(find.text('내가 쓴 팁 2개'), findsOneWidget);
    expect(find.text('도움돼요 합계 5'), findsOneWidget);
  });

  testWidgets('줄을 누르면 지역으로 가는 동작은 그대로다', (tester) async {
    await openTips(tester, FakeMeRepository());
    await tester.tap(find.text(firstBody));
    await tester.pumpAndSettle();
    expect(find.byType(MyScreen), findsNothing);
  });
}
