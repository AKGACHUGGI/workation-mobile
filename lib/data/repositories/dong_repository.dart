import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../models/dong_detail.dart';
import 'mock_assets.dart';

/// 행정동(동네 프로필, M-04).
abstract class DongRepository {
  /// `GET /api/dongs/{id}?month=` — 동네 상세(24시간 곡선 · 지표 · 점수).
  Future<DongDetail> detail(String id, String month);
}

class ApiDongRepository implements DongRepository {
  const ApiDongRepository(this._client);

  final ApiClient _client;

  @override
  Future<DongDetail> detail(String id, String month) async {
    final json = await _client.get('/api/dongs/$id', query: {'month': month});
    return DongDetail.fromJson(json as Map<String, dynamic>);
  }
}

/// `dongs/<id>.json`(2025-10 값)을 어느 달에나 돌려줍니다. 없는 동은 404 입니다.
class MockDongRepository implements DongRepository {
  const MockDongRepository(this._assets);

  final MockAssets _assets;

  @override
  Future<DongDetail> detail(String id, String month) async {
    final json = await _assets.read('dongs/$id.json', path: '/api/dongs/$id');
    return DongDetail.fromJson(json as Map<String, dynamic>)
        .copyWith(month: month);
  }
}

final dongRepositoryProvider = Provider<DongRepository>(
  (ref) => ApiConfig.useMock
      ? MockDongRepository(ref.watch(mockAssetsProvider))
      : ApiDongRepository(ref.watch(apiClientProvider)),
);
