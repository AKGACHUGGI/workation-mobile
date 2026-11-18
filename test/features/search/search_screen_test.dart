import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/features/search/search_screen.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';
import 'package:workation_mobile/shared/widgets/tag.dart';

import '../../helpers.dart';

void main() {
  const cta = '이 조건으로 추천 받기';

  List<String> tags(WidgetTester tester) => [
    for (final t in tester.widgetList<Tag>(find.byType(Tag))) t.label,
  ];

  FilledButton ctaButton(WidgetTester tester) =>
      tester.widget(find.widgetWithText(FilledButton, cta));

  testWidgets('홈 검색 필을 누르면 입력 화면이 열리고, 비어 있으면 추천을 받을 수 없다', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('어떤 워케이션을 원하세요?'));
    await tester.pumpAndSettle();

    expect(find.text('AI 지역 추천'), findsOneWidget);
    expect(find.text('이렇게 물어보세요'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('AI가 이렇게 이해했어요'), findsNothing);
    expect(ctaButton(tester).onPressed, isNull);
  });

  testWidgets('문장을 적고 멈추면 조건을 미리 보여주고, 누른 조건은 빠진다', (tester) async {
    final search = FakeSearchRepository();
    await pumpApp(tester, location: AppRoutes.search, search: search);

    await tester.enterText(find.byType(TextField), '10월에 조용한');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.enterText(find.byType(TextField), '10월에 조용한 바닷가');
    await tester.pump(const Duration(milliseconds: 200));
    expect(search.calls, isEmpty, reason: '입력 중에는 요청하지 않는다');

    await tester.pump(SearchScreen.debounce);
    await tester.pump();
    expect(search.calls, ['10월에 조용한 바닷가']);
    expect(tags(tester), ['10월', '조용한 곳', '해안']);

    await tester.tap(find.text('해안'));
    await tester.pump();
    expect(tags(tester), ['10월', '조용한 곳']);
  });

  testWidgets('예시를 고르고 추천을 받으면 홈에 조건이 반영되고, 지우면 되돌아간다', (tester) async {
    final search = FakeSearchRepository();
    await pumpApp(tester, search: search);
    await tester.tap(find.text('어떤 워케이션을 원하세요?'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('단풍철 산간 마을에서 한 달 살기'));
    await tester.pumpAndSettle();
    expect(tags(tester), ['산간', '한 달 살기']);

    await tester.tap(find.text(cta));
    await tester.pumpAndSettle();

    expect(search.calls, hasLength(1), reason: '읽어 둔 조건을 다시 요청하지 않는다');
    expect(find.text('AI가 이해한 조건'), findsOneWidget);
    expect(find.text('단풍철 산간 마을에서 한 달 살기'), findsOneWidget);
    expect(find.text('AI 추천 · 산간 · 한 달 살기'), findsOneWidget);
    // 산간으로 걸러져 정읍시만 남습니다.
    expect(find.byType(ListingCardMobile), findsOneWidget);
    expect(find.text('정읍시, 강원특별자치도'), findsOneWidget);

    // 조건 수정: 적용한 문장에서 이어서 고칩니다.
    await tester.tap(find.text('조건 수정'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      '단풍철 산간 마을에서 한 달 살기',
    );
    await tester.tap(find.byTooltip('뒤로'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('조건 지우기'));
    await tester.pumpAndSettle();
    expect(find.text('AI가 이해한 조건'), findsNothing);
    expect(find.text('어떤 워케이션을 원하세요?'), findsOneWidget);
    expect(find.byType(ListingCardMobile), findsNWidgets(3));
  });

  testWidgets('멈추기 전에 추천 받기를 눌러도 조건을 읽은 뒤 적용한다', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('어떤 워케이션을 원하세요?'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '11월 조용한 곳');
    await tester.pump();
    await tester.tap(find.text(cta));
    await tester.pumpAndSettle();

    expect(find.text('AI 추천 · 11월 · 조용한 곳'), findsOneWidget);
    expect(find.textContaining('· 11월'), findsWidgets);
  });

  testWidgets('조건을 찾지 못하면 안내하고 화면에 머문다', (tester) async {
    await pumpApp(tester, location: AppRoutes.search);

    await tester.enterText(find.byType(TextField), '아무 데나');
    await tester.pump();
    await tester.tap(find.text(cta));
    await tester.pumpAndSettle();

    expect(find.textContaining('조건을 찾지 못했어요'), findsOneWidget);
    expect(find.text('AI 지역 추천'), findsOneWidget);
  });

  testWidgets('조건 읽기에 실패하면 다시 시도할 수 있다', (tester) async {
    final search = FakeSearchRepository(fail: true);
    await pumpApp(tester, location: AppRoutes.search, search: search);

    await tester.tap(find.text('또래가 많고 밤에도 활기찬 도시'));
    await tester.pumpAndSettle();
    expect(find.text('조건을 읽지 못했어요'), findsOneWidget);

    search.fail = false;
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();
    expect(tags(tester), ['활기 있는 한 달', '도시', '또래 20~40대']);
  });

  testWidgets('홈 카드를 누르면 지역 상세로 간다', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('고성군, 강원특별자치도'));
    await tester.pumpAndSettle();

    expect(find.text('월별 혼잡 지수'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('뒤로'));
    await tester.pumpAndSettle();
    expect(find.text('인기 지역 3곳'), findsOneWidget);
  });
}
