import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/shared/widgets/area_label.dart';
import 'package:workation_mobile/shared/widgets/dong_pin.dart';
import 'package:workation_mobile/shared/widgets/heat_legend.dart';
import 'package:workation_mobile/shared/widgets/skeleton.dart';

import '../../helpers.dart';

void main() {
  group('AreaLabel', () {
    testWidgets('이름과 요약을 보여 주고 누르면 콜백', (tester) async {
      var taps = 0;
      await pumpInTheme(
        tester,
        AreaLabel(
          name: '강릉시',
          summary: '동 21 · 카페 · 해수욕장',
          onTap: () => taps++,
        ),
      );
      expect(find.text('강릉시'), findsOneWidget);
      expect(find.text('동 21 · 카페 · 해수욕장'), findsOneWidget);
      await tester.tap(find.text('강릉시'));
      expect(taps, 1);
    });

    Color? fillOf(WidgetTester tester) {
      final box = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(AreaLabel),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      return (box.decoration as BoxDecoration).color;
    }

    testWidgets('선택은 잉크 바탕, 기본은 흰 바탕', (tester) async {
      await pumpInTheme(
        tester,
        const AreaLabel(name: '강릉시', state: AreaLabelState.selected),
      );
      expect(fillOf(tester), AppTheme.light.colorScheme.secondary);
      await pumpInTheme(tester, const AreaLabel(name: '속초시'));
      expect(fillOf(tester), AppTheme.light.colorScheme.surface);
    });

    testWidgets('집계 제외는 회색 바탕 + 점선, 요약 없이도 그려진다', (tester) async {
      await pumpInTheme(
        tester,
        const AreaLabel(
          name: '수동면',
          summary: '집계 제외',
          state: AreaLabelState.excluded,
        ),
      );
      expect(find.text('집계 제외'), findsOneWidget);
      expect(
        fillOf(tester),
        AppTheme.light.extension<AppSemanticColors>()!.bgSurfaceStrong,
      );
      await pumpInTheme(tester, const AreaLabel(name: '동해시'));
      expect(find.text('동해시'), findsOneWidget);
    });
  });

  group('DongPin', () {
    testWidgets('이름 + 아이콘, 누르면 콜백', (tester) async {
      var taps = 0;
      await pumpInTheme(
        tester,
        DongPin(name: '주문진읍', tag: 'cafe', onTap: () => taps++),
      );
      expect(find.text('주문진읍'), findsOneWidget);
      expect(find.byIcon(kPinTagIcon['cafe']!), findsOneWidget);
      await tester.tap(find.text('주문진읍'));
      expect(taps, 1);
    });

    testWidgets('태그가 없거나 모르면 아이콘 없이 이름만', (tester) async {
      await pumpInTheme(tester, const DongPin(name: '홍제동'));
      expect(find.byType(Icon), findsNothing);
      await pumpInTheme(tester, const DongPin(name: '홍제동', tag: 'food'));
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('묶음별 바탕색: 일 = 브랜드, 쉼 = 초록', (tester) async {
      Color? circle() {
        final c = tester.widget<Container>(
          find
              .ancestor(of: find.byType(Icon), matching: find.byType(Container))
              .first,
        );
        return (c.decoration as BoxDecoration).color;
      }

      final theme = AppTheme.light;
      await pumpInTheme(tester, const DongPin(name: 'a', tag: 'cafe'));
      expect(circle(), theme.colorScheme.primary);
      await pumpInTheme(tester, const DongPin(name: 'a', tag: 'beach'));
      expect(circle(), theme.extension<AppSemanticColors>()!.signalGood);
    });

    testWidgets('선택은 브랜드 알약 + 흰 글자, 흐림은 투명도 0.6', (tester) async {
      await pumpInTheme(
        tester,
        const DongPin(name: '주문진읍', state: DongPinState.selected),
      );
      final text = tester.widget<Text>(find.text('주문진읍'));
      expect(text.style!.color, AppTheme.light.colorScheme.onPrimary);
      expect(find.byType(Opacity), findsNothing);

      await pumpInTheme(
        tester,
        const DongPin(name: '연곡면', state: DongPinState.dimmed),
      );
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.6);
    });

    testWidgets('모든 태그에 아이콘과 묶음이 있다', (tester) async {
      expect(kPinTagIcon.keys.toSet(), kPinTagGroup.keys.toSet());
    });

    testWidgets('묶음 필: "N곳 더", 누르면 콜백', (tester) async {
      var taps = 0;
      await pumpInTheme(tester, PinClusterPill(count: 11, onTap: () => taps++));
      await tester.tap(find.text('11곳 더'));
      expect(taps, 1);
    });
  });

  testWidgets('HeatLegend: 7칸 + 낮음 0 · 점수 · 100 높음', (tester) async {
    await pumpInTheme(tester, const HeatLegend());
    expect(find.text('낮음 0'), findsOneWidget);
    expect(find.text('점수'), findsOneWidget);
    expect(find.text('100 높음'), findsOneWidget);
    final heat = AppTheme.light.extension<AppSemanticColors>()!.heat;
    for (final c in heat) {
      expect(
        find.byWidgetPredicate((w) => w is ColoredBox && w.color == c),
        findsOneWidget,
      );
    }
  });

  group('Skeleton', () {
    testWidgets('주어진 크기로 그려진다', (tester) async {
      await pumpInTheme(
        tester,
        const Skeleton(width: 140, height: 28, radius: 8),
      );
      expect(tester.getSize(find.byType(Skeleton)), const Size(140, 28));
    });

    testWidgets('시스템에서 애니메이션을 끄면 멈춘다', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: Scaffold(body: Skeleton(width: 40)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Skeleton), findsOneWidget);
    });
  });
}
