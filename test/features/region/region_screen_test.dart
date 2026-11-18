import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/features/region/region_copy.dart';
import 'package:workation_mobile/shared/widgets/dong_row.dart';

import '../../helpers.dart';

void main() {
  List<String> dongNames(WidgetTester tester) => [
    for (final row in tester.widgetList<DongRow>(find.byType(DongRow)))
      row.name,
  ];

  testWidgets('시기 탭: 제목 · 점수 · 월별 막대 · 좋은 달과 피할 달을 보여준다', (tester) async {
    await pumpApp(tester, location: AppRoutes.region('51820'));

    expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
    expect(find.text('해안 · 속초시 인접 · 12월 · 조용한 곳 프리셋'), findsOneWidget);
    expect(find.text('하반기 상승형'), findsOneWidget);
    // 가짜 3곳은 점수가 같아 모두 1위입니다.
    expect(find.text('조용한 곳 프리셋 · 3곳 중 1위 · S'), findsOneWidget);
    expect(
      find.text('12월 기준 · 조용 A · 시기 B · 또래 B · 숙박 S · 활기 B'),
      findsOneWidget,
    );
    expect(find.text('월별 혼잡 지수'), findsOneWidget);
    expect(find.text('2 · 3월'), findsOneWidget);
    expect(find.text('혼잡 41 · 연중 가장 한산'), findsOneWidget);
    expect(find.text('7 · 8월'), findsOneWidget);
    expect(find.text('혼잡 80~100 · 성수기'), findsOneWidget);
    expect(find.text('12 · 2월'), findsOneWidget);
    expect(find.text('1.05×'), findsOneWidget);
    // 하단은 내비가 아니라 고정 바입니다.
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('점 · 12월'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '즐겨찾기'), findsOneWidget);
  });

  testWidgets('동네 탭: 조용함순으로 줄 세우고 생활권 · 관광지로 거른다', (tester) async {
    await pumpApp(tester, location: AppRoutes.region('51820'));

    await tester.tap(find.text('동네'));
    await tester.pumpAndSettle();

    expect(find.text('행정동 5곳'), findsOneWidget);
    expect(find.text('수동면 제외 · 12월 기준'), findsOneWidget);
    expect(dongNames(tester), ['토성면', '죽왕면', '거진읍', '간성읍', '현내면']);
    expect(find.text('거진항 · 8월 피크의 72%'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, '생활권').first);
    await tester.pumpAndSettle();
    expect(dongNames(tester), ['거진읍', '간성읍']);

    await tester.tap(find.text('동네 조용함순'));
    await tester.pumpAndSettle();
    expect(dongNames(tester), hasLength(5));
  });

  testWidgets('?tab=dongs 로 들어오면 동네 탭부터, 행정동을 누르면 동네 프로필로 간다', (tester) async {
    await pumpApp(tester, location: AppRoutes.region('51820', tab: 'dongs'));

    expect(find.text('행정동 5곳'), findsOneWidget);

    await tester.tap(find.text('토성면'));
    await tester.pumpAndSettle();
    expect(find.textContaining('M-04 동네 프로필'), findsOneWidget);
  });

  testWidgets('없는 지역은 안내 문구를, 연결 실패는 다시 시도를 보여준다', (tester) async {
    await pumpApp(tester, location: AppRoutes.region('99999'));
    expect(find.text('없는 지역이에요'), findsOneWidget);
    expect(find.text('다시 시도'), findsNothing);
  });

  testWidgets('연결에 실패하면 다시 시도로 불러온다', (tester) async {
    final repo = FakeRegionRepository(fail: true);
    await pumpApp(tester, location: AppRoutes.region('51820'), regions: repo);
    expect(find.text('지역 정보를 불러오지 못했습니다'), findsOneWidget);

    repo.fail = false;
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();
    expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
  });

  test('주말 차이 문장은 비율 구간마다 다르다', () {
    expect(weekendSentence(1.05), contains('5% 늘어나는 수준'));
    expect(weekendSentence(0.95), contains('5% 줄어드는 수준'));
    expect(weekendSentence(1.3), contains('30% 늘어납니다'));
    expect(weekendSentence(0.8), contains('20% 줄어듭니다'));
  });

  test('월 묶음 문구', () {
    expect(formatMonths([2, 3]), '2 · 3월');
    expect(formatMonths([]), '—');
  });
}
