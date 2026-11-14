import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/shared/widgets/mobile_sticky_bar.dart';
import 'package:workation_mobile/shared/widgets/segmented_tabs.dart';
import 'package:workation_mobile/shared/widgets/tip_card.dart';
import 'package:workation_mobile/shared/widgets/type_bar.dart';

import '../../fakes/community.dart';
import '../../fakes/dong.dart';
import '../../helpers.dart';

void main() {
  Future<void> open(
    WidgetTester tester, {
    String id = jumunjinId,
    FakeDongRepository? dongs,
    FakeExploreRepository? explore,
    FakeCommunityRepository? community,
  }) => pumpApp(
    tester,
    location: AppRoutes.dong(id),
    dongs: dongs,
    explore: explore,
    community: community,
  );

  /// 로그인 화면에서 카카오로 로그인합니다.
  Future<void> signIn(WidgetTester tester) async {
    expect(find.text('카카오로 시작하기'), findsOneWidget);
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();
  }

  testWidgets('주문진읍: 제목 · 유형 카드 · 곡선 · 지표 4종 · 팁 · 투표 · 위치 · 고정 바', (
    tester,
  ) async {
    await open(tester);

    expect(find.text('주문진읍, 강릉시'), findsOneWidget);
    expect(find.textContaining('강원특별자치도 강릉시 · 주말에 사람이 몰리고'), findsOneWidget);
    expect(find.text('생활권'), findsOneWidget);
    expect(find.text('해안'), findsOneWidget);
    expect(find.text('주말 관광형'), findsOneWidget);

    // 유형 카드: 4종, 1위만 강조, 근거의 괄호 설명은 뗀다
    expect(find.text('워케이션 유형'), findsOneWidget);
    final bars = tester.widgetList<TypeBar>(find.byType(TypeBar)).toList();
    expect(bars.map((b) => b.name), ['장기체류형', '로컬살이형', '네트워킹형', '몰입형']);
    expect([for (final b in bars) b.highlight], [true, false, false, false]);
    expect(find.text('숙박 성향 64 · 한산한 달 7개'), findsOneWidget);

    // 곡선: 기본은 주중
    expect(find.text('24시간 붐빔 곡선'), findsOneWidget);
    expect(find.text('주중 피크'), findsOneWidget);
    expect(find.text('11시 · 100'), findsOneWidget);
    expect(find.text('3시 · 48'), findsOneWidget);

    // 지표 카드 4개
    expect(find.text('동네 조용함'), findsOneWidget);
    expect(find.text('낮 유입 지수 0.79 · 백분위 31'), findsOneWidget);
    expect(find.text('저녁 유동 ÷ 체류 0.18'), findsOneWidget);
    expect(find.text('20~40대 방문 39%'), findsOneWidget);
    expect(find.text('거주+근무 74% · 생활권'), findsOneWidget);

    // 팁 · 투표
    expect(find.text('워케이션 노트 · 주문진읍'), findsOneWidget);
    expect(find.text('팁 2개 · 도움순'), findsOneWidget);
    expect(find.byType(TipCard), findsNWidgets(2));
    expect(find.text('주문진읍 저녁, 정말 활기찬가요?'), findsOneWidget);
    expect(find.text('4명 참여 · 저녁 활기 지수 검증에 반영돼요'), findsOneWidget);

    // 위치
    expect(find.text('강릉시 북부 · 바닷가 0.0km'), findsOneWidget);
    expect(find.text('강릉시 다른 동네'), findsOneWidget);

    // 고정 바(하단 내비 없음)
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('점 · 12월'), findsOneWidget);
    expect(find.text('동네 조용함 B · 행정동 203곳 백분위 31'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '동네 즐겨찾기'), findsOneWidget);
    expect(find.byType(MobileStickyBar), findsOneWidget);
  });

  testWidgets('주말로 바꾸면 주말 피크를, 월을 바꾸면 그 달로 다시 불러온다', (tester) async {
    final repo = FakeDongRepository();
    await open(tester, dongs: repo);

    await tester.tap(
      find.descendant(
        of: find.byType(SegmentedTabs),
        matching: find.text('주말'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('주말 피크'), findsOneWidget);
    expect(find.text('13시 · 100'), findsOneWidget);
    expect(find.text('3시 · 47'), findsOneWidget);

    await tester.tap(find.text('12월'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('10월').last);
    await tester.pumpAndSettle();
    expect(repo.months.last, '2025-10');
    expect(find.text('점 · 10월'), findsOneWidget);
  });

  testWidgets('유형 카드 요청이 실패해도 유형 카드만 숨기고 나머지는 보여준다', (tester) async {
    await open(tester, explore: FakeExploreRepository(fail: true));

    expect(find.text('워케이션 유형'), findsNothing);
    expect(find.byType(TypeBar), findsNothing);
    expect(find.text('24시간 붐빔 곡선'), findsOneWidget);
    expect(find.text('주문진읍, 강릉시'), findsOneWidget);
  });

  testWidgets('없는 동네는 안내를, 연결 실패는 다시 시도를 보여준다', (tester) async {
    await open(tester, id: '9999999999');
    expect(find.text('없는 동네예요'), findsOneWidget);
    expect(find.text('다시 시도'), findsNothing);
  });

  testWidgets('연결에 실패하면 다시 시도로 불러온다', (tester) async {
    final repo = FakeDongRepository(fail: true);
    await open(tester, dongs: repo);
    expect(find.text('동네 정보를 불러오지 못했습니다'), findsOneWidget);

    repo.fail = false;
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();
    expect(find.text('주문진읍, 강릉시'), findsOneWidget);
  });

  testWidgets('시군구 다른 동네를 누르면 그 지역의 동네 탭으로 간다', (tester) async {
    await open(tester);

    await tester.ensureVisible(find.text('강릉시 다른 동네'));
    await tester.tap(find.text('강릉시 다른 동네'));
    await tester.pumpAndSettle();
    // 가짜 지역 저장소에는 강릉시가 없어 없는 지역 안내가 보입니다(지역 화면까지 갔다는 뜻).
    expect(find.text('없는 지역이에요'), findsOneWidget);
  });

  testWidgets('비로그인이면 팁 입력 바가 로그인 화면으로 보내고 둘러보기로 닫으면 시트가 안 열린다', (
    tester,
  ) async {
    await open(tester);

    expect(find.textContaining('로그인하면 팁을 남기고'), findsOneWidget);
    await tester.ensureVisible(find.textContaining('로그인하면 팁을 남기고'));
    await tester.tap(find.textContaining('로그인하면 팁을 남기고'));
    await tester.pumpAndSettle();
    expect(find.text('카카오로 시작하기'), findsOneWidget);

    await tester.tap(find.text('둘러보기'));
    await tester.pumpAndSettle();
    expect(find.text('한 줄 팁 남기기'), findsNothing);
    expect(find.byType(TipCard), findsNWidgets(2));
  });

  testWidgets('로그인하고 팁을 등록하면 맨 위에 내 닉네임으로 보인다', (tester) async {
    final community = FakeCommunityRepository();
    await open(tester, community: community);

    await tester.ensureVisible(find.textContaining('로그인하면 팁을 남기고'));
    await tester.tap(find.textContaining('로그인하면 팁을 남기고'));
    await tester.pumpAndSettle();
    await signIn(tester);

    expect(find.text('한 줄 팁 남기기'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '  새벽 산책이 좋아요  ');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();

    expect(community.posted, ['새벽 산책이 좋아요']);
    expect(find.text('팁 3개 · 도움순'), findsOneWidget);
    final cards = tester.widgetList<TipCard>(find.byType(TipCard)).toList();
    expect(cards.first.tip.body, '새벽 산책이 좋아요');
    expect(cards.first.tip.author.nickname, '두이');
    expect(cards.first.tip.visitMonth, '2025-12');
  });

  testWidgets('투표는 로그인 뒤에 되고 다시 눌러 바꿀 수 있다', (tester) async {
    final community = FakeCommunityRepository();
    await open(tester, community: community);

    await tester.ensureVisible(find.text('그래요 75%'));
    await tester.tap(find.text('그래요 75%'));
    await tester.pumpAndSettle();
    await signIn(tester);

    expect(community.votes, [PollChoice.yes]);
    expect(find.text('그래요 80%'), findsOneWidget);
    expect(find.text('5명 참여 · 저녁 활기 지수 검증에 반영돼요'), findsOneWidget);

    // 로그인한 뒤에는 바로 바뀐다
    await tester.tap(find.text('아니요 20%'));
    await tester.pumpAndSettle();
    expect(community.votes, [PollChoice.yes, PollChoice.no]);
    expect(find.text('그래요 60%'), findsOneWidget);
    expect(find.text('아니요 40%'), findsOneWidget);
    expect(find.text('5명 참여 · 저녁 활기 지수 검증에 반영돼요'), findsOneWidget);
  });

  testWidgets('저장은 로그인 뒤에 안내만 보인다', (tester) async {
    await open(tester);

    await tester.tap(find.widgetWithText(FilledButton, '동네 즐겨찾기'));
    await tester.pumpAndSettle();
    await signIn(tester);

    expect(find.text('즐겨찾기 기능은 준비 중이에요'), findsOneWidget);
  });
}
