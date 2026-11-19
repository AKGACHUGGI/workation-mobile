import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';

import '../../fakes/dong.dart';
import '../../fakes/share.dart';
import '../../helpers.dart';

void main() {
  testWidgets('지역 상세 공유 버튼: 글과 웹 링크, 누른 버튼 위치를 넘긴다', (tester) async {
    final share = FakeShareService();
    await pumpApp(
      tester,
      location: AppRoutes.region('51820'),
      share: share,
      webBaseUrl: 'https://w.example.com',
    );

    await tester.tap(find.bySemanticsLabel('공유'));
    await tester.pump();

    expect(share.texts, [
      '고성군 · 12월 워케이션 밸류 50점 (조용한 곳 3곳 중 1위)\n'
          'https://w.example.com/regions/51820?month=2025-12',
    ]);
    expect(share.origins.single, tester.getRect(find.bySemanticsLabel('공유')));
  });

  testWidgets('지역 상세: 웹 주소가 없으면 글만 보낸다', (tester) async {
    final share = FakeShareService();
    await pumpApp(tester, location: AppRoutes.region('51820'), share: share);

    await tester.tap(find.bySemanticsLabel('공유'));
    await tester.pump();

    expect(share.texts.single, isNot(contains('http')));
    expect(share.texts.single, startsWith('고성군 · 12월 워케이션 밸류'));
  });

  testWidgets('동네 프로필 공유 버튼: 화면의 달 · 조용함 점수와 웹 링크', (tester) async {
    final share = FakeShareService();
    await pumpApp(
      tester,
      location: AppRoutes.dong(jumunjinId),
      share: share,
      webBaseUrl: 'https://w.example.com',
    );

    await tester.tap(find.bySemanticsLabel('공유'));
    await tester.pump();

    expect(share.texts, [
      '주문진읍, 강릉시 · 12월 조용함 31점\n'
          'https://w.example.com/dongs/$jumunjinId?month=2025-12',
    ]);
    expect(share.origins.single, isNotNull);
  });
}
