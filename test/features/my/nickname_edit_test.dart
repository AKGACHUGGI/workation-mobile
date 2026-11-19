import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/auth_user.dart';
import 'package:workation_mobile/features/my/widgets/nickname_edit_sheet.dart';
import 'package:workation_mobile/shared/widgets/avatar.dart';

import '../../fakes/auth.dart';
import '../../helpers.dart';

/// 닉네임 저장만 실패하는 가짜.
class _FailingUpdateAuth extends FakeAuthRepository {
  @override
  Future<AuthUser> updateMe({String? nickname, String? agreedAt}) async {
    calls.add('PATCH /api/me $nickname ${agreedAt != null}');
    throw const NetworkException('/api/me');
  }
}

void main() {
  Future<void> openSheet(WidgetTester tester, FakeAuthRepository auth) async {
    await pumpApp(tester, location: AppRoutes.my, loggedIn: true, auth: auth);
    await tester.tap(find.widgetWithText(OutlinedButton, '편집'));
    await tester.pumpAndSettle();
  }

  Finder field() => find.descendant(
    of: find.byType(NicknameEditSheet),
    matching: find.byType(TextField),
  );

  FilledButton saveButton(WidgetTester tester) => tester.widget<FilledButton>(
    find.descendant(
      of: find.byType(NicknameEditSheet),
      matching: find.widgetWithText(FilledButton, '저장'),
    ),
  );

  testWidgets('편집을 누르면 지금 닉네임을 채운 시트가 열리고 저장은 꺼져 있다', (tester) async {
    await openSheet(tester, FakeAuthRepository(me: fakeMe));

    expect(find.byType(NicknameEditSheet), findsOneWidget);
    expect(tester.widget<TextField>(field()).controller!.text, '두이');
    expect(saveButton(tester).onPressed, isNull);
  });

  testWidgets('길이 검증: 1자 · 13자 · 공백뿐이면 저장 비활성, 앞뒤 공백은 다듬는다', (tester) async {
    await openSheet(tester, FakeAuthRepository(me: fakeMe));

    await tester.enterText(field(), '가');
    await tester.pump();
    expect(saveButton(tester).onPressed, isNull);
    expect(find.text('닉네임은 2~12자로 입력해 주세요'), findsOneWidget);

    await tester.enterText(field(), ' 가 ');
    await tester.pump();
    expect(saveButton(tester).onPressed, isNull);

    // 13자는 maxLength 가 12자로 잘라 냅니다.
    await tester.enterText(field(), '가나다라마바사아자차카타파');
    await tester.pump();
    expect(tester.widget<TextField>(field()).controller!.text.runes.length, 12);
    expect(saveButton(tester).onPressed, isNotNull);

    await tester.enterText(field(), '두이');
    await tester.pump();
    expect(saveButton(tester).onPressed, isNull);

    await tester.enterText(field(), '  새이름  ');
    await tester.pump();
    expect(saveButton(tester).onPressed, isNotNull);
  });

  testWidgets('저장 성공: 서버에 다듬은 닉네임을 보내고 시트가 닫히며 프로필 카드 · 이니셜이 바뀐다', (
    tester,
  ) async {
    final auth = FakeAuthRepository(me: fakeMe);
    await openSheet(tester, auth);

    await tester.enterText(field(), '  새이름 ');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();

    expect(auth.calls, contains('PATCH /api/me 새이름 false'));
    expect(find.byType(NicknameEditSheet), findsNothing);
    expect(find.text('새이름'), findsOneWidget);
    expect(find.text('두이'), findsNothing);
    final avatar = tester.widget<Avatar>(find.byType(Avatar).first);
    expect(avatar.initial, '새');
  });

  testWidgets('저장 실패: 안내를 띄우고 시트와 입력은 그대로, 닉네임은 안 바뀐다', (tester) async {
    final auth = _FailingUpdateAuth();
    await openSheet(tester, auth);

    await tester.enterText(field(), '새이름');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();

    expect(auth.calls, contains('PATCH /api/me 새이름 false'));
    expect(find.text('닉네임을 바꾸지 못했어요'), findsOneWidget);
    expect(find.byType(NicknameEditSheet), findsOneWidget);
    expect(tester.widget<TextField>(field()).controller!.text, '새이름');
    expect(saveButton(tester).onPressed, isNotNull);
    expect(find.text('두이'), findsOneWidget);
  });
}
