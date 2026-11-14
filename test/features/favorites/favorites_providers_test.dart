import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/data/models/me.dart';
import 'package:workation_mobile/data/repositories/favorites_repository.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';
import 'package:workation_mobile/features/favorites/favorites_providers.dart';

import '../../fakes/account.dart';

void main() {
  late FakeFavoritesRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = FakeFavoritesRepository();
    container = ProviderContainer(
      overrides: [favoritesRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  FavoriteIdsNotifier notifier() =>
      container.read(favoriteIdsProvider.notifier);
  FavoriteIds ids() => container.read(favoriteIdsProvider);

  /// 로그인하고 저장 목록을 다 읽을 때까지 기다립니다.
  Future<void> signIn() async {
    container.listen(favoriteIdsProvider, (_, _) {});
    container.read(sessionProvider.notifier).signInMock(AuthProviderKind.kakao);
    await Future<void>.delayed(Duration.zero);
  }

  test('비로그인에서는 비어 있고 저장도 되지 않는다', () async {
    container.listen(favoriteIdsProvider, (_, _) {});

    expect(ids().total, 0);
    expect(notifier().isRegionSaved('51820'), isFalse);
    expect(await notifier().toggleRegion('51820'), SaveResult.failed);
    expect(repo.calls, isEmpty);
    expect(container.read(isRegionSavedProvider('51820')), isFalse);
  });

  test('로그인하면 저장한 지역 · 동네를 읽어 온다', () async {
    await signIn();

    expect(ids().regions, ['51820']);
    expect(notifier().isRegionSaved('51820'), isTrue);
    expect(notifier().isDongSaved('5182025300'), isTrue);
    expect(container.read(isDongSavedProvider('5182025300')), isTrue);
    expect(container.read(isDongSavedProvider('없는동')), isFalse);
  });

  test('토글은 먼저 반영되고 서버에 PUT · DELETE 를 보낸다', () async {
    await signIn();

    final future = notifier().toggleRegion('51830');
    expect(ids().regions, contains('51830')); // 서버 응답 전에 이미 보임
    expect(await future, SaveResult.ok);
    expect(repo.calls, ['PUT regions/51830']);

    expect(await notifier().toggleRegion('51830'), SaveResult.ok);
    expect(ids().regions, isNot(contains('51830')));
    expect(repo.calls.last, 'DELETE regions/51830');

    expect(await notifier().toggleDong('5182025300'), SaveResult.ok);
    expect(notifier().isDongSaved('5182025300'), isFalse);
    expect(repo.calls.last, 'DELETE dongs/5182025300');
  });

  test('이미 그 상태면 서버를 부르지 않는다', () async {
    await signIn();

    final result = await notifier().setSaved(
      FavoriteKind.regions,
      '51820',
      saved: true,
    );

    expect(result, SaveResult.ok);
    expect(repo.calls, isEmpty);
  });

  test('저장이 실패하면 되돌리고, 상한이면 limit 으로 알린다', () async {
    await signIn();

    repo.failWrites = true;
    expect(await notifier().toggleRegion('51830'), SaveResult.failed);
    expect(ids().regions, isNot(contains('51830')));
    expect(await notifier().toggleRegion('51820'), SaveResult.failed);
    expect(ids().regions, contains('51820')); // 해제 실패도 되돌림

    repo.failWrites = false;
    repo.limitReached = true;
    expect(await notifier().toggleRegion('51830'), SaveResult.limit);
    expect(ids().regions, isNot(contains('51830')));
  });

  test('로그아웃하면 비우고, 다시 로그인하면 서버 값이 돌아온다', () async {
    await signIn();
    await notifier().toggleRegion('51830');
    expect(ids().regions, ['51820', '51830']);

    container.read(sessionProvider.notifier).signOut();
    expect(ids().total, 0);
    expect(container.read(isRegionSavedProvider('51820')), isFalse);

    container
        .read(sessionProvider.notifier)
        .signInMock(AuthProviderKind.google);
    await Future<void>.delayed(Duration.zero);
    expect(ids().regions, ['51820', '51830']);
  });

  test('저장 목록은 로그인했을 때만 서버에서 읽고 id 가 바뀌면 다시 읽는다', () async {
    container.listen(favoritesListProvider, (_, _) {});
    expect(
      (await container.read(favoritesListProvider.future)).regions,
      isEmpty,
    );

    await signIn();
    var list = await container.read(favoritesListProvider.future);
    expect(list.regions.map((r) => r.name), ['고성군']);
    expect(list.dongs.map((d) => d.name), ['거진읍']);

    await notifier().toggleRegion('51830');
    list = await container.read(favoritesListProvider.future);
    expect(list.regions.map((r) => r.name), ['고성군', '양양군']);

    container.read(sessionProvider.notifier).signOut();
    list = await container.read(favoritesListProvider.future);
    expect(list.regions, isEmpty);
  });
}
