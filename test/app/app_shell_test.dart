import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/app.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: WorkationApp()));
    await tester.pumpAndSettle();
  }

  Finder tab(String label) => find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );

  testWidgets('하단 내비는 홈 · 지도 · 즐겨찾기 · MY 4탭이다', (tester) async {
    await pumpApp(tester);

    final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(bar.destinations, hasLength(4));
    for (final label in ['홈', '지도', '즐겨찾기', 'MY']) {
      expect(tab(label), findsOneWidget);
    }
    expect(bar.selectedIndex, 0);
  });

  testWidgets('탭을 누르면 해당 화면으로 바뀌고 홈으로 돌아올 수 있다', (tester) async {
    await pumpApp(tester);

    await tester.tap(tab('지도'));
    await tester.pumpAndSettle();
    expect(find.textContaining('M-02 지도'), findsOneWidget);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );

    await tester.tap(tab('즐겨찾기'));
    await tester.pumpAndSettle();
    expect(find.textContaining('M-05 즐겨찾기'), findsOneWidget);

    await tester.tap(tab('MY'));
    await tester.pumpAndSettle();
    expect(find.textContaining('M-07 MY'), findsOneWidget);

    await tester.tap(tab('홈'));
    await tester.pumpAndSettle();
    expect(find.text('워케이션맵'), findsOneWidget);
  });
}
