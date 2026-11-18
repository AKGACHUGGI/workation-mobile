import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/features/dong/dong_screen.dart';
import 'package:workation_mobile/shared/widgets/app_chip.dart';
import 'package:workation_mobile/shared/widgets/area_label.dart';
import 'package:workation_mobile/shared/widgets/dong_pin.dart';
import 'package:workation_mobile/shared/widgets/dong_row.dart';
import 'package:workation_mobile/shared/widgets/fact_pill.dart';
import 'package:workation_mobile/shared/widgets/skeleton.dart';
import 'package:workation_mobile/shared/widgets/type_bar.dart';

import '../../fakes/explore.dart';
import '../../helpers.dart';

/// Figma 와 같은 폭 390 · 높이 844(하단 내비 포함).
Future<void> pumpMap(
  WidgetTester tester, {
  String? sgg,
  String? dong,
  FakeExploreRepository? explore,
  bool settle = true,
}) => pumpApp(
  tester,
  location: AppRoutes.mapAt(sgg: sgg, dong: dong),
  explore: explore,
  settle: settle,
  size: const Size(390, 844),
);

/// 가로 스크롤 칩 줄에서 화면 밖에 있는 칩도 보이게 한 뒤 누릅니다.
Future<void> tapChip(WidgetTester tester, String label) async {
  final chip = find.widgetWithText(AppChip, label);
  await tester.ensureVisible(chip);
  await tester.pumpAndSettle();
  await tester.tap(chip);
  await tester.pumpAndSettle();
}

String locationOf(WidgetTester tester) =>
    GoRouter.of(tester.element(find.byType(Scaffold).first))
        .routeInformationProvider
        .value
        .uri
        .toString();

