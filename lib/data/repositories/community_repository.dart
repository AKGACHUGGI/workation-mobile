import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/community.dart';
import 'mock_assets.dart';

/// 커뮤니티: 한 줄 팁 · 체감 투표 · 이달의 사진(투표 응답에 함께 옵니다).
/// 읽기 경로는 웹과 같고, 쓰기 경로(`POST`)는 백엔드 명세 전이라 앱이 정했습니다.
abstract class CommunityRepository {
  /// `GET {target}/notes?sort=helpful`
  Future<TipsResponse> tips(CommunityTarget target);

  /// `POST {target}/notes` — 본문 `{body, visitMonth?}`. 만든 팁을 돌려줍니다.
  /// [authorName] 은 mock 이 작성자 표시에 씁니다(실제 API 는 세션으로 압니다).
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  });

  /// `GET {target}/poll?month=` — 결과 · 내 선택 · 이달의 사진.
  Future<PollResponse> poll(CommunityTarget target, String month);

  /// `PUT {target}/poll/vote` — 본문 `{month, choice}`. 이미 골랐으면 바꿉니다.
  /// 바뀐 결과를 돌려줍니다.
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice choice,
  );
}

class ApiCommunityRepository implements CommunityRepository {
  const ApiCommunityRepository(this._client);

  final ApiClient _client;

  @override
  Future<TipsResponse> tips(CommunityTarget target) async {
    final json = await _client.get(
      '${target.path}/notes',
      query: {'sort': 'helpful'},
    );
    return TipsResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  }) async {
    final json = await _client.post(
      '${target.path}/notes',
      body: {'body': body, 'visitMonth': ?visitMonth},
    );
    return Tip.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<PollResponse> poll(CommunityTarget target, String month) async {
    final json = await _client.get(
      '${target.path}/poll',
      query: {'month': month},
    );
    return PollResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice choice,
  ) async {
    final json = await _client.put(
      '${target.path}/poll/vote',
      body: {'month': month, 'choice': choice.name},
    );
    return PollResponse.fromJson(json as Map<String, dynamic>);
  }
}

/// 팁 · 투표를 메모리에 씁니다(앱을 다시 켜면 처음으로 돌아갑니다).
/// 샘플은 `assets/mock/community/` 의 지역 51820 · 동 5182025300 · 5115025000 뿐이고
/// 그 밖의 대상은 팁 · 투표가 비어 있다가 사용자가 쓰는 만큼 채워집니다.
class MockCommunityRepository implements CommunityRepository {
  MockCommunityRepository(this._assets);

  final MockAssets _assets;

  final _tips = <CommunityTarget, TipsResponse>{};
  final _polls = <(CommunityTarget, String), PollResponse>{};
  var _nextId = 1;

  String _file(String kind, CommunityTarget t) =>
      'community/${kind}_${t.id}.json';

  @override
  Future<TipsResponse> tips(CommunityTarget target) async {
    final cached = _tips[target];
    if (cached != null) return cached;
    TipsResponse res;
    try {
      final json = await _assets.read(
        _file('notes', target),
        path: '${target.path}/notes',
      );
      res = TipsResponse.fromJson(json as Map<String, dynamic>);
    } on NotFoundException {
      res = const TipsResponse(total: 0);
    }
    return _tips[target] ??= res;
  }

  @override
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  }) async {
    final current = await tips(target);
    final tip = Tip(
      id: 'mine_${_nextId++}',
      author: TipAuthor(
        nickname: authorName,
        initial: authorName.isEmpty
            ? '?'
            : String.fromCharCode(authorName.runes.first),
      ),
      createdAt: DateTime.now().toIso8601String(),
      visitMonth: visitMonth,
      body: body,
    );
    _tips[target] = current.copyWith(
      total: current.total + 1,
      items: [tip, ...current.items],
    );
    return tip;
  }

  @override
  Future<PollResponse> poll(CommunityTarget target, String month) async {
    final key = (target, month);
    final cached = _polls[key];
    if (cached != null) return cached;
    PollResponse res;
    try {
      final json = await _assets.read(
        _file('poll', target),
        path: '${target.path}/poll',
      );
      res = PollResponse.fromJson(json as Map<String, dynamic>);
    } on NotFoundException {
      res = const PollResponse(yes: 0, no: 0, total: 0);
    }
    return _polls[key] ??= res;
  }

  @override
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice choice,
  ) async {
    final current = await poll(target, month);
    if (current.myVote == choice) return current;
    var yes = current.yes;
    var no = current.no;
    switch (current.myVote) {
      case PollChoice.yes:
        yes--;
      case PollChoice.no:
        no--;
      case null:
        break;
    }
    if (choice == PollChoice.yes) {
      yes++;
    } else {
      no++;
    }
    return _polls[(target, month)] = current.copyWith(
      yes: yes,
      no: no,
      total: yes + no,
      myVote: choice,
    );
  }
}

final communityRepositoryProvider = Provider<CommunityRepository>(
  (ref) => ApiConfig.useMock
      ? MockCommunityRepository(ref.watch(mockAssetsProvider))
      : ApiCommunityRepository(ref.watch(apiClientProvider)),
);
