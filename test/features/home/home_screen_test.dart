import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';
import 'package:workation_mobile/features/home/home_screen.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';

import '../../helpers.dart';

void main() {
  Future<void> pumpHome(WidgetTester tester, RegionRepository repo) async {
    tester.view.physicalSize = const Size(390, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [regionRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  List<String> titles(WidgetTester tester) => [
    for (final c in tester.widgetList<ListingCardMobile>(
      find.byType(ListingCardMobile),
    ))
      c.title,
  ];

  testWidgets('인기 지역을 즐겨찾기순으로 보여준다', (tester) async {
    await pumpHome(tester, FakeRegionRepository());

    expect(find.text('인기 지역 3곳'), findsOneWidget);
    expect(titles(tester).take(2), ['고성군, 강원특별자치도', '양양군, 강원특별자치도']);
    expect(find.text('즐겨찾기 1위'), findsOneWidget);
    expect(find.text('즐겨찾기 1.2천 · 조회 8.2천 · 12월'), findsOneWidget);
  });

  testWidgets('지형 카테고리를 누르면 거르고, 다시 누르면 풀린다', (tester) async {
    await pumpHome(tester, FakeRegionRepository());

    await tester.tap(find.text('산간'));
    await tester.pumpAndSettle();
    expect(titles(tester), ['정읍시, 강원특별자치도']);

    await tester.tap(find.text('도시'));
    await tester.pumpAndSettle();
    expect(find.text('조건에 맞는 지역이 없어요'), findsOneWidget);

    await tester.tap(find.text('도시'));
    await tester.pumpAndSettle();
    expect(titles(tester), hasLength(3));
  });

  testWidgets('정렬 메뉴에서 기준을 바꾸면 배지 문구가 바뀐다', (tester) async {
    await pumpHome(tester, FakeRegionRepository());

    await tester.tap(find.text('즐겨찾기순'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('종합 점수순').last);
    await tester.pumpAndSettle();

    expect(find.text('종합 1위'), findsOneWidget);
  });

  testWidgets('불러오기에 실패하면 문구와 다시 시도를 보여준다', (tester) async {
    final repo = FakeRegionRepository(fail: true);
    await pumpHome(tester, repo);

    expect(find.text('인기 지역을 불러오지 못했습니다'), findsOneWidget);

    repo.fail = false;
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();
    expect(titles(tester), isNotEmpty);
  });
}
