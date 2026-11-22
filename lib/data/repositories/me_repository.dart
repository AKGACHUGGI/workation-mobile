import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/me.dart';
import 'mock_assets.dart';

/// 내 활동(M-07). 로그인한 사용자에게만 열립니다.
abstract class MeRepository {
  /// `GET /api/me/summary` — 체류 기록 · 가입일 · 활동 수.
  Future<MeSummary> summary();

  /// `GET /api/me/tips` — 한 쪽에 20개. [cursor] 는 앞 응답의 `nextCursor` 를
  /// 그대로 넘깁니다(없으면 첫 쪽). `helpfulSum` 은 어느 쪽에서나 전체 합계입니다.
  Future<MyTipsResponse> tips({String? cursor});

  /// `DELETE /api/me/tips/{id}` — 204. 내 팁이 아니면 404(`NotFoundException`).
  Future<void> deleteTip(String id);

  /// `GET /api/me/photos` — 내가 올린 이달의 사진(팁에 붙인 사진은 빼고), 최근 것부터.
  Future<MyPhotosResponse> photos();

  /// `DELETE /api/me/photos/{id}` — 204. 내 이달의 사진이 아니면 404(`NotFoundException`).
  Future<void> deletePhoto(String id);
}

class ApiMeRepository implements MeRepository {
  const ApiMeRepository(this._client);

  final ApiClient _client;

  @override
  Future<MeSummary> summary() async => MeSummary.fromJson(
    await _client.get('/api/me/summary') as Map<String, dynamic>,
  );

  @override
  Future<MyTipsResponse> tips({String? cursor}) async =>
      MyTipsResponse.fromJson(
        await _client.get('/api/me/tips', query: {'cursor': ?cursor})
            as Map<String, dynamic>,
      );

  @override
  Future<void> deleteTip(String id) async {
    await _client.delete('/api/me/tips/$id');
  }

  @override
  Future<MyPhotosResponse> photos() async => MyPhotosResponse.fromJson(
    await _client.get('/api/me/photos') as Map<String, dynamic>,
  );

  @override
  Future<void> deletePhoto(String id) async {
    await _client.delete('/api/me/photos/$id');
  }
}

/// 웹 mock 의 초기 값에서 시작하는 메모리 저장소. 지운 팁 · 사진은 앱을 끌 때까지 빠져 있습니다.
class MockMeRepository implements MeRepository {
  MockMeRepository(this._assets);

  final MockAssets _assets;
  final _deletedTips = <String>{};
  final _deletedPhotos = <String>{};

  @override
  Future<MeSummary> summary() async {
    final tips = await this.tips();
    final photos = await this.photos();
    final json = await _assets.read(
      'me/summary.json',
      path: '/api/me/summary',
    ) as Map<String, dynamic>;
    // 웹 mock 과 같이 팁 · 사진 수는 목록 길이를 따릅니다.
    return MeSummary.fromJson(json)
        .copyWith(tipCount: tips.items.length, photoCount: photos.items.length);
  }

  // mock 은 한 쪽에 다 들어 있습니다. 지운 팁은 앱을 끌 때까지 빠집니다.
  @override
  Future<MyTipsResponse> tips({String? cursor}) async {
    final all = MyTipsResponse.fromJson(
      await _assets.read('me/tips.json', path: '/api/me/tips')
          as Map<String, dynamic>,
    );
    final items = [
      for (final t in all.items)
        if (!_deletedTips.contains(t.id)) t,
    ];
    // 서버처럼 합계는 남은 팁 기준입니다.
    return all.copyWith(
      items: items,
      helpfulSum: items.fold(0, (sum, t) => sum + t.helpful),
    );
  }

  @override
  Future<void> deleteTip(String id) async {
    final mine = await tips();
    if (!mine.items.any((t) => t.id == id)) {
      throw NotFoundException('/api/me/tips/$id');
    }
    _deletedTips.add(id);
  }

  @override
  Future<MyPhotosResponse> photos() async {
    final all = MyPhotosResponse.fromJson(
      await _assets.read('me/photos.json', path: '/api/me/photos')
          as Map<String, dynamic>,
    );
    return all.copyWith(
      items: [
        for (final p in all.items)
          if (!_deletedPhotos.contains(p.id)) p,
      ],
    );
  }

  @override
  Future<void> deletePhoto(String id) async {
    final mine = await photos();
    if (!mine.items.any((p) => p.id == id)) {
      throw NotFoundException('/api/me/photos/$id');
    }
    _deletedPhotos.add(id);
  }
}

final meRepositoryProvider = Provider<MeRepository>(
  (ref) => ApiConfig.useMock
      ? MockMeRepository(ref.watch(mockAssetsProvider))
      : ApiMeRepository(ref.watch(apiClientProvider)),
);
