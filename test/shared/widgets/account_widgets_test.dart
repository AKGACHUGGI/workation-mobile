import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';
import 'package:workation_mobile/shared/widgets/app_button.dart';
import 'package:workation_mobile/shared/widgets/app_toggle.dart';
import 'package:workation_mobile/shared/widgets/avatar.dart';
import 'package:workation_mobile/shared/widgets/social_login_button.dart';

import '../../helpers.dart';

void main() {
  group('Avatar', () {
    testWidgets('크기별 지름은 24 · 32 · 56 이고 첫 글자를 보여준다', (tester) async {
      for (final (size, dimension) in [
        (AvatarSize.sm, 24.0),
        (AvatarSize.md, 32.0),
        (AvatarSize.lg, 56.0),
      ]) {
        await pumpInTheme(tester, Avatar(initial: '두', size: size));
        expect(tester.getSize(find.byType(Avatar)), Size.square(dimension));
        expect(find.text('두'), findsOneWidget);
      }
    });
  });

  group('SocialLoginButton', () {
    testWidgets('제공자 이름 문구를 보이고 누르면 콜백을 부른다', (tester) async {
      final tapped = <AuthProviderKind>[];
      await pumpInTheme(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final kind in AuthProviderKind.values)
              SocialLoginButton(
                provider: kind,
                onPressed: () => tapped.add(kind),
              ),
          ],
        ),
      );

      expect(find.text('카카오로 시작하기'), findsOneWidget);
      expect(find.text('Google로 시작하기'), findsOneWidget);
      expect(tester.getSize(find.byType(SocialLoginButton).first).height, 52);

      await tester.tap(find.text('카카오로 시작하기'));
      await tester.tap(find.text('Google로 시작하기'));
      expect(tapped, AuthProviderKind.values);
    });

    testWidgets('로딩 중에는 눌러도 반응하지 않는다', (tester) async {
      var taps = 0;
      await pumpInTheme(
        tester,
        SocialLoginButton(
          provider: AuthProviderKind.kakao,
          loading: true,
          onPressed: () => taps++,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.text('카카오로 시작하기'));
      expect(taps, 0);
    });
  });

  group('AppButton', () {
    testWidgets('세 변형 모두 라벨을 보이고 누를 수 있다', (tester) async {
      var taps = 0;
      await pumpInTheme(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final v in AppButtonVariant.values)
              AppButton(v.name, variant: v, onPressed: () => taps++),
          ],
        ),
      );

      for (final v in AppButtonVariant.values) {
        await tester.tap(find.text(v.name));
      }
      expect(taps, 3);
      // 기본 높이 48
      expect(tester.getSize(find.byType(FilledButton)).height, 48);
    });

    testWidgets('height 40 · expand 는 가로를 채운다', (tester) async {
      await pumpInTheme(
        tester,
        const SizedBox(
          width: 300,
          child: AppButton(
            '넓은 버튼',
            variant: AppButtonVariant.secondary,
            height: 40,
            expand: true,
          ),
        ),
      );

      expect(tester.getSize(find.byType(OutlinedButton)), const Size(300, 40));
    });
  });

  group('AppToggle', () {
    testWidgets('44×24 이고 누르면 반대 값으로 onChanged 를 부른다', (tester) async {
      final values = <bool>[];
      await pumpInTheme(
        tester,
        AppToggle(value: false, semanticLabel: '알림', onChanged: values.add),
      );

      expect(tester.getSize(find.byType(AppToggle)), const Size(44, 24));
      await tester.tap(find.byType(AppToggle));
      expect(values, [true]);
    });

    testWidgets('스크린 리더에는 켜짐 상태가 전달된다', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpInTheme(
        tester,
        AppToggle(value: true, semanticLabel: '알림', onChanged: (_) {}),
      );

      expect(
        tester.getSemantics(find.byType(AppToggle)),
        matchesSemantics(
          label: '알림',
          hasToggledState: true,
          isToggled: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      handle.dispose();
    });
  });
}
