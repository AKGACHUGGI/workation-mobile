import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/community_repository.dart';
import 'package:workation_mobile/features/region/region_providers.dart';
import 'package:workation_mobile/features/region/region_reason.dart';
import 'package:workation_mobile/features/region/widgets/info_tab.dart';
import 'package:workation_mobile/shared/widgets/metric_card.dart';
import 'package:workation_mobile/shared/widgets/tip_card.dart';
import 'package:workation_mobile/shared/widgets/user_photo_tile.dart';

import '../../fakes/community.dart';
import '../../helpers.dart';

void main() {
  Future<void> open(
    WidgetTester tester, {
    FakeCommunityRepository? community,
  }) => pumpApp(
    tester,
    location: AppRoutes.region('51820', tab: 'info'),
    community: community ?? FakeCommunityRepository(withPhotos: true),
  );

  testWidgets('정보 탭: 지표 카드 5개 · 추천 사유 · 팁 · 투표 · 사진', (tester) async {
    await open(tester);

    expect(find.text('핵심 지표 5종'), findsOneWidget);
    expect(find.text('12월 · 시군구 3곳 백분위'), findsOneWidget);
    expect(find.byType(MetricCard), findsNWidgets(5));
    for (final label in ['시기 여유', '동네 조용함', '또래 밀도', '숙박 성향', '저녁 활기']) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    expect(find.text('12월 혼잡 68 · 최대 대비 68%'), findsOneWidget);
    expect(find.text('낮 유입 지수 0.76 · 6위'), findsOneWidget);
    expect(find.text('20~40대 방문 41%'), findsOneWidget);
    expect(find.text('숙박 계수 0.98'), findsOneWidget);

    expect(find.text('추천 사유'), findsOneWidget);
    expect(find.textContaining('12월 조용한 곳 프리셋 종합'), findsOneWidget);

    expect(find.text('워케이션 노트'), findsOneWidget);
    expect(find.text('팁 2개 · 도움순'), findsOneWidget);
    expect(find.byType(TipCard), findsNWidgets(2));
    expect(find.text('12월 고성군, 실제로 조용했나요?'), findsOneWidget);
    expect(find.text('그래요 75%'), findsOneWidget);
    expect(find.text('이달의 사진'), findsOneWidget);
    expect(find.text('12월 · 사용자 제공 · 검수 후 게시'), findsOneWidget);
    expect(find.byType(UserPhotoTile), findsOneWidget);
    expect(find.text('이달의 사진 올리기'), findsOneWidget);
    // 가짜 응답에는 외부 링크가 없어 카드를 그리지 않습니다.
    expect(find.text('지원사업'), findsNothing);
  });

  testWidgets('비로그인이면 팁 · 투표 · 사진 올리기가 모두 로그인 화면으로 간다', (tester) async {
    final community = FakeCommunityRepository(withPhotos: true);
    await open(tester, community: community);

    Future<void> expectGate(Finder target) async {
      await tester.ensureVisible(target);
      await tester.tap(target);
      await tester.pumpAndSettle();
      expect(find.text('카카오로 시작하기'), findsOneWidget);
      await tester.tap(find.text('로그인 없이 둘러보기'));
      await tester.pumpAndSettle();
    }

    await expectGate(find.textContaining('로그인하면 팁을 남기고'));
    await expectGate(find.text('그래요 75%'));
    await expectGate(find.text('이달의 사진 올리기'));

    expect(community.posted, isEmpty);
    expect(community.votes, isEmpty);
    expect(find.text('사진 올리기 기능은 준비 중이에요'), findsNothing);
  });

  testWidgets('로그인하면 팁 등록 · 투표가 되고 사진 올리기는 준비 중 안내가 뜬다', (tester) async {
    final community = FakeCommunityRepository(withPhotos: true);
    await open(tester, community: community);

    // 사진 올리기: 로그인 → 준비 중
    await tester.ensureVisible(find.text('이달의 사진 올리기'));
    await tester.tap(find.text('이달의 사진 올리기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();
    expect(find.text('사진 올리기 기능은 준비 중이에요'), findsOneWidget);

    // 이제 로그인 상태: 팁
    await tester.ensureVisible(find.text('이 지역에서 알게 된 팁을 남겨보세요'));
    await tester.tap(find.text('이 지역에서 알게 된 팁을 남겨보세요'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '숙소는 평일이 싸요');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(community.posted, ['숙소는 평일이 싸요']);
    expect(find.text('팁 3개 · 도움순'), findsOneWidget);
    expect(find.text('숙소는 평일이 싸요'), findsOneWidget);

    // 투표
    await tester.ensureVisible(find.text('그래요 75%'));
    await tester.tap(find.text('그래요 75%'));
    await tester.pumpAndSettle();
    expect(community.votes, [PollChoice.yes]);
    expect(find.text('그래요 80%'), findsOneWidget);
  });

  testWidgets('팁이 없으면 안내 문구, 불러오기에 실패하면 다시 시도', (tester) async {
    final community = FakeCommunityRepository(withPhotos: true)..fail = true;
    await open(tester, community: community);

    expect(find.text('팁을 불러오지 못했어요'), findsOneWidget);
    expect(find.text('투표를 불러오지 못했어요'), findsOneWidget);

    community.fail = false;
    await tester.tap(find.text('다시 시도').first);
    await tester.pumpAndSettle();
    expect(find.byType(TipCard), findsNWidgets(2));
  });

  testWidgets('InfoTab 은 외부 링크를 종류 · 제목 · 도메인으로 보여주고 누르면 알린다', (tester) async {
    final tapped = <String>[];
    const detail = RegionDetail(
      id: '51820',
      name: '고성군',
      province: '강원특별자치도',
      seasonType: SeasonType.flat,
      month: '2025-10',
      stats: RegionStats(
        crowdIndex: 68,
        dayInflow: 0.76,
        quietRank: 6,
        peerShare: 41,
        overnightCoef: 0.98,
        weekendRatio: 1.05,
      ),
      months: [],
      bestMonths: [2, 3],
      peerOffpeakMonths: [12, 2],
      links: [
        RegionLink(
          kind: 'support',
          title: '고성군 워케이션 체류 지원사업',
          url: 'https://www.gwgs.go.kr',
        ),
        RegionLink(
          kind: 'stay',
          title: '고성군 숙박 안내',
          url: 'https://stay.example.com/a',
        ),
      ],
    );
    const scores = MetricScores(
      quiet: 58,
      crowd: 33,
      peer: 42,
      overnight: 83,
      vibe: 33,
    );
    const rank = RegionRank(
      score: 50,
      rank: 3,
      total: 12,
      grade: Grade.s,
      scores: scores,
    );
    tester.view.physicalSize = const Size(390, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communityRepositoryProvider.overrideWithValue(
            FakeCommunityRepository(),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SingleChildScrollView(
              child: InfoTab(
                detail: detail,
                rank: rank,
                presetLabel: '조용한 곳',
                onLinkTap: (l) => tapped.add(l.title),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('지원사업'), findsOneWidget);
    expect(find.text('숙박'), findsOneWidget);
    expect(find.text('gwgs.go.kr'), findsOneWidget);
    expect(find.text('stay.example.com'), findsOneWidget);
    expect(
      find.textContaining('10월 조용한 곳 프리셋 종합 50점으로 12곳 중 3위(S)'),
      findsOneWidget,
    );

    await tester.tap(find.text('고성군 숙박 안내'));
    expect(tapped, ['고성군 숙박 안내']);
  });

  test('추천 사유 4문장은 한산한 달이면 마지막 문장이 달라진다', () {
    List<String> reason(Grade crowd) => buildReason(
      monthLabel: '10월',
      presetLabel: '조용한 곳',
      composite: 50,
      rank: 3,
      total: 12,
      grade: Grade.s,
      overnightCoef: 0.5,
      dayInflow: 1.2,
      crowdIndex: 67,
      crowdGrade: crowd,
      bestMonths: const [2, 3],
      peerOffpeakMonths: const [],
    );

    final busy = reason(Grade.b);
    expect(busy, hasLength(4));
    expect(busy[1], contains('당일 방문 비중이 큰'));
    expect(busy[2], contains('낮에 사람이 몰리는'));
    expect(busy[3], contains('시기 여유는 B입니다'));
    expect(busy[3], contains('2 · 3월'));
    expect(reason(Grade.a)[3], '10월은 연중 최대의 67%로 한산한 편입니다.');
  });
}
