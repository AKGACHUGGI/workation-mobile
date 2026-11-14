import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';

import 'helpers.dart';

void main() {
  testWidgets('앱이 홈 화면을 렌더링한다', (tester) async {
    await pumpApp(tester);
    expect(find.text('워케이션맵'), findsOneWidget);
    expect(find.text('인기 지역 3곳'), findsOneWidget);
    expect(find.byType(ListingCardMobile), findsWidgets);
  });

  testWidgets('테마에 디자인 토큰이 매핑되어 있다', (tester) async {
    await pumpApp(tester);
    final context = tester.element(find.byType(NavigationBar));
    final theme = Theme.of(context);

    expect(theme.colorScheme.primary, AppSemantic.brandPrimary);
    expect(theme.colorScheme.onSurface, AppSemantic.textPrimary);
    expect(theme.colorScheme.outlineVariant, AppSemantic.borderDefault);
    expect(theme.scaffoldBackgroundColor, AppSemantic.bgPage);

    final semantic = theme.extension<AppSemanticColors>();
    expect(semantic, isNotNull);
    expect(semantic!.gradeOf('S').fg, AppPalette.babu600);
    expect(semantic.heat.length, 7);
  });
}
