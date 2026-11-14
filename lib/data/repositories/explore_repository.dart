import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../models/explore.dart';
import 'mock_assets.dart';

/// 지도 탐색(M-02 v3 · M-04 v3 유형 카드). 경로에 `/v1` 이 없습니다.
abstract class ExploreRepository {
  /// `GET /api/explore/sigungu/{id}/pins` — 시군구의 행정동 핀 목록.
  Future<PinsResponse> pins(String sigunguId);

  /// `GET /api/explore/dongs/{id}` — 동 요약(유형 4종 · 브리핑).
  Future<ExploreDong> dong(String dongId);
}

class ApiExploreRepository implements ExploreRepository {
  const ApiExploreRepository(this._client);

  final ApiClient _client;

  @override
  Future<PinsResponse> pins(String sigunguId) async {
    final json = await _client.get('/api/explore/sigungu/$sigunguId/pins');
    return PinsResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<ExploreDong> dong(String dongId) async {
    final json = await _client.get('/api/explore/dongs/$dongId');
    return ExploreDong.fromJson(json as Map<String, dynamic>);
  }
}

/// mock 은 강릉시(51150) 핀과 주문진읍(5115025000) 요약만 있습니다. 그 밖은 404 입니다.
class MockExploreRepository implements ExploreRepository {
  const MockExploreRepository(this._assets);

  final MockAssets _assets;

  @override
  Future<PinsResponse> pins(String sigunguId) async {
    final json = await _assets.read(
      'explore/pins_$sigunguId.json',
      path: '/api/explore/sigungu/$sigunguId/pins',
    );
    return PinsResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<ExploreDong> dong(String dongId) async {
    final json = await _assets.read(
      'explore/dong_$dongId.json',
      path: '/api/explore/dongs/$dongId',
    );
    return ExploreDong.fromJson(json as Map<String, dynamic>);
  }
}

final exploreRepositoryProvider = Provider<ExploreRepository>(
  (ref) => ApiConfig.useMock
      ? MockExploreRepository(ref.watch(mockAssetsProvider))
      : ApiExploreRepository(ref.watch(apiClientProvider)),
);
