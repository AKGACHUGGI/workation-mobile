import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/metric.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/network/api_exception.dart';
import '../models/community.dart';
import 'mock_assets.dart';

/// 커뮤니티: 한 줄 팁 · 도움돼요 · 답글 · 체감 투표 · 이달의 사진(투표 응답에 함께 옵니다).
/// 경로와 본문은 웹 · 서버(`webapi/tips.py` · `webapi/poll.py`)와 같습니다.
abstract class CommunityRepository {
  /// `GET {target}/notes?sort=helpful` — 한 쪽에 20개. [cursor] 는 앞 응답의
  /// `nextCursor` 를 그대로 넘깁니다(없으면 첫 쪽).
  Future<TipsResponse> tips(CommunityTarget target, {String? cursor});

  /// `POST {target}/notes` — 본문 `{body, visitMonth?}`. 만든 팁을 돌려줍니다.
  /// [authorName] 은 mock 이 작성자 표시에 씁니다(실제 API 는 세션으로 압니다).
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  });

  /// `PATCH /api/me/tips/{id}` — 본문 `{body}`. 내 팁의 본문만 고치고, 고친 팁을 돌려줍니다
  /// (사진 · 방문 월은 그대로). 내 팁이 아니면 404.
  Future<Tip> updateTip(String tipId, {required String body});

  /// `DELETE /api/me/tips/{id}` — 내 팁을 지웁니다(MY 의 삭제와 같은 경로). 붙인 사진 ·
  /// 답글도 함께 지워집니다. 내 팁이 아니면 404.
  Future<void> deleteTip(String tipId);

  /// `PUT`([on]) · `DELETE /api/tips/{id}/helpful` — 바뀐 수와 내 상태를 돌려줍니다.
  /// 여러 번 불러도 결과가 같습니다. 내 팁이면 400 `OWN_TIP`.
  Future<HelpfulResult> setHelpful(String tipId, {required bool on});

  /// `GET /api/tips/{id}/replies` — 공개 답글, 오래된 순.
  Future<List<Reply>> replies(String tipId);

  /// `POST /api/tips/{id}/replies` — 본문 `{body}`(300자). 만든 답글을 돌려줍니다.
  /// 1분에 5개를 넘으면 429 `REPLY_RATE_LIMIT`.
  Future<Reply> postReply(
    String tipId, {
    required String body,
    required String authorName,
  });

  /// `DELETE /api/me/replies/{id}` — 내 답글만 지웁니다.
  Future<void> deleteReply(String tipId, String replyId);

  /// `GET {target}/poll?month=&preset=` — 결과 · 내 선택 · 이달의 사진.
  /// [preset] 은 지역에만 보냅니다(동네는 프리셋이 없습니다).
  Future<PollResponse> poll(
    CommunityTarget target,
    String month, {
    PresetKey? preset,
  });

  /// `POST {target}/poll/vote` — 본문 `{month, preset?, choice}`. 대상 · 달 · 프리셋마다
  /// 한 표이고, 이미 골랐으면 바꿉니다. [choice] 가 null 이면 취소합니다.
  /// 바뀐 결과를 돌려줍니다.
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice? choice, {
    PresetKey? preset,
  });
}

/// 지역만 프리셋을 보냅니다. 동네에 보내도 서버는 무시하지만 웹과 같게 뺍니다.
String? _presetOf(CommunityTarget target, PresetKey? preset) =>
    target.isDong ? null : (preset ?? PresetKey.quiet).name;

class ApiCommunityRepository implements CommunityRepository {
  const ApiCommunityRepository(this._client);

  final ApiClient _client;

