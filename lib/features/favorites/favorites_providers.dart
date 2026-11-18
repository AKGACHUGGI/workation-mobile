import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/me.dart';
import '../../data/repositories/favorites_repository.dart';
import '../auth/auth_providers.dart';
import '../home/home_providers.dart';

/// 저장 · 해제 결과. 화면이 안내 문구를 고르는 데 씁니다.
enum SaveResult { ok, limit, failed }

/// 내가 저장한 지역 · 동네 id (결정 3: 로그인 필수, 비로그인 기기 저장 · 병합 없음).
///
/// - 로그인하면 `GET /api/me/favorites/ids` 를 읽고, 로그아웃하면 비웁니다.
/// - 저장 · 해제는 먼저 화면에 반영하고 서버에 보낸 뒤, 실패하면 되돌립니다.
/// - 로그인이 필요한 하트 동작은 `toggleFavoriteWithLogin` 으로 부르세요.
///   이 notifier 는 로그인한 상태를 가정합니다. 비로그인에서는 아무것도 저장하지 않습니다.
class FavoriteIdsNotifier extends Notifier<FavoriteIds> {
  Future<void> _ready = Future.value();

  /// 이번 세션의 저장 목록을 다 읽었는지. 읽은 뒤에는 기다리지 않고 바로 반영합니다.
  bool _loaded = false;

  /// 세션이 바뀔 때마다 올라가, 이전 로그인의 늦은 응답을 버립니다.
  int _generation = 0;

  @override
  FavoriteIds build() {
    final user = ref.watch(sessionProvider);
    final generation = ++_generation;
    _loaded = false;
    if (user == null) {
      _ready = Future.value();
    } else {
      _ready = _load(generation);
    }
    return const FavoriteIds();
  }

  Future<void> _load(int generation) async {
    try {
      final ids = await ref.read(favoritesRepositoryProvider).ids();
      if (ref.mounted && generation == _generation) state = ids;
    } on Object {
      // 읽지 못하면 비어 있는 채로 둡니다. 하트를 누르면 서버 결과로 맞춰집니다.
    }
    if (ref.mounted && generation == _generation) _loaded = true;
  }

  bool isRegionSaved(String id) => state.contains(FavoriteKind.regions, id);

  /// 동네 프로필(M-04)의 저장 버튼에서 씁니다.
  bool isDongSaved(String id) => state.contains(FavoriteKind.dongs, id);

  /// [saved] 상태로 맞춥니다.
  Future<SaveResult> setSaved(
    FavoriteKind kind,
    String id, {
    required bool saved,
  }) async {
    if (ref.read(sessionProvider) == null) return SaveResult.failed;
    final generation = _generation;
    if (!_loaded) await _ready;
    if (!ref.mounted || generation != _generation) return SaveResult.failed;
    if (state.contains(kind, id) == saved) return SaveResult.ok;

    state = state.withSaved(kind, id, saved: saved);
    final repo = ref.read(favoritesRepositoryProvider);
    SaveResult? failure;
    try {
      await (saved ? repo.put(kind, id) : repo.remove(kind, id));
    } on FavoriteLimitException {
      failure = SaveResult.limit;
    } on Object {
      failure = SaveResult.failed;
    }
    if (failure != null && ref.mounted && generation == _generation) {
      state = state.withSaved(kind, id, saved: !saved);
    }
    return failure ?? SaveResult.ok;
  }

  Future<SaveResult> toggle(FavoriteKind kind, String id) =>
      setSaved(kind, id, saved: !state.contains(kind, id));

  Future<SaveResult> toggleRegion(String id) =>
      toggle(FavoriteKind.regions, id);

  /// 동네 프로필(M-04)의 저장 버튼에서 씁니다.
  Future<SaveResult> toggleDong(String id) => toggle(FavoriteKind.dongs, id);
}

final favoriteIdsProvider = NotifierProvider<FavoriteIdsNotifier, FavoriteIds>(
  FavoriteIdsNotifier.new,
);

/// 이 지역을 저장했는지. 비로그인이면 항상 false.
final isRegionSavedProvider = Provider.family<bool, String>(
  (ref, id) => ref.watch(
    favoriteIdsProvider.select((v) => v.contains(FavoriteKind.regions, id)),
  ),
);

/// 이 동네를 저장했는지. 비로그인이면 항상 false.
final isDongSavedProvider = Provider.family<bool, String>(
  (ref, id) => ref.watch(
    favoriteIdsProvider.select((v) => v.contains(FavoriteKind.dongs, id)),
  ),
);

/// M-05 에 보여줄 저장 목록. 저장 · 해제로 id 가 바뀌면 다시 읽습니다.
/// 비로그인이면 서버를 부르지 않고 빈 목록입니다.
final favoritesListProvider = FutureProvider<FavoritesResponse>((ref) async {
  final month = ref.watch(homeFilterProvider.select((f) => f.month));
  final user = ref.watch(sessionProvider);
  if (user == null) return FavoritesResponse(month: month);
  ref.watch(
    favoriteIdsProvider.select(
      (v) => '${v.regions.join(',')}|${v.dongs.join(',')}',
    ),
  );
  return ref.read(favoritesRepositoryProvider).list(month);
});
