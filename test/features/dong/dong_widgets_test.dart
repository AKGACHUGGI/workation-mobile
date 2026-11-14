import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/data/models/dong_detail.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/features/dong/dong_copy.dart';
import 'package:workation_mobile/features/dong/widgets/hourly_curve_card.dart';
import 'package:workation_mobile/features/dong/widgets/location_card.dart';
import 'package:workation_mobile/features/dong/widgets/month_day_row.dart';
import 'package:workation_mobile/features/dong/widgets/workation_types_card.dart';

import '../../fakes/dong.dart';
import '../../helpers.dart';

void main() {
  testWidgets('HourlyCurveCard 는 고른 쪽의 피크 · 한산 시각을 보여준다', (tester) async {
    final d = fakeJumunjin();
    Widget card({required bool weekend}) => SizedBox(
      width: 358,
      child: HourlyCurveCard(
        hourly: d.hourly,
        peaks: d.peaks,
        weekend: weekend,
      ),
    );

    await pumpInTheme(tester, card(weekend: false));
    expect(find.text('24시간 붐빔 곡선'), findsOneWidget);
    expect(find.text('보행인구 · 최대 시간대 = 100'), findsOneWidget);
    for (final h in ['0시', '6시', '12시', '18시', '23시']) {
      expect(find.text(h), findsOneWidget);
    }
    expect(find.text('주중 피크'), findsOneWidget);
    expect(find.text('11시 · 100'), findsOneWidget);
    expect(find.text('3시 · 48'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('주중 피크 11시, 가장 한산 3시 48')),
      findsOneWidget,
    );

    await pumpInTheme(tester, card(weekend: true));
    expect(find.text('주말 피크'), findsOneWidget);
    expect(find.text('13시 · 100'), findsOneWidget);
    expect(find.text('3시 · 47'), findsOneWidget);
  });

  testWidgets('WorkationTypesCard 는 1위만 강조하고 근거의 괄호 설명을 뗀다', (tester) async {
    await pumpInTheme(
      tester,
      const SizedBox(
        width: 358,
        child: WorkationTypesCard(
          types: [
            TypeScore(
              name: '장기체류형',
              score: 61,
              reason: '숙박 성향 64 · 한산한 달 7개(성수기보다 20% 이상 적은 달)',
            ),
            TypeScore(name: '몰입형', score: 36),
          ],
        ),
      ),
    );

    expect(find.text('유형별 적합도 · 0~100'), findsOneWidget);
    expect(find.text('숙박 성향 64 · 한산한 달 7개'), findsOneWidget);
    expect(find.text('61'), findsOneWidget);
    expect(find.text('36'), findsOneWidget);
    expect(WorkationTypesCard.shortReason('생활권 지수 0.74'), '생활권 지수 0.74');
  });

  testWidgets('MonthDayRow 는 월 시트에서 고르고 주중 · 주말을 바꾼다', (tester) async {
    String? month;
    bool? weekend;
    await pumpInTheme(
      tester,
      SizedBox(
        width: 358,
        child: MonthDayRow(
          month: '2025-10',
          weekend: false,
          onMonthChanged: (m) => month = m,
          onWeekendChanged: (w) => weekend = w,
        ),
      ),
    );

    await tester.tap(find.text('주말'));
    expect(weekend, isTrue);

    await tester.tap(find.text('10월'));
    await tester.pumpAndSettle();
    expect(find.text('연간'), findsOneWidget);
    await tester.tap(find.text('3월'));
    await tester.pumpAndSettle();
    expect(month, '2025-03');
  });

  testWidgets('LocationCard 는 자리 박스에 동 이름을 두고 링크를 누르면 알린다', (tester) async {
    var taps = 0;
    await pumpInTheme(
      tester,
      SizedBox(
        width: 358,
        child: LocationCard(
          dongName: '주문진읍',
          accessNote: '강릉시 북부 · 바닷가 0.0km',
          sigunguName: '강릉시',
          onOtherDongs: () => taps++,
        ),
      ),
    );

    expect(find.text('주문진읍'), findsOneWidget);
    expect(find.text('강릉시 북부 · 바닷가 0.0km'), findsOneWidget);
    await tester.tap(find.text('강릉시 다른 동네'));
    expect(taps, 1);
  });

  group('dong_copy', () {
    test('요약 문장은 동네 성격 · 저녁 활기에 따라 달라진다', () {
      String s(ActivityKey k, Grade g) => buildDongSummary(
        dominant: k,
        weekdayPeakHour: 11,
        vibeGrade: g,
        kind: DongKind.living,
      );
      expect(
        s(ActivityKey.weekendTourist, Grade.a),
        '주말에 사람이 몰리고 평일 낮 11시가 피크인 생활권 동네, 저녁까지 활기가 이어집니다',
      );
      expect(s(ActivityKey.weekendTourist, Grade.c), endsWith('저녁엔 일찍 조용해집니다'));
      expect(s(ActivityKey.eveningDowntown, Grade.a), contains('저녁 11시'));
      expect(s(ActivityKey.weekdayWork, Grade.a), contains('업무형'));
      expect(s(ActivityKey.dawnResidential, Grade.a), contains('주거형'));
    });

    test('가장 큰 비중이 동네 성격이고 동점이면 앞쪽이다', () {
      expect(
        dominantActivity({'weekendTourist': 32, 'weekdayWork': 24}),
        ActivityKey.weekendTourist,
      );
      expect(dominantActivity({}), ActivityKey.eveningDowntown);
    });

    test('생활권 지수는 고정 경계로 등급 · 라벨을 낸다', () {
      expect(localLifeGrade(74), Grade.a);
      expect(localLifeGrade(70), Grade.a);
      expect(localLifeGrade(66), Grade.b);
      expect(localLifeGrade(49), Grade.c);
      expect(localLifeLabel(74), '생활권');
      expect(localLifeLabel(60), '혼합');
      expect(localLifeLabel(10), '방문지');
    });

    test('투표 질문은 저녁 활기 등급으로 갈린다', () {
      expect(dongPollQuestion('거진읍', Grade.s), '거진읍 저녁, 정말 활기찬가요?');
      expect(dongPollQuestion('거진읍', Grade.b), '거진읍 저녁, 정말 조용한가요?');
    });
  });
}