  @override
  Future<TipsResponse> tips(CommunityTarget target, {String? cursor}) async {
    final json = await _client.get(
      '${target.path}/notes',
      query: {'sort': 'helpful', 'cursor': ?cursor},
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
  Future<Tip> updateTip(String tipId, {required String body}) async {
    final json = await _client.patch(
      '/api/me/tips/$tipId',
      body: {'body': body},
    );
    return Tip.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTip(String tipId) => _client.delete('/api/me/tips/$tipId');

  @override
  Future<HelpfulResult> setHelpful(String tipId, {required bool on}) async {
    final path = '/api/tips/$tipId/helpful';
    final json =
        await (on ? _client.put(path) : _client.delete(path))
            as Map<String, dynamic>;
    return (
      helpful: (json['helpful'] as num).toInt(),
      myHelpful: json['myHelpful'] as bool? ?? on,
    );
  }

  @override
  Future<List<Reply>> replies(String tipId) async {
    final json =
        await _client.get('/api/tips/$tipId/replies') as Map<String, dynamic>;
    return [
      for (final item in json['items'] as List? ?? const [])
        Reply.fromJson(item as Map<String, dynamic>),
    ];
  }

  @override
  Future<Reply> postReply(
    String tipId, {
    required String body,
    required String authorName,
  }) async {
    final json = await _client.post(
      '/api/tips/$tipId/replies',
      body: {'body': body},
    );
    return Reply.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<void> deleteReply(String tipId, String replyId) =>
      _client.delete('/api/me/replies/$replyId');

  @override
  Future<PollResponse> poll(
    CommunityTarget target,
    String month, {
    PresetKey? preset,
  }) async {
    final json = await _client.get(
      '${target.path}/poll',
      query: {'month': month, 'preset': ?_presetOf(target, preset)},
    );
    return PollResponse.fromJson(json as Map<String, dynamic>);
  }

  @override
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice? choice, {
    PresetKey? preset,
  }) async {
    final json = await _client.post(
      '${target.path}/poll/vote',
      body: {
        'month': month,
        'preset': ?_presetOf(target, preset),
        // 취소는 null 을 그대로 보냅니다(키를 빼면 400).
        'choice': choice?.name,
      },
    );
    return PollResponse.fromJson(json as Map<String, dynamic>);
  }
}

/// 팁(쓰기 · 고치기 · 지우기) · 도움돼요 · 답글 · 투표를 메모리에 씁니다(앱을 다시 켜면 처음으로 돌아갑니다).
/// 샘플은 `assets/mock/community/` 의 지역 51820 · 동 5182025300 · 5115025000 뿐이고
/// 그 밖의 대상은 팁 · 투표가 비어 있다가 사용자가 쓰는 만큼 채워집니다.
/// 답글 샘플은 파일이 없어, 팁의 답글 수만큼 [_sampleReplies] 에서 돌려 씁니다.
class MockCommunityRepository implements CommunityRepository {
  MockCommunityRepository(this._assets);

  final MockAssets _assets;

  final _tips = <CommunityTarget, TipsResponse>{};
  final _replies = <String, List<Reply>>{};
  final _polls = <(CommunityTarget, String, String?), PollResponse>{};
  var _nextId = 1;

  static const _sampleReplies = [
    ('느린오후', '저도 지난달에 가 봤는데 정말 그랬어요.'),
    ('한달살이킴', '좋은 정보 고마워요. 다음 주에 가 보려고요.'),
    ('도시탈출', '주말에는 조금 붐비니 평일을 추천해요.'),
    ('바다러버', '근처에 주차할 곳도 넉넉했어요.'),
  ];

  String _file(String kind, CommunityTarget t) =>
      'community/${kind}_${t.id}.json';

  TipAuthor _author(String name) => TipAuthor(
    nickname: name,
    initial: name.isEmpty ? '?' : String.fromCharCode(name.runes.first),
  );

  /// 읽어 둔 목록에서 팁을 찾습니다. 없으면 null.
  Tip? _find(String tipId) {
    for (final res in _tips.values) {
      for (final tip in res.items) {
        if (tip.id == tipId) return tip;
      }
    }
    return null;
  }

  /// 읽어 둔 모든 목록에서 그 팁을 바꿉니다.
  void _update(String tipId, Tip Function(Tip) change) {
    for (final entry in _tips.entries.toList()) {
      _tips[entry.key] = entry.value.copyWith(
        items: [
          for (final tip in entry.value.items)
            tip.id == tipId ? change(tip) : tip,
        ],
      );
    }
  }

  // mock 은 한 쪽에 다 들어 있습니다.
  @override
  Future<TipsResponse> tips(CommunityTarget target, {String? cursor}) async {
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
      author: _author(authorName),
      createdAt: DateTime.now().toIso8601String(),
      visitMonth: visitMonth,
      body: body,
      mine: true,
    );
    _tips[target] = current.copyWith(
      total: current.total + 1,
      items: [tip, ...current.items],
    );
    return tip;
  }

  /// 내 팁이면 돌려주고, 없거나 남의 팁이면 서버처럼 404 를 던집니다.
  Tip _mine(String tipId) {
    final tip = _find(tipId);
    if (tip == null || !tip.mine) {
      throw NotFoundException('/api/me/tips/$tipId');
    }
    return tip;
  }

  @override
  Future<Tip> updateTip(String tipId, {required String body}) async {
    final updated = _mine(tipId).copyWith(body: body);
    _update(tipId, (_) => updated);
    return updated;
  }

  @override
  Future<void> deleteTip(String tipId) async {
    _mine(tipId);
    for (final entry in _tips.entries.toList()) {
      final left = [
        for (final tip in entry.value.items)
          if (tip.id != tipId) tip,
      ];
      if (left.length == entry.value.items.length) continue;
      _tips[entry.key] = entry.value.copyWith(
        total: entry.value.total - 1,
        items: left,
      );
    }
    _replies.remove(tipId);
  }

  @override
  Future<HelpfulResult> setHelpful(String tipId, {required bool on}) async {
    final tip = _find(tipId);
    if (tip == null) throw NotFoundException('/api/tips/$tipId/helpful');
    if (tip.mine && on) {
      throw ServerException('/api/tips/$tipId/helpful', 400);
    }
    final helpful = tip.myHelpful == on
        ? tip.helpful
        : tip.helpful + (on ? 1 : -1);
    _update(tipId, (t) => t.copyWith(helpful: helpful, myHelpful: on));
    return (helpful: helpful, myHelpful: on);
  }

  List<Reply> _repliesOf(String tipId) {
    final cached = _replies[tipId];
    if (cached != null) return cached;
    final tip = _find(tipId);
    // 팁을 쓴 사람이 자기 팁에 답한 것처럼 보이지 않게 뺍니다.
    final pool = [
      for (final s in _sampleReplies)
        if (s.$1 != tip?.author.nickname) s,
    ];
    final count = tip?.replies ?? 0;
    return _replies[tipId] = [
      // 오래된 순
      for (var i = 0; i < count; i++)
        Reply(
          id: '${tipId}_r$i',
          author: _author(pool[i % pool.length].$1),
          createdAt: DateTime.now()
              .subtract(Duration(days: 2 + count - i))
              .toIso8601String(),
          body: pool[i % pool.length].$2,
        ),
    ];
  }

  @override
  Future<List<Reply>> replies(String tipId) async =>
      List.unmodifiable(_repliesOf(tipId));

  @override
  Future<Reply> postReply(
    String tipId, {
    required String body,
    required String authorName,
  }) async {
    final list = _repliesOf(tipId);
    final reply = Reply(
      id: 'myreply_${_nextId++}',
      author: _author(authorName),
      createdAt: DateTime.now().toIso8601String(),
      body: body,
      mine: true,
    );
    list.add(reply);
    _update(tipId, (t) => t.copyWith(replies: list.length));
    return reply;
  }

  @override
  Future<void> deleteReply(String tipId, String replyId) async {
    final list = _repliesOf(tipId);
    final before = list.length;
    list.removeWhere((r) => r.id == replyId && r.mine);
    if (list.length == before) {
      throw NotFoundException('/api/me/replies/$replyId');
    }
    _update(tipId, (t) => t.copyWith(replies: list.length));
  }

  @override
  Future<PollResponse> poll(
    CommunityTarget target,
    String month, {
    PresetKey? preset,
  }) async {
    final key = (target, month, _presetOf(target, preset));
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
    PollChoice? choice, {
    PresetKey? preset,
  }) async {
    final current = await poll(target, month, preset: preset);
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
    switch (choice) {
      case PollChoice.yes:
        yes++;
      case PollChoice.no:
        no++;
      case null:
        break;
    }
    // copyWith 로는 myVote 를 null 로 되돌릴 수 없어 새로 만듭니다.
    return _polls[(target, month, _presetOf(target, preset))] = PollResponse(
      question: current.question,
      yes: yes,
      no: no,
      total: yes + no,
      photos: current.photos,
      myVote: choice,
    );
  }
}

final communityRepositoryProvider = Provider<CommunityRepository>(
  (ref) => ApiConfig.useMock
      ? MockCommunityRepository(ref.watch(mockAssetsProvider))
      : ApiCommunityRepository(ref.watch(apiClientProvider)),
);
