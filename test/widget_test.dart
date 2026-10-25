import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/app.dart';

void main() {
  testWidgets('앱이 홈 화면을 렌더링한다', (tester) async {
    await tester.pumpWidget(const WorkationApp());
    expect(find.text('워케이션(가제)'), findsOneWidget);
  });
}