void main() {
  group('경로', () {
    test('mapAt 은 단계에 맞는 쿼리를 만든다', () {
      expect(AppRoutes.mapAt(), '/map');
      expect(AppRoutes.mapAt(sgg: '51150'), '/map?sgg=51150');
      expect(
        AppRoutes.mapAt(sgg: '51150', dong: '5115025000'),
        '/map?sgg=51150&dong=5115025000',
      );
      // 시군구 없이 동만 오면 ⓪
      expect(AppRoutes.mapAt(dong: '5115025000'), '/map');
    });
  });

  group('⓪ 시군구', () {
    testWidgets('지표 칩 6종 · 월 · 범례 · 시군구 라벨 · 안내 시트', (tester) async {
      await pumpMap(tester);

      expect(find.text('지도'), findsWidgets); // 머리글 + 내비
      expect(find.text('12월'), findsOneWidget);
      for (final label in [
        '종합',
        '동네 조용함',
        '시기 여유',
        '또래 밀도',
        '숙박 성향',
        '저녁 활기',
      ]) {
        expect(find.widgetWithText(AppChip, label), findsOneWidget);
      }
      expect(find.text('낮음 0'), findsOneWidget);
      // 동해안 5곳 라벨(고성 · 속초 · 양양 · 강릉 · 동해)
      for (final name in ['고성군', '속초시', '양양군', '강릉시', '동해시']) {
        expect(find.widgetWithText(AreaLabel, name), findsOneWidget);
      }
      expect(find.text('동 21 · 카페 · 해수욕장'), findsOneWidget);
      // 집계 제외 동은 회색 점선 라벨
      expect(
        tester.widget<AreaLabel>(find.widgetWithText(AreaLabel, '수동면')).state,
        AreaLabelState.excluded,
      );
      expect(find.text('지도에서 시군구를 눌러 보세요'), findsOneWidget);
      expect(find.text('동네 보기'), findsNothing);
    });

    testWidgets('시군구 라벨을 누르면 요약 시트: 이름 · 종합 점수 · 등급 3개', (tester) async {
      await pumpMap(tester);

      await tester.tap(find.widgetWithText(AreaLabel, '고성군'));
      await tester.pumpAndSettle();

      expect(find.text('고성군, 강원특별자치도'), findsOneWidget);
      // (55*3 + 37*3 + 48 + 76) / 8 = 50
      expect(find.text('50'), findsOneWidget);
      expect(find.text('해안 · 행정동 5곳 · 12월'), findsOneWidget);
      expect(find.text('조용'), findsOneWidget);
      expect(find.text('또래'), findsOneWidget);
      expect(find.text('숙박'), findsOneWidget);
      expect(find.text('동네 보기'), findsOneWidget);
      expect(
        tester.widget<AreaLabel>(find.widgetWithText(AreaLabel, '고성군')).state,
        AreaLabelState.selected,
      );
    });

    testWidgets('지표 칩을 바꾸면 시트 점수가 그 지표로 바뀐다', (tester) async {
      await pumpMap(tester);
      await tester.tap(find.widgetWithText(AreaLabel, '고성군'));
      await tester.pumpAndSettle();
      expect(find.text('50'), findsOneWidget);

      await tapChip(tester, '동네 조용함');
      expect(find.text('55'), findsOneWidget);
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '동네 조용함')).selected,
        isTrue,
      );
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '종합')).selected,
        isFalse,
      );

      await tapChip(tester, '저녁 활기');
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('지도의 면을 눌러도 시군구가 골라진다', (tester) async {
      await pumpMap(tester);
      // 강릉시 라벨 위쪽, 같은 시군구의 색칠된 면을 누릅니다.
      final label = tester.getCenter(find.widgetWithText(AreaLabel, '강릉시'));
      await tester.tapAt(label + const Offset(0, -34));
      await tester.pumpAndSettle();
      expect(find.text('동네 보기'), findsOneWidget);
    });

    testWidgets('[동네 보기] → ①, 쿼리 sgg 가 붙는다', (tester) async {
      await pumpMap(tester);
      await tester.tap(find.widgetWithText(AreaLabel, '강릉시'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('동네 보기'));
      await tester.pumpAndSettle();

      expect(locationOf(tester), '/map?sgg=51150');
      expect(find.widgetWithText(AppChip, '장기체류형'), findsOneWidget);
      expect(find.text('강릉시'), findsOneWidget); // 머리글만
    });

    testWidgets('월 선택 시트에서 월을 바꾼다', (tester) async {
      await pumpMap(tester);
      await tester.tap(find.text('12월'));
      await tester.pumpAndSettle();
      expect(find.text('연간'), findsOneWidget);
      await tester.ensureVisible(find.text('10월'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('10월'));
      await tester.pumpAndSettle();
      expect(find.text('10월'), findsOneWidget);
      expect(find.text('12월'), findsNothing);
    });

    testWidgets('전국 12곳 ↔ 동해안 전환', (tester) async {
      await pumpMap(tester);
      await tester.tap(find.text('전국 12곳'));
      await tester.pumpAndSettle();
      expect(find.text('동해안'), findsOneWidget);
      // 전국에서는 남쪽 시군구 라벨이 보이고(겹치는 라벨은 접힘) 동해안 라벨은 일부만 남는다.
      expect(find.byType(AreaLabel), findsWidgets);
      expect(find.widgetWithText(AreaLabel, '제주시'), findsOneWidget);
      await tester.tap(find.text('동해안'));
      await tester.pumpAndSettle();
      expect(find.text('전국 12곳'), findsOneWidget);
      expect(find.widgetWithText(AreaLabel, '강릉시'), findsOneWidget);
    });
  });

  group('① 행정동 핀', () {
    testWidgets('머리글 · 핀 · 칩 8개 · 제목 줄 없는 목록', (tester) async {
      await pumpMap(tester, sgg: '51150');

      expect(find.text('강릉시'), findsOneWidget);
      expect(find.byType(DongPin), findsWidgets);
      for (final label in [
        '전체',
        '장기체류형',
        '로컬살이형',
        '네트워킹형',
        '몰입형',
        '바닷가',
        '생활권',
        '관광지',
      ]) {
        // 가로 스크롤 칩이라 화면 밖 칩도 위젯으로는 있습니다.
        expect(
          find.widgetWithText(AppChip, label, skipOffstage: false),
          findsOneWidget,
        );
      }
      // 제목 줄("행정동 21곳")은 없다
      expect(find.textContaining('행정동 21곳'), findsNothing);
      expect(find.textContaining('점수순'), findsNothing);
      // 전체 = 이름순
      final rows = tester.widgetList<DongScoreRow>(find.byType(DongScoreRow));
      final names = [for (final r in rows) r.name];
      expect(names.first, '강남동');
      final sorted = [...names]..sort();
      expect(names, sorted);
    });

    testWidgets('핀이 겹치면 "N곳 더" 로 묶고, 누르면 확대되어 핀이 늘어난다', (tester) async {
      await pumpMap(tester, sgg: '51150');

      final before = find.byType(DongPin).evaluate().length;
      expect(before, lessThan(21));
      final cluster = find.byType(PinClusterPill);
      expect(cluster, findsWidgets);
      final hidden = tester.widget<PinClusterPill>(cluster.first).count;
      expect(before + hidden, greaterThanOrEqualTo(21 - 3));

      await tester.tap(cluster.first);
      await tester.pumpAndSettle();
      expect(find.byType(DongPin).evaluate().length, greaterThan(before));
    });

    testWidgets('유형 칩: 하나만 고르고 그 유형 점수 내림차순, 행 점수도 그 유형', (tester) async {
      await pumpMap(tester, sgg: '51150');

      await tapChip(tester, '로컬살이형');
      var rows = tester
          .widgetList<DongScoreRow>(find.byType(DongScoreRow))
          .toList();
      expect(rows.first.scoreLabel, '로컬살이형');
      final scores = [for (final r in rows) r.score!];
      for (var i = 1; i < scores.length; i++) {
        expect(scores[i], lessThanOrEqualTo(scores[i - 1]));
      }
      expect(scores.first, greaterThanOrEqualTo(85)); // 내곡동 97 등

      // 다른 유형 칩을 누르면 바뀌고(하나만), 같은 칩을 다시 누르면 전체로.
      await tapChip(tester, '네트워킹형');
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '로컬살이형')).selected,
        isFalse,
      );
      rows = tester
          .widgetList<DongScoreRow>(find.byType(DongScoreRow))
          .toList();
      expect(rows.first.scoreLabel, '네트워킹형');
      await tapChip(tester, '네트워킹형');
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '전체')).selected,
        isTrue,
      );
    });

    testWidgets('속성 칩은 거르기: 바닷가만 · 바닷가 + 관광지는 둘 다', (tester) async {
      await pumpMap(tester, sgg: '51150');

      await tapChip(tester, '바닷가');
      var rows = tester.widgetList<DongScoreRow>(find.byType(DongScoreRow));
      expect(rows, isNotEmpty);
      for (final r in rows) {
        expect(
          r.facts.whereType<FactPill>().map((f) => f.label),
          contains('바닷가'),
        );
      }

      await tapChip(tester, '관광지');
      rows = tester.widgetList<DongScoreRow>(find.byType(DongScoreRow));
      for (final r in rows) {
        final labels = r.facts.whereType<FactPill>().map((f) => f.label);
        expect(labels, containsAll(['바닷가', '관광지']));
      }

      await tapChip(tester, '전체');
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '바닷가')).selected,
        isFalse,
      );
    });

    testWidgets('목록 행을 누르면 ② (쿼리에 dong)', (tester) async {
      await pumpMap(tester, sgg: '51150');
      await tester.tap(find.text('강남동').last);
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map?sgg=51150&dong=5115061500');
    });

    testWidgets('핀을 눌러도 ②', (tester) async {
      await pumpMap(tester, sgg: '51150');
      await tester.tap(find.widgetWithText(DongPin, '주문진읍'));
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map?sgg=51150&dong=5115025000');
    });

    testWidgets('mock 이 없는 시군구(404)는 빈 상태 문구', (tester) async {
      await pumpMap(tester, sgg: '51820');
      expect(find.text('고성군 동네 정보는 아직 준비 중이에요'), findsOneWidget);
      expect(find.byType(DongScoreRow), findsNothing);
      expect(find.byType(DongPin), findsNothing);
      expect(find.widgetWithText(AppChip, '전체'), findsNothing);
    });

    testWidgets('핀을 받는 동안 목록 스켈레톤, 끝나면 목록', (tester) async {
      final gate = Completer<void>();
      await pumpMap(
        tester,
        sgg: '51150',
        explore: FakeExploreRepository(pinsGate: gate),
        settle: false,
      );
      expect(find.byType(Skeleton), findsWidgets);
      expect(find.byType(DongScoreRow), findsNothing);
      expect(find.byType(DongPin), findsNothing);

      gate.complete();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(Skeleton), findsNothing);
      expect(find.byType(DongScoreRow), findsWidgets);
      expect(find.byType(DongPin), findsWidgets);
    });

    testWidgets('핀을 못 받으면 오류 문구 + [다시 시도]', (tester) async {
      final repo = FakeExploreRepository(failPins: true);
      await pumpMap(tester, sgg: '51150', explore: repo);
      expect(find.text('동네 목록을 불러오지 못했어요'), findsOneWidget);

      repo.failPins = false;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(find.byType(DongScoreRow), findsWidgets);
      expect(repo.pinCalls, hasLength(2));
    });

    testWidgets('뒤로 가기(머리글)는 ⓪ 으로', (tester) async {
      await pumpMap(tester, sgg: '51150');
      await tester.tap(
        find.byTooltip('뒤로가기').evaluate().isEmpty
            ? find.text('강릉시')
            : find.byTooltip('뒤로가기'),
      );
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map');
      expect(find.text('지도에서 시군구를 눌러 보세요'), findsOneWidget);
    });

    testWidgets('시스템 뒤로 가기는 한 단계씩 올라간다 (② → ① → ⓪)', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '5115025000');
      expect(find.text('이 동네 더보기'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map?sgg=51150');
      expect(find.widgetWithText(AppChip, '장기체류형'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map');
      expect(find.text('지도에서 시군구를 눌러 보세요'), findsOneWidget);
    });

    testWidgets('없는 시군구 딥링크는 ⓪ 으로 돌려보낸다', (tester) async {
      await pumpMap(tester, sgg: '99999');
      expect(locationOf(tester), '/map');
      expect(find.text('지도에서 시군구를 눌러 보세요'), findsOneWidget);
    });

    testWidgets('핀에 없는 동 딥링크는 ① 로 돌려보낸다', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '0000000000');
      expect(locationOf(tester), '/map?sgg=51150');
      expect(find.widgetWithText(AppChip, '전체'), findsOneWidget);
    });
  });

  group('② 동 선택', () {
    testWidgets('고른 핀 강조 · 나머지 흐림 · 요약 시트', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '5115025000');

      final pins = tester.widgetList<DongPin>(find.byType(DongPin)).toList();
      final selected = pins.where((p) => p.state == DongPinState.selected);
      expect(selected.map((p) => p.name), ['주문진읍']);
      expect(
        pins.where((p) => p.state == DongPinState.dimmed),
        hasLength(pins.length - 1),
      );

      expect(find.text('주문진읍'), findsNWidgets(2)); // 핀 + 시트 제목
      expect(find.text('바닷가 0.0km'), findsOneWidget);
      expect(find.text('강원특별자치도 · 강릉시'), findsOneWidget);
      final bar = tester.widget<TypeBar>(find.byType(TypeBar));
      expect(bar.name, '장기체류형');
      expect(bar.score, 61);
      expect(bar.highlight, isTrue);
      // 브리핑은 첫 줄만
      expect(
        find.text('평일 차량은 12시에 가장 많고, 업무시간엔 9시가 가장 한산해요.'),
        findsOneWidget,
      );
      expect(find.textContaining('강릉시는 2·4·9월'), findsNothing);
      expect(find.text('이 동네 더보기'), findsOneWidget);
      // 칩 · 목록은 ① 시트에만
      expect(find.byType(DongScoreRow), findsNothing);
    });

    testWidgets('[이 동네 더보기] → 동네 프로필', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '5115025000');
      await tester.tap(find.text('이 동네 더보기'));
      await tester.pumpAndSettle();
      expect(find.byType(DongScreen), findsOneWidget);
    });

    testWidgets('닫기(X)는 ① 로 — 칩 선택은 그대로', (tester) async {
      await pumpMap(tester, sgg: '51150');
      await tapChip(tester, '몰입형');
      await tester.tap(find.widgetWithText(DongPin, '주문진읍'));
      await tester.pumpAndSettle();
      expect(find.text('이 동네 더보기'), findsOneWidget);

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map?sgg=51150');
      expect(
        tester.widget<AppChip>(find.widgetWithText(AppChip, '몰입형')).selected,
        isTrue,
      );
    });

    testWidgets('불러오는 동안 스켈레톤, 끝나면 요약', (tester) async {
      final gate = Completer<void>();
      final repo = FakeExploreRepository(dongGate: gate);
      await pumpMap(
        tester,
        sgg: '51150',
        dong: '5115025000',
        explore: repo,
        settle: false,
      );

      expect(find.byType(Skeleton), findsWidgets);
      expect(find.text('이 동네 더보기'), findsNothing);
      expect(find.byType(TypeBar), findsNothing);

      gate.complete();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(TypeBar), findsOneWidget);
      expect(find.text('이 동네 더보기'), findsOneWidget);
      expect(find.byType(Skeleton), findsNothing);
    });

    testWidgets('요약이 없는 동(404)은 이름 + 안내, 더보기는 그대로', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '5115031000');
      expect(find.text('성산면'), findsNWidgets(2));
      expect(find.text('이 동네의 요약은 아직 준비 중이에요'), findsOneWidget);
      expect(find.byType(TypeBar), findsNothing);
      expect(find.text('이 동네 더보기'), findsOneWidget);
      expect(find.text('다시 시도'), findsNothing);
    });

    testWidgets('실패하면 오류 문구 + [다시 시도], 다시 받으면 요약', (tester) async {
      final repo = FakeExploreRepository(failDong: true);
      await pumpMap(tester, sgg: '51150', dong: '5115025000', explore: repo);
      expect(find.text('동네 정보를 불러오지 못했어요'), findsOneWidget);
      expect(find.byType(TypeBar), findsNothing);

      repo.failDong = false;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(find.byType(TypeBar), findsOneWidget);
      expect(find.text('동네 정보를 불러오지 못했어요'), findsNothing);
      expect(repo.dongCalls, hasLength(2));
    });

    testWidgets('다른 핀을 누르면 그 동으로 바뀐다', (tester) async {
      await pumpMap(tester, sgg: '51150', dong: '5115025000');
      await tester.tap(find.widgetWithText(DongPin, '연곡면'));
      await tester.pumpAndSettle();
      expect(locationOf(tester), '/map?sgg=51150&dong=5115037000');
    });
  });
}
