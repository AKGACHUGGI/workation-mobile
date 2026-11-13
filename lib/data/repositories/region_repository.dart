import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../models/popular_region.dart';
import 'mock_assets.dart';

/// 지역(시군구) 데이터.
abstract class RegionRepository {
  /// `GET /api/regions/popular?month=` — 인기 지역 12곳(정렬 없음).
  Future<PopularResponse> popular(String month);
}

class ApiRegionRepository implements RegionRepository {
  const ApiRegionRepository(this._client);

  final ApiClient _client;

  @override
  Future<PopularResponse> popular(String month) async {
    final json = await _client.get(
      '/api/regions/popular',
      query: {'month': month},
    );
    return PopularResponse.fromJson(json as Map<String, dynamic>);
  }
}

/// 10월 수치(웹 mock 과 같은 값)를 어느 달에나 돌려줍니다.
class MockRegionRepository implements RegionRepository {
  const MockRegionRepository(this._assets);

  final MockAssets _assets;

  @override
  Future<PopularResponse> popular(String month) async {
    final json = await _assets.read(
      'regions_popular.json',
      path: '/api/regions/popular',
    );
    return PopularResponse.fromJson(json as Map<String, dynamic>)
        .copyWith(month: month);
  }
}

final regionRepositoryProvider = Provider<RegionRepository>(
  (ref) => ApiConfig.useMock
      ? MockRegionRepository(ref.watch(mockAssetsProvider))
      : ApiRegionRepository(ref.watch(apiClientProvider)),
);
