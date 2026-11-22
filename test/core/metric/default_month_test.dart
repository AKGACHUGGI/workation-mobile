import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/metric/default_month.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/metric/month.dart';
import 'package:workation_mobile/data/models/search_intent.dart';
import 'package:workation_mobile/features/community/community_providers.dart';
import 'package:workation_mobile/features/home/home_providers.dart';
import 'package:workation_mobile/features/map/map_providers.dart';
import 'package:workation_mobile/shared/widgets/listing_card_mobile.dart';

import '../../helpers.dart';

/// 기본 달은 고정 12월이 아니라 오늘 날짜의 달입니다.
void main() {
  ProviderContainer containerOn(DateTime today) {
    final container = ProviderContainer(
      overrides: [todayProvider.overrideWithValue(today)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('오늘의 달을 데이터 연도의 같은 달로 옮긴다', () {
    expect(Months.ofDate(DateTime(2026, 11, 22)), '2025-11');
    expect(Months.ofDate(DateTime(2027, 1, 1)), '2025-01');
    expect(Months.ofDate(DateTime(2025, 12, 31, 23, 59)), '2025-12');

    expect(
      containerOn(DateTime(2026, 11, 22)).read(defaultMonthProvider),
      '2025-11',
    );
    expect(
      containerOn(DateTime(2026, 3, 5)).read(defaultMonthProvider),
      '2025-03',
    );
  });

  test('홈 · 지도는 오늘의 달에서 시작한다', () {
    final container = containerOn(DateTime(2026, 11, 22));
    expect(container.read(homeFilterProvider).month, '2025-11');
    expect(container.read(mapMonthProvider), '2025-11');
    // 나머지 처음 값은 그대로
    expect(container.read(homeFilterProvider).preset, PresetKey.quiet);
    expect(container.read(homeFilterProvider).sort, PopularSort.favorites);
  });

  test('검색이 달을 읽어내면 그 달로 바뀌고, 조건을 지우면 오늘의 달로 돌아온다', () {
    final container = containerOn(DateTime(2026, 11, 22));
    final filter = container.read(homeFilterProvider.notifier);

    filter.applyIntent(const SearchIntent(month: '2025-07'));
    expect(container.read(homeFilterProvider).month, '2025-07');

    // 문장에 달이 없으면 보던 달을 둡니다.
    filter.applyIntent(const SearchIntent(preset: PresetKey.lively));
    expect(container.read(homeFilterProvider).month, '2025-07');
    expect(container.read(homeFilterProvider).preset, PresetKey.lively);

    filter.reset();
    expect(container.read(homeFilterProvider).month, '2025-11');
    expect(container.read(homeFilterProvider).preset, PresetKey.quiet);
  });

  test('지도에서 바꾼 달은 그대로 남는다', () {
    final container = containerOn(DateTime(2026, 11, 22));
    container.read(mapMonthProvider.notifier).set(Months.annual);
    expect(container.read(mapMonthProvider), Months.annual);
  });

  test('연간 화면의 투표 · 사진은 오늘과 상관없이 마지막 달(12월)에 붙는다', () {
    expect(pollMonthOf(Months.annual), '2025-12');
    expect(pollMonthOf('2025-11'), '2025-11');
  });

  testWidgets('11월에 켜면 홈 카드 · 지역 상세가 11월 기준이다', (tester) async {
    final regions = FakeRegionRepository();
    await pumpApp(tester, regions: regions, today: DateTime(2026, 11, 22));

    expect(find.textContaining('· 11월'), findsWidgets);
    expect(find.textContaining('· 12월'), findsNothing);

    await tester.tap(find.byType(ListingCardMobile).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('11월 · 조용한 곳 프리셋'), findsOneWidget);
  });

  testWidgets('11월에 켜면 지도 탭의 달도 11월이다', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.map,
      today: DateTime(2026, 11, 22),
    );
    expect(find.widgetWithText(InkWell, '11월'), findsWidgets);
    expect(find.text('12월'), findsNothing);
  });
}
