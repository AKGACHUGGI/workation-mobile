import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/data/models/me.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/favorites_repository.dart';
import 'package:workation_mobile/data/repositories/me_repository.dart';
import 'package:workation_mobile/data/repositories/mock_assets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final assets = MockAssets(rootBundle, delay: Duration.zero);

  group('MockFavoritesRepository', () {
    test('웹 mock 의 초기 값: 지역 3 · 동네 3', () async {
      final repo = MockFavoritesRepository(assets);

      final res = await repo.list('2025-10');
      expect(res.month, '2025-10');
      expect(res.regions.map((r) => r.name), ['고성군', '강릉시', '서귀포시']);
      expect(res.dongs.map((d) => d.name), ['거진읍', '죽왕면', '중문동']);
      expect(res.dongs.first.kind, DongKind.living);
      expect(res.regions.first.note, '11월 2주 체류 예정');
      final ids = await repo.ids();
      expect(ids.total, 6);
    });

    test('저장 · 해제는 메모리에 남는다', () async {
      final repo = MockFavoritesRepository(assets);

      await repo.put(FavoriteKind.regions, '51830'); // 양양군(인기 지역 mock 에서 채움)
      await repo.put(FavoriteKind.regions, '51830'); // 중복은 무시
      await repo.put(FavoriteKind.dongs, '5182034000'); // 토성면(지역 상세 mock 에서 채움)
      var res = await repo.list('2025-10');
      expect(res.regions.map((r) => r.id), contains('51830'));
      expect(res.regions.where((r) => r.id == '51830'), hasLength(1));
      final yangyang = res.regions.firstWhere((r) => r.id == '51830');
      expect(yangyang.name, '양양군');
      expect(yangyang.scores.quiet, greaterThan(0));
      final tosung = res.dongs.firstWhere((d) => d.id == '5182034000');
      expect(tosung.name, '토성면');
      expect(tosung.kind, DongKind.tourist);
      expect(tosung.sigungu.name, '고성군');

      await repo.remove(FavoriteKind.regions, '51820');
      await repo.remove(FavoriteKind.dongs, '5182034000');
      res = await repo.list('2025-10');
      expect(res.regions.map((r) => r.id), isNot(contains('51820')));
      expect(res.dongs.map((d) => d.id), isNot(contains('5182034000')));
    });

    test('모르는 id 도 빈 항목으로 저장되고, 상한을 넘으면 오류다', () async {
      final repo = MockFavoritesRepository(assets);

      await repo.put(FavoriteKind.regions, '99999');
      expect((await repo.list('2025-10')).regions.last.name, '99999');

      for (var i = 0; i < favoriteLimit; i++) {
        try {
          await repo.put(FavoriteKind.dongs, 'dong$i');
        } on FavoriteLimitException {
          break;
        }
      }
      await expectLater(
        repo.put(FavoriteKind.regions, 'one-more'),
        throwsA(isA<FavoriteLimitException>()),
      );
      expect((await repo.ids()).total, favoriteLimit);
    });
  });

  group('MockMeRepository', () {
    test('요약 · 팁 · 사진 · 설정은 웹 mock 의 초기 값이다', () async {
      final repo = MockMeRepository(assets);

      final summary = await repo.summary();
      expect(summary.stays.map((s) => '${s.regionName} ${s.count}'), [
        '강릉 2',
        '고성 1',
      ]);
      // 팁 · 사진 수는 목록 길이를 따른다(웹 mock 과 같음)
      expect(summary.tipCount, 2);
      expect(summary.photoCount, 4);

      final tips = await repo.tips();
      expect(tips.items.first.target.kind, TipTargetKind.region);
      expect(tips.items.first.target.name, '고성군');
      expect(tips.helpfulSum, 17);

      final photos = await repo.photos();
      expect(
        photos.items.where((p) => p.status == PhotoStatus.pending),
        hasLength(2),
      );

      final settings = await repo.settings();
      expect(settings.notifyBestMonth, isTrue);
      expect(settings.notifyTipReaction, isTrue);
      expect(settings.notifyPhotoSelected, isFalse);
    });

    test('설정 PATCH 는 바꾼 값만 합쳐 메모리에 남긴다', () async {
      final repo = MockMeRepository(assets);

      final saved = await repo.patchSettings(notifyPhotoSelected: true);
      expect(saved.notifyPhotoSelected, isTrue);
      expect(saved.notifyBestMonth, isTrue);
      expect((await repo.settings()).notifyPhotoSelected, isTrue);
    });
  });
}
