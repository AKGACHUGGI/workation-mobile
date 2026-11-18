import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/me.dart';
import '../models/popular_region.dart';
import '../models/region_detail.dart';
import 'mock_assets.dart';

/// 즐겨찾기가 [favoriteLimit] 개를 넘을 때 (`PUT` 이 409).
class FavoriteLimitException implements Exception {
  const FavoriteLimitException();

  @override
  String toString() => 'FavoriteLimitException';
}

/// 내 즐겨찾기(M-05, 홈 · 지역 상세 하트). 로그인한 사용자에게만 열립니다.
abstract class FavoritesRepository {
  /// `GET /api/me/favorites?month=` — 지역 카드 · 동네 목록.
  Future<FavoritesResponse> list(String month);

  /// `GET /api/me/favorites/ids` — 하트 상태용.
  Future<FavoriteIds> ids();

  /// `PUT /api/me/favorites/{regions|dongs}/{id}` — 이미 있으면 그대로 둡니다.
  /// 상한을 넘으면 [FavoriteLimitException].
  Future<void> put(FavoriteKind kind, String id);

  /// `DELETE /api/me/favorites/{regions|dongs}/{id}`
  Future<void> remove(FavoriteKind kind, String id);
}

class ApiFavoritesRepository implements FavoritesRepository {
  const ApiFavoritesRepository(this._client);

  final ApiClient _client;

  @override
  Future<FavoritesResponse> list(String month) async {
    final json = await _client.get(
      '/api/me/favorites',
      query: {'month': month},
    );
    return FavoritesResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<FavoriteIds> ids() async {
    final json = await _client.get('/api/me/favorites/ids');
    return FavoriteIds.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<void> put(FavoriteKind kind, String id) async {
    try {
      await _client.put('/api/me/favorites/${kind.path}/$id');
    } on ServerException catch (e) {
      if (e.statusCode == 409) throw const FavoriteLimitException();
      rethrow;
    }
  }

  @override
  Future<void> remove(FavoriteKind kind, String id) =>
      _client.delete('/api/me/favorites/${kind.path}/$id');
}

/// 웹 mock 의 초기 값(지역 3 · 동네 3)에서 시작하는 메모리 저장소.
/// 쓰기는 앱을 끌 때까지만 남습니다. 로그아웃해도 "서버" 에는 남아 있어 다시 로그인하면 돌아옵니다.
class MockFavoritesRepository implements FavoritesRepository {
  MockFavoritesRepository(this._assets);

  final MockAssets _assets;

  List<FavoriteRegion>? _regions;
  List<FavoriteDong>? _dongs;
  Future<void>? _loading;

  Future<void> _load() => _loading ??= () async {
    final json = await _assets.read(
      'me/favorites.json',
      path: '/api/me/favorites',
    ) as Map<String, dynamic>;
    final all = FavoritesResponse.fromJson(json);
    _regions = [...all.regions];
    _dongs = [...all.dongs];
  }();

  Future<void> _wait() async {
    if (_assets.delay > Duration.zero) {
      await Future<void>.delayed(_assets.delay ~/ 4);
    }
  }

  @override
  Future<FavoritesResponse> list(String month) async {
    await _load();
    return FavoritesResponse(
      month: month,
      regions: [..._regions!],
      dongs: [..._dongs!],
    );
  }

  @override
  Future<FavoriteIds> ids() async {
    await _load();
    return FavoriteIds(
      regions: [for (final r in _regions!) r.id],
      dongs: [for (final d in _dongs!) d.id],
    );
  }

  @override
  Future<void> put(FavoriteKind kind, String id) async {
    await _load();
    await _wait();
    final now = DateTime.now().toIso8601String();
    switch (kind) {
      case FavoriteKind.regions:
        if (_regions!.any((r) => r.id == id)) return;
        if (_regions!.length + _dongs!.length >= favoriteLimit) {
          throw const FavoriteLimitException();
        }
        _regions!.add(await _regionEntry(id, now));
      case FavoriteKind.dongs:
        if (_dongs!.any((d) => d.id == id)) return;
        if (_regions!.length + _dongs!.length >= favoriteLimit) {
          throw const FavoriteLimitException();
        }
        _dongs!.add(await _dongEntry(id, now));
    }
  }

  @override
  Future<void> remove(FavoriteKind kind, String id) async {
    await _load();
    await _wait();
    switch (kind) {
      case FavoriteKind.regions:
        _regions!.removeWhere((r) => r.id == id);
      case FavoriteKind.dongs:
        _dongs!.removeWhere((d) => d.id == id);
    }
  }

  static const _zero = MetricScores(
    quiet: 0,
    crowd: 0,
    peer: 0,
    overnight: 0,
    vibe: 0,
  );

  /// 인기 지역 mock 에서 지역 정보를 가져와 항목을 만듭니다(없으면 빈 항목).
  Future<FavoriteRegion> _regionEntry(String id, String addedAt) async {
    try {
      final json = await _assets.read(
        'regions_popular.json',
        path: '/api/regions/popular',
      ) as Map<String, dynamic>;
      final r = PopularResponse.fromJson(json).items
          .firstWhere((x) => x.id == id);
      return FavoriteRegion(
        id: id,
        name: r.name,
        province: r.province,
        photoUrl: r.photoUrl,
        scores: r.scores,
        tags: r.tags,
        addedAt: addedAt,
      );
    } on Object {
      return FavoriteRegion(
        id: id,
        name: id,
        province: '',
        scores: _zero,
        addedAt: addedAt,
      );
    }
  }

  /// 시군구 상세 mock 의 행정동 목록에서 동 이름 · 성격을 가져옵니다(앞 5자리 = 시군구).
  Future<FavoriteDong> _dongEntry(String id, String addedAt) async {
    final sgg = id.length >= 5 ? id.substring(0, 5) : id;
    try {
      final json = await _assets.read(
        'regions/$sgg.json',
        path: '/api/regions/$sgg',
      ) as Map<String, dynamic>;
      final detail = RegionDetail.fromJson(json);
      final d = detail.dongs.firstWhere((x) => x.id == id);
      return FavoriteDong(
        id: id,
        name: d.name,
        kind: d.kind,
        sigungu: FavoriteSigungu(id: sgg, name: detail.name),
        scores: _zero.copyWith(quiet: d.quietScore),
        addedAt: addedAt,
      );
    } on Object {
      return FavoriteDong(
        id: id,
        name: id,
        kind: DongKind.living,
        sigungu: FavoriteSigungu(id: sgg, name: ''),
        scores: _zero,
        addedAt: addedAt,
      );
    }
  }
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => ApiConfig.useMock
      ? MockFavoritesRepository(ref.watch(mockAssetsProvider))
      : ApiFavoritesRepository(ref.watch(apiClientProvider)),
);
