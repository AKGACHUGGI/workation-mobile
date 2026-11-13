import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/shared/widgets/app_chip.dart';
import 'package:workation_mobile/shared/widgets/app_photo.dart';
import 'package:workation_mobile/shared/widgets/category_tab.dart';
import 'package:workation_mobile/shared/widgets/dong_row.dart';
import 'package:workation_mobile/shared/widgets/fact_pill.dart';
import 'package:workation_mobile/shared/widgets/grade_badge.dart';
import 'package:workation_mobile/shared/widgets/icon_button_circle.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';
import 'package:workation_mobile/shared/widgets/mobile_sticky_bar.dart';
import 'package:workation_mobile/shared/widgets/photo_header.dart';
import 'package:workation_mobile/shared/widgets/score_display.dart';
import 'package:workation_mobile/shared/widgets/search_pill_mobile.dart';
import 'package:workation_mobile/shared/widgets/segmented_tabs.dart';
import 'package:workation_mobile/shared/widgets/tag.dart';
import 'package:workation_mobile/shared/widgets/type_bar.dart';

import '../../helpers.dart';

void main() {
  testWidgets('Tag 는 톤에 따라 글자색이 다르다', (tester) async {
    await pumpInTheme(
      tester,
      const Row(
        children: [
          Tag('해안'),
          Tag('생활권', tone: TagTone.brand),
        ],
      ),
    );

    expect(
      tester.widget<Text>(find.text('해안')).style!.color,
      AppSemantic.textSecondary,
    );
    expect(
      tester.widget<Text>(find.text('생활권')).style!.color,
      AppSemantic.textBrand,
    );
  });

  testWidgets('GradeBadge 는 등급 글자를 등급 색으로 그린다', (tester) async {
    await pumpInTheme(
      tester,
      const Row(children: [GradeBadge(Grade.s), GradeBadge(Grade.c)]),
    );

    expect(
      tester.widget<Text>(find.text('S')).style!.color,
      AppSemantic.gradeSFg,
    );
    expect(
      tester.widget<Text>(find.text('C')).style!.color,
      AppSemantic.gradeCFg,
    );
  });

  testWidgets('AppChip 은 누르면 onTap 을 부르고 선택되면 흰 글자다', (tester) async {
    var taps = 0;
    await pumpInTheme(
      tester,
      AppChipRow(
        children: [
          AppChip(label: '전체', onTap: () => taps++),
          const AppChip(label: '장기체류형', selected: true),
        ],
      ),
    );

    await tester.tap(find.text('전체'));
    expect(taps, 1);
    expect(
      tester.widget<Text>(find.text('장기체류형')).style!.color,
      AppSemantic.selectedFg,
    );
  });

  testWidgets('IconButtonCircle.save 는 저장 상태를 읽어 주고 누를 수 있다', (tester) async {
    var pressed = false;
    await pumpInTheme(
      tester,
      IconButtonCircle.save(saved: true, onPressed: () => pressed = true),
    );

    expect(find.bySemanticsLabel('즐겨찾기 해제'), findsOneWidget);
    expect(find.byIcon(LucideIcons.bookmark), findsNothing);
    await tester.tap(find.byType(IconButtonCircle));
    expect(pressed, isTrue);
  });

  testWidgets('ListingCardMobile 은 제목 · 점수 · 메타 · 배지 · 등급을 보여준다', (
    tester,
  ) async {
    var saved = 0;
    var opened = 0;
    await pumpInTheme(
      tester,
      SizedBox(
        width: 358,
        child: ListingCardMobile(
          title: '고성군, 강원특별자치도',
          score: 50.4,
          meta: '해안 · 속초시 인접',
          meta2: '즐겨찾기 1284 · 조회 8.2천 · 10월',
          badge: '즐겨찾기 1위',
          grades: const [('조용', Grade.a), ('또래', Grade.b)],
          onToggleSave: () => saved++,
          onTap: () => opened++,
        ),
      ),
    );

    expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text('즐겨찾기 1284 · 조회 8.2천 · 10월'), findsOneWidget);
    expect(find.text('즐겨찾기 1위'), findsOneWidget);
    expect(find.byType(GradeBadge), findsNWidgets(2));
    // 사진이 없으면 회색 상자 한 장, 위치 점은 없다
    expect(find.byType(CarouselDots), findsNothing);

    await tester.tap(find.byType(IconButtonCircle));
    await tester.tap(find.text('고성군, 강원특별자치도'));
    expect((saved, opened), (1, 1));
  });

  testWidgets('DongRow 는 이름 · 태그 · 설명 · 등급을 보여준다', (tester) async {
    var taps = 0;
    await pumpInTheme(
      tester,
      DongRow(
        name: '거진읍',
        kindLabel: '생활권',
        kindTone: TagTone.brand,
        caption: '거진항 · 8월 피크 · 10월 88%',
        metricLabel: '동네 조용함',
        grade: Grade.b,
        onTap: () => taps++,
      ),
    );

    for (final text in ['거진읍', '생활권', '거진항 · 8월 피크 · 10월 88%', '동네 조용함', 'B']) {
      expect(find.text(text), findsOneWidget);
    }
    await tester.tap(find.text('거진읍'));
    expect(taps, 1);
  });

  testWidgets('DongScoreRow 는 사실 필과 유형 점수를 보여준다', (tester) async {
    await pumpInTheme(
      tester,
      const DongScoreRow(
        name: '주문진읍',
        facts: [
          FactPill('장기체류형', kind: FactKind.type),
          FactPill('바닷가', kind: FactKind.coast),
        ],
        score: 61,
        scoreLabel: '장기체류형',
      ),
    );

    expect(find.text('주문진읍'), findsOneWidget);
    expect(find.byType(FactPill), findsNWidgets(2));
    expect(find.text('61'), findsOneWidget);
    expect(find.text('장기체류형'), findsNWidgets(2));
  });

  testWidgets('PhotoHeader 는 뒤로 · 공유 · 저장 버튼과 사진 수만큼 점을 그린다', (tester) async {
    final calls = <String>[];
    await pumpInTheme(
      tester,
      PhotoHeader(
        photos: const [null, null, null],
        onBack: () => calls.add('back'),
        onShare: () => calls.add('share'),
        onToggleSave: () => calls.add('save'),
      ),
    );

    expect(tester.widget<CarouselDots>(find.byType(CarouselDots)).count, 3);
    await tester.tap(find.bySemanticsLabel('뒤로'));
    await tester.tap(find.bySemanticsLabel('공유'));
    await tester.tap(find.bySemanticsLabel('즐겨찾기'));
    expect(calls, ['back', 'share', 'save']);

    await tester.drag(find.byType(PageView), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(tester.widget<CarouselDots>(find.byType(CarouselDots)).index, 1);
  });

  testWidgets('ScoreDisplay 는 점수를 정수로 크게 보여준다', (tester) async {
    await pumpInTheme(
      tester,
      const ScoreDisplay(
        score: 49.6,
        tagline: '조용한 곳 프리셋 · 12곳 중 3위 · S',
        sub: '10월 기준 · 조용 A · 시기 B',
      ),
    );

    expect(tester.widget<Text>(find.text('50')).style!.fontSize, 64);
    expect(find.text('조용한 곳 프리셋 · 12곳 중 3위 · S'), findsOneWidget);
    expect(find.text('10월 기준 · 조용 A · 시기 B'), findsOneWidget);
  });

  testWidgets('SegmentedTabs 는 누른 칸의 순서를 알려준다', (tester) async {
    int? changed;
    await pumpInTheme(
      tester,
      SegmentedTabs(
        labels: const ['시기', '동네', '정보'],
        index: 0,
        onChanged: (i) => changed = i,
      ),
    );

    await tester.tap(find.text('정보'));
    expect(changed, 2);
  });

  testWidgets('MobileStickyBar 는 점수 요약과 버튼을 보여준다', (tester) async {
    var pressed = false;
    await pumpInTheme(
      tester,
      MobileStickyBar(
        score: 50,
        scoreSuffix: '점 · 10월',
        sub: '조용한 곳 · 12곳 중 3위 · S',
        actionLabel: '즐겨찾기',
        onAction: () => pressed = true,
      ),
    );

    expect(find.text('50'), findsOneWidget);
    expect(find.text('점 · 10월'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, '즐겨찾기'));
    expect(pressed, isTrue);
  });

  testWidgets('TypeBar 는 점수만큼 막대를 채우고 1위만 브랜드 색이다', (tester) async {
    await pumpInTheme(
      tester,
      const SizedBox(
        width: 324,
        child: Column(
          children: [
            TypeBar(
              name: '장기체류형',
              score: 61,
              highlight: true,
              reason: '숙박 성향 64 · 한산한 달 7개',
            ),
            TypeBar(name: '몰입형', score: 36),
          ],
        ),
      ),
    );

    final fills = tester
        .widgetList<FractionallySizedBox>(find.byType(FractionallySizedBox))
        .map((b) => b.widthFactor);
    expect(fills, [0.61, 0.36]);
    expect(
      tester.widget<Text>(find.text('61')).style!.color,
      AppSemantic.textBrand,
    );
    expect(
      tester.widget<Text>(find.text('36')).style!.color,
      AppSemantic.textPrimary,
    );
    expect(find.text('숙박 성향 64 · 한산한 달 7개'), findsOneWidget);
  });

  testWidgets('SearchPillMobile 은 안내 문구를 보여주고 누를 수 있다', (tester) async {
    var taps = 0;
    await pumpInTheme(
      tester,
      Padding(
        padding: const EdgeInsets.all(16),
        child: SearchPillMobile(onTap: () => taps++),
      ),
    );

    expect(find.text('어떤 워케이션을 원하세요?'), findsOneWidget);
    await tester.tap(find.byType(SearchPillMobile));
    expect(taps, 1);
  });

  testWidgets('CategoryTab 은 선택되면 잉크색이다', (tester) async {
    await pumpInTheme(
      tester,
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CategoryTab(icon: LucideIcons.waves, label: '해안', active: true),
          CategoryTab(icon: LucideIcons.mountain, label: '산간'),
        ],
      ),
    );

    expect(
      tester.widget<Text>(find.text('해안')).style!.color,
      AppSemantic.textPrimary,
    );
    expect(
      tester.widget<Text>(find.text('산간')).style!.color,
      AppSemantic.textSecondary,
    );
  });
}
