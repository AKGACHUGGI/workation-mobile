import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../models/me.dart';
import 'mock_assets.dart';

/// 내 활동(M-07). 로그인한 사용자에게만 열립니다.
abstract class MeRepository {
  /// `GET /api/me/summary` — 체류 기록 · 가입일 · 활동 수.
  Future<MeSummary> summary();

  /// `GET /api/me/tips`
  Future<MyTipsResponse> tips();

  /// `GET /api/me/photos`
  Future<MyPhotosResponse> photos();

  /// `GET /api/me/settings`
  Future<MeSettings> settings();

  /// `PATCH /api/me/settings` — 바꾼 값만 보내고 합쳐진 설정을 돌려받습니다.
  Future<MeSettings> patchSettings({
    bool? notifyBestMonth,
    bool? notifyTipReaction,
    bool? notifyPhotoSelected,
  });
}

class ApiMeRepository implements MeRepository {
  const ApiMeRepository(this._client);

  final ApiClient _client;

  @override
  Future<MeSummary> summary() async => MeSummary.fromJson(
    await _client.get('/api/me/summary') as Map<String, dynamic>,
  );

  @override
  Future<MyTipsResponse> tips() async => MyTipsResponse.fromJson(
    await _client.get('/api/me/tips') as Map<String, dynamic>,
  );

  @override
  Future<MyPhotosResponse> photos() async => MyPhotosResponse.fromJson(
    await _client.get('/api/me/photos') as Map<String, dynamic>,
  );

  @override
  Future<MeSettings> settings() async => MeSettings.fromJson(
    await _client.get('/api/me/settings') as Map<String, dynamic>,
  );

  @override
  Future<MeSettings> patchSettings({
    bool? notifyBestMonth,
    bool? notifyTipReaction,
    bool? notifyPhotoSelected,
  }) async => MeSettings.fromJson(
    await _client.patch(
      '/api/me/settings',
      body: {
        'notifyBestMonth': ?notifyBestMonth,
        'notifyTipReaction': ?notifyTipReaction,
        'notifyPhotoSelected': ?notifyPhotoSelected,
      },
    ) as Map<String, dynamic>,
  );
}

/// 웹 mock 의 초기 값에서 시작하는 메모리 저장소. 설정 변경은 앱을 끌 때까지 남습니다.
class MockMeRepository implements MeRepository {
  MockMeRepository(this._assets);

  final MockAssets _assets;
  MeSettings? _settings;

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

  @override
  Future<MyTipsResponse> tips() async => MyTipsResponse.fromJson(
    await _assets.read('me/tips.json', path: '/api/me/tips')
        as Map<String, dynamic>,
  );

  @override
  Future<MyPhotosResponse> photos() async => MyPhotosResponse.fromJson(
    await _assets.read('me/photos.json', path: '/api/me/photos')
        as Map<String, dynamic>,
  );

  @override
  Future<MeSettings> settings() async => _settings ??= MeSettings.fromJson(
    await _assets.read('me/settings.json', path: '/api/me/settings')
        as Map<String, dynamic>,
  );

  @override
  Future<MeSettings> patchSettings({
    bool? notifyBestMonth,
    bool? notifyTipReaction,
    bool? notifyPhotoSelected,
  }) async {
    final current = await settings();
    if (_assets.delay > Duration.zero) {
      await Future<void>.delayed(_assets.delay ~/ 4);
    }
    return _settings = current.copyWith(
      notifyBestMonth: notifyBestMonth ?? current.notifyBestMonth,
      notifyTipReaction: notifyTipReaction ?? current.notifyTipReaction,
      notifyPhotoSelected: notifyPhotoSelected ?? current.notifyPhotoSelected,
    );
  }
}

final meRepositoryProvider = Provider<MeRepository>(
  (ref) => ApiConfig.useMock
      ? MockMeRepository(ref.watch(mockAssetsProvider))
      : ApiMeRepository(ref.watch(apiClientProvider)),
);
