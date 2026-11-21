import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/core/time/relative_time.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/shared/widgets/app_chip.dart';
import 'package:workation_mobile/shared/widgets/avatar.dart';
import 'package:workation_mobile/shared/widgets/metric_card.dart';
import 'package:workation_mobile/shared/widgets/photo_gallery.dart';
import 'package:workation_mobile/shared/widgets/photo_upload_tile.dart';
import 'package:workation_mobile/shared/widgets/reaction_poll.dart';
import 'package:workation_mobile/shared/widgets/tip_card.dart';
import 'package:workation_mobile/shared/widgets/tip_composer.dart';
import 'package:workation_mobile/shared/widgets/user_photo_tile.dart';

import '../../helpers.dart';

void main() {
  testWidgets('Avatar 는 글자를 그린다', (tester) async {
    await pumpInTheme(tester, const Avatar(initial: '바'));
    expect(find.text('바'), findsOneWidget);
  });

  testWidgets('MetricCard 는 라벨 · 점수 · 등급 · 부제를 보여주고 값이 없으면 —', (tester) async {
    await pumpInTheme(
      tester,
      const Column(
        children: [
          MetricCard(
            label: '동네 조용함',
            score: 31.4,
            grade: Grade.b,
            subtitle: '낮 유입 지수 0.79 · 백분위 31',
          ),
          MetricCard(label: '또래 밀도', score: null, grade: null),
        ],
      ),
    );

    expect(find.text('동네 조용함'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    expect(find.text('점'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('낮 유입 지수 0.79 · 백분위 31'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('MetricGrid 는 두 열로 놓고 홀수면 마지막 칸이 빈다', (tester) async {
    await pumpInTheme(
      tester,
      const SizedBox(
        width: 358,
        child: MetricGrid(
          cards: [
            MetricCard(label: '가', score: 1, grade: Grade.c),
            MetricCard(label: '나', score: 2, grade: Grade.c),
            MetricCard(label: '다', score: 3, grade: Grade.c),
          ],
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.text('나')).dy,
      tester.getTopLeft(find.text('가')).dy,
    );
    expect(
      tester.getTopLeft(find.text('다')).dy,
      greaterThan(tester.getTopLeft(find.text('가')).dy),
    );
  });

  testWidgets('TipCard 는 작성자 · 메타 · 방문 월 · 도움돼요를 보여준다', (tester) async {
    await pumpInTheme(
      tester,
      TipCard(
        const Tip(
          id: 't',
          author: TipAuthor(nickname: '바다러버', initial: '바'),
          createdAt: '2026-11-11T09:00:00+09:00',
          dongName: '거진읍',
          stayLabel: '2주 체류',
          visitMonth: '2025-10',
          body: '카페는 평일 오전이 한산해요.',
          helpful: 12,
          replies: 2,
        ),
        now: DateTime.parse('2026-11-14T09:00:00+09:00'),
      ),
    );

    expect(find.text('바다러버'), findsOneWidget);
    expect(find.text('3일 전 · 거진읍 · 2주 체류'), findsOneWidget);
    expect(find.text('10월 방문'), findsOneWidget);
    expect(find.text('카페는 평일 오전이 한산해요.'), findsOneWidget);
    expect(find.text('도움돼요 12'), findsOneWidget);
    expect(find.text('답글 2'), findsOneWidget);
  });

  testWidgets('TipCard 는 붙인 사진을 본문 아래에 보여주고, 누르면 그 사진부터 크게 본다', (tester) async {
    const tip = Tip(
      id: 't',
      author: TipAuthor(nickname: '바다러버', initial: '바'),
      createdAt: '2026-11-11T09:00:00+09:00',
      body: '본문',
      photos: [
        TipPhoto(id: 'p1', url: 'assets/none-1.jpg'),
        TipPhoto(id: 'p2', url: 'assets/none-2.jpg'),
        TipPhoto(id: 'p3', url: 'assets/none-3.jpg'),
      ],
    );
    await pumpInTheme(tester, const SizedBox(width: 358, child: TipCard(tip)));

    final thumbs = find.descendant(
      of: find.byType(PhotoThumbRow),
      matching: find.byType(GestureDetector),
    );
    expect(thumbs, findsNWidgets(3));
    expect(find.bySemanticsLabel('바다러버 님의 사진 2'), findsOneWidget);
    expect(
      tester.getTopLeft(find.byType(PhotoThumbRow)).dy,
      greaterThan(tester.getTopLeft(find.text('본문')).dy),
    );
    expect(tester.getSize(thumbs.first), const Size(96, 96));

    await tester.tap(thumbs.at(1));
    await tester.pumpAndSettle();
    expect(find.byType(PhotoGallery), findsOneWidget);
    expect(find.text('2 / 3'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(find.text('3 / 3'), findsOneWidget);

    await tester.tap(find.byTooltip('닫기'));
    await tester.pumpAndSettle();
    expect(find.byType(PhotoGallery), findsNothing);
  });

  testWidgets('TipCard 는 사진이 없으면 사진 줄을 그리지 않고, 좁으면 썸네일이 줄어든다', (tester) async {
    Tip tip(List<TipPhoto> photos) => Tip(
      id: 't',
      author: const TipAuthor(nickname: '바다러버', initial: '바'),
      createdAt: '2026-11-11T09:00:00+09:00',
      body: '본문',
      photos: photos,
    );
    await pumpInTheme(tester, SizedBox(width: 358, child: TipCard(tip([]))));
    expect(find.byType(PhotoThumbRow), findsNothing);

    await pumpInTheme(
      tester,
      SizedBox(
        width: 300,
        child: TipCard(
          tip([
            for (var i = 0; i < 3; i++)
              TipPhoto(id: 'p$i', url: 'assets/none-$i.jpg'),
          ]),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    final thumb = tester.getSize(
      find
          .descendant(
            of: find.byType(PhotoThumbRow),
            matching: find.byType(GestureDetector),
          )
          .first,
    );
    expect(thumb.width, lessThan(96));
    expect(thumb.width, thumb.height);
  });

  test('relativeTime 은 구간별로 쓴다', () {
    final now = DateTime.utc(2026, 11, 14, 12);
    String at(Duration ago) =>
        relativeTime(now.subtract(ago).toIso8601String(), now: now);
    expect(at(const Duration(minutes: 10)), '방금');
    expect(at(const Duration(hours: 5)), '5시간 전');
    expect(at(const Duration(days: 3)), '3일 전');
    expect(at(const Duration(days: 65)), '2개월 전');
    expect(at(const Duration(days: 800)), '2년 전');
    expect(relativeTime('엉터리', now: now), '');
  });

  testWidgets('TipComposer 는 로그인 여부에 따라 문구가 다르고 누르면 알린다', (tester) async {
    var taps = 0;
    Widget bar({required bool loggedIn}) =>
        TipComposer(loggedIn: loggedIn, initial: '두', onTap: () => taps++);

    await pumpInTheme(tester, bar(loggedIn: false));
    expect(find.textContaining('로그인하면 팁을 남기고'), findsOneWidget);
    expect(find.text('로그인'), findsOneWidget);
    await tester.tap(find.byType(TipComposer));
    expect(taps, 1);

    await pumpInTheme(tester, bar(loggedIn: true));
    expect(find.text('이 지역에서 알게 된 팁을 남겨보세요'), findsOneWidget);
    expect(find.text('등록'), findsOneWidget);
    expect(find.text('두'), findsOneWidget);
  });

  /// [열기] 를 누르면 팁 입력 시트를 띄우는 화면. 받은 내용은 [drafts] 에 쌓입니다.
  Future<void> pumpComposer(
    WidgetTester tester, {
    required List<TipDraft> drafts,
    List<bool>? results,
    String? Function(TipDraft draft)? reply,
    int maxLength = tipMaxLength,
    String? initialVisitMonth,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              final done = await showTipComposerSheet(
                context,
                maxLength: maxLength,
                initialVisitMonth: initialVisitMonth,
                onSubmit: (draft) async {
                  drafts.add(draft);
                  return reply?.call(draft);
                },
              );
              results?.add(done);
            },
            child: const Text('열기'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('열기'));
    await tester.pumpAndSettle();
  }

  FilledButton submitButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.byType(FilledButton));

  bool chipSelected(WidgetTester tester, String label) =>
      tester.widget<AppChip>(find.widgetWithText(AppChip, label)).selected;

  testWidgets('팁 입력 시트는 빈 값을 막고 글자 수를 제한하고 공백을 다듬어 넘긴다', (tester) async {
    final drafts = <TipDraft>[];
    final closed = <bool>[];
    await pumpComposer(tester, drafts: drafts, results: closed, maxLength: 10);

    expect(submitButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '   ');
    await tester.pump();
    expect(submitButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '12345678901234');
    await tester.pump();
    expect(find.text('10/10'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '  좋아요  ');
    await tester.pump();
    expect(submitButton(tester).onPressed, isNotNull);
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(drafts.single.body, '좋아요');
    expect(drafts.single.visitMonth, isNull);
    expect(closed, [true]);
    expect(find.text('한 줄 팁 남기기'), findsNothing);
  });

  testWidgets('팁 입력 시트를 그냥 닫으면 아무것도 넘기지 않는다', (tester) async {
    final drafts = <TipDraft>[];
    final closed = <bool>[];
    await pumpComposer(tester, drafts: drafts, results: closed);

    await tester.enterText(find.byType(TextField), '쓰다 만 팁');
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(drafts, isEmpty);
    expect(closed, [false]);
  });

  testWidgets('방문 월: 처음 값은 화면의 달이고, 연간이면 없음이다', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final drafts = <TipDraft>[];
    await pumpComposer(tester, drafts: drafts, initialVisitMonth: '2025-12');
    expect(find.text('방문 월'), findsOneWidget);
    expect(chipSelected(tester, '12월'), isTrue);
    expect(chipSelected(tester, '없음'), isFalse);
    // 맨 끝 달도 처음부터 보이는 곳에 있습니다.
    final chip = tester.getRect(find.widgetWithText(AppChip, '12월'));
    expect(chip.left, greaterThanOrEqualTo(0));
    expect(chip.right, lessThanOrEqualTo(390));

    await tester.enterText(find.byType(TextField), '겨울 바다');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(drafts.single.visitMonth, '2025-12');

    drafts.clear();
    await pumpComposer(tester, drafts: drafts);
    expect(chipSelected(tester, '없음'), isTrue);
    for (var m = 1; m <= 12; m++) {
      expect(chipSelected(tester, '$m월'), isFalse);
    }
  });

  testWidgets('방문 월: 다른 달로 바꾸거나 없음으로 뺄 수 있다', (tester) async {
    final drafts = <TipDraft>[];
    await pumpComposer(tester, drafts: drafts, initialVisitMonth: '2025-02');

    await tester.tap(find.widgetWithText(AppChip, '3월'));
    await tester.pump();
    expect(chipSelected(tester, '3월'), isTrue);
    expect(chipSelected(tester, '2월'), isFalse);
    await tester.enterText(find.byType(TextField), '봄');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(drafts.single.visitMonth, '2025-03');

    drafts.clear();
    await pumpComposer(tester, drafts: drafts, initialVisitMonth: '2025-12');
    // 끝 달을 골라 둬도 없음은 늘 보이는 자리에 있습니다.
    await tester.tap(find.widgetWithText(AppChip, '없음'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), '언제든');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(drafts.single.visitMonth, isNull);
  });

  testWidgets('등록에 실패하면 쓴 내용 · 방문 월을 둔 채 시트 안에서 알리고, 다시 누르면 보낸다', (
    tester,
  ) async {
    final drafts = <TipDraft>[];
    final closed = <bool>[];
    await pumpComposer(
      tester,
      drafts: drafts,
      results: closed,
      initialVisitMonth: '2025-05',
      reply: (_) => drafts.length == 1 ? '팁을 등록하지 못했어요' : null,
    );

    await tester.enterText(find.byType(TextField), '다시 보낼 팁');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(find.text('팁을 등록하지 못했어요'), findsOneWidget);
    expect(find.text('다시 보낼 팁'), findsOneWidget);
    expect(chipSelected(tester, '5월'), isTrue);
    expect(closed, isEmpty);

    await tester.tap(find.widgetWithText(FilledButton, '등록'));
    await tester.pumpAndSettle();
    expect(drafts, hasLength(2));
    expect(drafts.last.body, '다시 보낼 팁');
    expect(drafts.last.visitMonth, '2025-05');
    expect(closed, [true]);
  });

  testWidgets('ReactionPoll 은 비율 · 참여 수를 보여주고 고른 쪽을 표시하며 누르면 알린다', (
    tester,
  ) async {
    final votes = <PollChoice>[];
    Widget poll(PollResponse p) => ReactionPoll(
      question: '거진읍 저녁, 정말 조용한가요?',
      poll: p,
      participationLabel: '지표 검증에 반영돼요',
      onVote: votes.add,
    );

    await pumpInTheme(
      tester,
      poll(const PollResponse(yes: 3, no: 1, total: 4)),
    );
    expect(find.text('거진읍 저녁, 정말 조용한가요?'), findsOneWidget);
    expect(find.text('그래요 75%'), findsOneWidget);
    expect(find.text('아니요 25%'), findsOneWidget);
    expect(find.text('4명 참여 · 지표 검증에 반영돼요'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.selected == true,
      ),
      findsNothing,
    );

    await tester.tap(find.text('아니요 25%'));
    expect(votes, [PollChoice.no]);

    await pumpInTheme(
      tester,
      poll(const PollResponse(yes: 3, no: 1, total: 4, myVote: PollChoice.yes)),
    );
    expect(
      find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.selected == true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('ReactionPoll 은 투표가 없으면 0% 이고 onVote 가 없으면 누를 수 없다', (
    tester,
  ) async {
    await pumpInTheme(
      tester,
      const ReactionPoll(
        question: '질문',
        poll: PollResponse(yes: 0, no: 0, total: 0),
        participationLabel: '문구',
      ),
    );
    expect(find.text('그래요 0%'), findsOneWidget);
    expect(find.text('아니요 0%'), findsOneWidget);
    expect(find.text('0명 참여 · 문구'), findsOneWidget);
  });

  testWidgets('UserPhotoTile 은 @닉네임을, PhotoUploadTile 은 문구를 보여주고 누르면 알린다', (
    tester,
  ) async {
    var taps = 0;
    await pumpInTheme(
      tester,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserPhotoTile(url: null, author: '바다러버'),
          PhotoUploadTile(onTap: () => taps++),
        ],
      ),
    );

    expect(find.text('@바다러버'), findsOneWidget);
    expect(find.text('바'), findsOneWidget);
    expect(find.text('이달의 사진 올리기'), findsOneWidget);
    expect(tester.getSize(find.byType(UserPhotoTile)), const Size(120, 90));
    await tester.tap(find.text('이달의 사진 올리기'));
    expect(taps, 1);
  });
}
