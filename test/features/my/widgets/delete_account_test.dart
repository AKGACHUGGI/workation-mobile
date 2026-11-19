import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';

import '../../../fakes/auth.dart';
import '../../../helpers.dart';

void main() {
  Future<void> openDialog(WidgetTester tester, FakeAuthRepository auth) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true, auth: auth);
    await tester.ensureVisible(find.text('계정 삭제'));
    await tester.tap(find.text('계정 삭제'));
    await tester.pumpAndSettle();
  }

  testWidgets('계정 삭제 확인: 되돌릴 수 없다고 알리고, 삭제하면 비로그인으로 돌아간다', (tester) async {
    final auth = FakeAuthRepository();
    await openDialog(tester, auth);

    expect(find.text('계정을 삭제할까요?'), findsOneWidget);
    expect(find.textContaining('되돌릴 수 없습니다'), findsOneWidget);
    expect(find.textContaining('즐겨찾기·팁·사진'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(auth.calls, contains('DELETE /api/me'));
    expect(find.text('로그인이 필요해요'), findsOneWidget);
    expect(find.text('두이'), findsNothing);
    expect(find.text('계정을 삭제했습니다'), findsOneWidget);
  });

  testWidgets('취소하면 아무것도 지우지 않는다', (tester) async {
    final auth = FakeAuthRepository();
    await openDialog(tester, auth);

    await tester.tap(find.widgetWithText(TextButton, '취소'));
    await tester.pumpAndSettle();

    expect(find.text('계정을 삭제할까요?'), findsNothing);
    expect(find.text('두이'), findsOneWidget);
    expect(auth.calls, isNot(contains('DELETE /api/me')));
  });

  testWidgets('삭제에 실패하면 안내를 보이고 로그인 상태를 유지하며 다시 시도할 수 있다', (tester) async {
    final auth = FakeAuthRepository()..failDelete = true;
    await openDialog(tester, auth);

    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.text('계정을 삭제하지 못했어요 · 잠시 후 다시 시도해 주세요'), findsOneWidget);
    expect(find.text('계정을 삭제할까요?'), findsOneWidget);

    auth.failDelete = false;
    await tester.tap(find.widgetWithText(TextButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.text('로그인이 필요해요'), findsOneWidget);
    expect(find.text('계정을 삭제했습니다'), findsOneWidget);
  });
}
