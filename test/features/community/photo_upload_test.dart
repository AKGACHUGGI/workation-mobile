import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/photo/photo_picker.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/features/community/widgets/photo_upload_sheet.dart';
import 'package:workation_mobile/features/my/my_providers.dart';
import 'package:workation_mobile/shared/widgets/photo_gallery.dart';
import 'package:workation_mobile/shared/widgets/photo_pick_strip.dart';
import 'package:workation_mobile/shared/widgets/tip_card.dart';
import 'package:workation_mobile/shared/widgets/tip_composer.dart';
import 'package:workation_mobile/shared/widgets/user_photo_tile.dart';

import '../../fakes/account.dart';
import '../../fakes/community.dart';
import '../../fakes/photos.dart';
import '../../helpers.dart';

/// 사진 올리기: 팁 사진 첨부(M-03c · M-04) · 이달의 사진(M-03c).
void main() {
  FilledButton button(WidgetTester tester, String label) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, label));

  Future<void> tapAdd(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(PhotoPickStrip),
        matching: find.byType(InkWell),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('팁 입력 시트의 사진', () {
    Future<void> pumpComposer(
      WidgetTester tester, {
      required FakePhotoPicker picker,
      required List<TipDraft> drafts,
      String? editingBody,
      bool withPicker = true,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showTipComposerSheet(
                context,
                editingBody: editingBody,
                onPickPhotos: withPicker
                    ? (max) => picker.pick(max: max)
                    : null,
                onSubmit: (draft) async {
                  drafts.add(draft);
                  return null;
                },
              ),
              child: const Text('열기'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('열기'));
      await tester.pumpAndSettle();
    }

    testWidgets('사진을 고르면 미리 보기가 생기고, 빼고, 남은 자리만큼만 더 고른다', (tester) async {
      final picker = FakePhotoPicker([
        [photo('a.jpg'), photo('b.jpg')],
        [photo('c.png')],
      ]);
      final drafts = <TipDraft>[];
      await pumpComposer(tester, picker: picker, drafts: drafts);

      expect(find.bySemanticsLabel('사진 추가, 0/3'), findsOneWidget);
      await tapAdd(tester);
      expect(picker.asked, [3]);
      expect(find.bySemanticsLabel('사진 추가, 2/3'), findsOneWidget);
      expect(find.bySemanticsLabel('고른 사진 2'), findsOneWidget);

      // 첫 장을 빼면 한 장이 남고, 다시 고를 때는 남은 두 자리만 묻습니다.
      await tester.tap(find.bySemanticsLabel('고른 사진 1 빼기'));
      await tester.pump();
      expect(find.bySemanticsLabel('사진 추가, 1/3'), findsOneWidget);
      await tapAdd(tester);
      expect(picker.asked, [3, 2]);
      expect(find.bySemanticsLabel('사진 추가, 2/3'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '사진 붙인 팁');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, '등록'));
      await tester.pumpAndSettle();
      expect(
        [for (final p in drafts.single.photos) p.name],
        ['b.jpg', 'c.png'],
      );
    });

    testWidgets('세 장을 채우면 더 고를 수 없고, 넘치게 고르면 세 장만 받고 알린다', (tester) async {
      final picker = FakePhotoPicker([
        [photo('a.jpg'), photo('b.jpg'), photo('c.jpg'), photo('d.jpg')],
      ]);
      await pumpComposer(tester, picker: picker, drafts: []);

      await tapAdd(tester);
      expect(find.bySemanticsLabel('사진 추가, 3/3'), findsOneWidget);
      expect(find.text('사진은 3장까지 올릴 수 있어요'), findsOneWidget);

      await tapAdd(tester);
      expect(picker.asked, [3]);
    });

    testWidgets('형식이 다른 사진은 빼고 알리며, 보관함을 못 열면 권한을 안내한다', (tester) async {
      final picker = FakePhotoPicker([
        [photo('움짤.gif'), photo('a.jpg')],
      ]);
      await pumpComposer(tester, picker: picker, drafts: []);

      await tapAdd(tester);
      expect(find.bySemanticsLabel('사진 추가, 1/3'), findsOneWidget);
      expect(find.text('JPEG · PNG · WebP 사진만 올릴 수 있어요'), findsOneWidget);

      picker.fail = true;
      await tapAdd(tester);
      expect(find.textContaining('사진 접근 권한을 확인해 주세요'), findsOneWidget);
      expect(find.bySemanticsLabel('사진 추가, 1/3'), findsOneWidget);
    });

    testWidgets('사진 없이도 등록되고, 고치기 · 사진 고르기가 없을 때는 사진 줄이 없다', (tester) async {
      final drafts = <TipDraft>[];
      await pumpComposer(tester, picker: FakePhotoPicker(), drafts: drafts);
      await tester.enterText(find.byType(TextField), '글만');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, '등록'));
      await tester.pumpAndSettle();
      expect(drafts.single.photos, isEmpty);

      await pumpComposer(
        tester,
        picker: FakePhotoPicker(),
        drafts: drafts,
        editingBody: '고칠 팁',
      );
      expect(find.byType(PhotoPickStrip), findsNothing);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await pumpComposer(
        tester,
        picker: FakePhotoPicker(),
        drafts: drafts,
        withPicker: false,
      );
      expect(find.byType(PhotoPickStrip), findsNothing);
    });
  });

  group('지역 화면', () {
    Future<void> open(
      WidgetTester tester, {
      required FakeCommunityRepository community,
      required FakePhotoPicker picker,
      FakeMeRepository? me,
    }) => pumpApp(
      tester,
      loggedIn: true,
      location: AppRoutes.region('51820', tab: 'info'),
      community: community,
      photos: picker,
      me: me,
    );

    testWidgets('팁에 사진을 붙여 등록하면 카드에 사진 줄이 보인다', (tester) async {
      final community = FakeCommunityRepository();
      final picker = FakePhotoPicker([
        [photo('a.jpg'), photo('b.jpg')],
      ]);
      await open(tester, community: community, picker: picker);

      await tester.ensureVisible(find.byType(TipComposer));
      await tester.tap(find.byType(TipComposer));
      await tester.pumpAndSettle();
      await tapAdd(tester);
      await tester.enterText(find.byType(TextField), '사진 붙인 팁');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, '등록'));
      await tester.pumpAndSettle();

      expect(community.posted, ['사진 붙인 팁']);
      expect(community.postedPhotos, [
        ['a.jpg', 'b.jpg'],
      ]);
      final first = tester.widgetList<TipCard>(find.byType(TipCard)).first;
      expect(first.tip.photos, hasLength(2));
      expect(
        find.descendant(
          of: find.byType(TipCard).first,
          matching: find.byType(PhotoThumbRow),
        ),
        findsOneWidget,
      );
    });

    testWidgets('사진을 붙인 팁이 거절되면 사진 탓인지 알려 주고 고른 사진을 둔다', (tester) async {
      final community = FakeCommunityRepository()..postFailStatus = 400;
      final picker = FakePhotoPicker([
        [photo('a.jpg')],
      ]);
      await open(tester, community: community, picker: picker);

      await tester.ensureVisible(find.byType(TipComposer));
      await tester.tap(find.byType(TipComposer));
      await tester.pumpAndSettle();
      await tapAdd(tester);
      await tester.enterText(find.byType(TextField), '사진 붙인 팁');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, '등록'));
      await tester.pumpAndSettle();

      expect(find.textContaining('사진을 확인해 주세요'), findsOneWidget);
      expect(find.bySemanticsLabel('사진 추가, 1/3'), findsOneWidget);
      expect(find.text('사진 붙인 팁'), findsOneWidget);
    });

    testWidgets('이달의 사진: 골라서 올리면 사진 줄이 바뀌고 MY 의 사진 · 요약을 다시 읽는다', (
      tester,
    ) async {
      final community = FakeCommunityRepository(withPhotos: true);
      final me = FakeMeRepository();
      final picker = FakePhotoPicker([
        [photo('바다.jpg'), photo('항구.png')],
      ]);
      await open(tester, community: community, picker: picker, me: me);
      expect(find.byType(UserPhotoTile), findsOneWidget);
      // MY 요약이 읽혀 있었다고 칩니다.
      final container = ProviderScope.containerOf(
        tester.element(find.byType(UserPhotoTile)),
      );
      final sub = container.listen(meSummaryProvider, (_, _) {});
      addTearDown(sub.close);
      await tester.pumpAndSettle();
      final summaryBefore = me.summaryReads;

      await tester.ensureVisible(find.text('이달의 사진 올리기'));
      await tester.tap(find.text('이달의 사진 올리기'));
      await tester.pumpAndSettle();
      expect(find.byType(PhotoUploadSheet), findsOneWidget);
      expect(find.text('12월 · 사용자 제공'), findsNWidgets(2));
      expect(find.textContaining('올리면 바로 게시돼요'), findsOneWidget);
      expect(button(tester, '올리기').onPressed, isNull);

      await tapAdd(tester);
      expect(picker.asked, [photoMaxCount]);
      expect(find.bySemanticsLabel('사진 추가, 2/3'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, '올리기'));
      await tester.pumpAndSettle();

      // 연간이 아니면 화면의 달(12월)로 올립니다.
      expect(community.uploads.single.$1, '2025-12');
      expect(community.uploads.single.$2, ['바다.jpg', '항구.png']);
      expect(find.byType(PhotoUploadSheet), findsNothing);
      expect(find.text('사진을 올렸어요'), findsOneWidget);
      // 사진 줄은 최대 3장: 올린 2장 + 있던 1장
      expect(find.byType(UserPhotoTile), findsNWidgets(3));
      expect(find.text('@두이'), findsNWidgets(2));
      expect(me.summaryReads, summaryBefore + 1);
    });

    testWidgets('이달의 사진: 실패하면 시트 안에서 이유를 알리고 고른 사진을 둔 채 다시 올릴 수 있다', (
      tester,
    ) async {
      final community = FakeCommunityRepository(withPhotos: true)
        ..uploadError = const ServerException(
          '/api/regions/51820/photos',
          429,
          code: 'PHOTO_RATE_LIMIT',
        );
      final picker = FakePhotoPicker([
        [photo('a.jpg')],
      ]);
      await open(tester, community: community, picker: picker);

      await tester.ensureVisible(find.text('이달의 사진 올리기'));
      await tester.tap(find.text('이달의 사진 올리기'));
      await tester.pumpAndSettle();
      await tapAdd(tester);
      await tester.tap(find.widgetWithText(FilledButton, '올리기'));
      await tester.pumpAndSettle();

      expect(find.textContaining('1시간에 30장까지'), findsOneWidget);
      expect(find.byType(PhotoUploadSheet), findsOneWidget);
      expect(find.bySemanticsLabel('사진 추가, 1/3'), findsOneWidget);

      community.uploadError = const ServerException(
        '/api/regions/51820/photos',
        400,
        code: 'INVALID_PHOTO',
        message: '1번째 사진이 너무 커요.',
      );
      await tester.tap(find.widgetWithText(FilledButton, '올리기'));
      await tester.pumpAndSettle();
      expect(find.text('1번째 사진이 너무 커요.'), findsOneWidget);

      community.uploadError = null;
      await tester.tap(find.widgetWithText(FilledButton, '올리기'));
      await tester.pumpAndSettle();
      expect(find.byType(PhotoUploadSheet), findsNothing);
      expect(community.uploads, hasLength(1));
    });
  });
}
