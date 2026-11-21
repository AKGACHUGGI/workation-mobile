import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/data/repositories/community_repository.dart';

/// 팁 2개 · 투표(그래요 3 · 아니요 1)로 시작하는 메모리 가짜. 등록 · 투표가 결과에 반영됩니다.
/// 첫 팁(t1)에는 답글 2개(둘째가 내 답글)가 달려 있습니다.
/// [fail] 이면 모든 호출이 연결 실패를 던집니다. 위젯 테스트에서는 에셋 읽기가 끝나지 않아 씁니다.
///
/// [mineTipIds] 의 팁은 로그인한 사용자가 쓴 것으로 칩니다(`mine`). 등록한 팁도 내 팁입니다.
///
/// [moreTips] 를 주면 첫 쪽이 `nextCursor` 를 달고 오고, 그 커서로 부르면 [moreTips] 를
/// 줍니다([failMoreTips] 면 실패).
class FakeCommunityRepository implements CommunityRepository {
  FakeCommunityRepository({
    this.fail = false,
    bool withPhotos = false,
    this.moreTips,
    this.failMoreTips = false,
    Set<String> mineTipIds = const {},
  }) : _poll = PollResponse(
         yes: 3,
         no: 1,
         total: 4,
         photos: [
           if (withPhotos)
             const UserPhoto(url: 'assets/none.jpg', author: '바다러버'),
         ],
       ) {
    for (final id in mineTipIds) {
      _changeTip(id, (t) => t.copyWith(mine: true));
    }
  }

  bool fail;
  List<Tip>? moreTips;
  bool failMoreTips;

  /// 팁을 읽을 때 받은 커서(순서대로, 첫 쪽은 null)
  final tipCursors = <String?>[];

  /// 등록한 팁 본문 · 방문 월(순서대로)
  final posted = <String>[];
  final postedMonths = <String?>[];

  /// 팁 등록이 이 상태 코드로 실패합니다(null 이면 성공).
  int? postFailStatus;

  /// 투표한 선택(순서대로, 취소는 null)
  final votes = <PollChoice?>[];

  /// 투표를 읽거나 보낼 때 받은 프리셋(순서대로)
  final pollPresets = <PresetKey?>[];

  /// 고친 팁(id · 새 본문) · 지운 팁 id(순서대로)
  final editedTips = <(String, String)>[];
  final deletedTips = <String>[];

  /// 팁 고치기 · 지우기가 연결 실패를 던집니다.
  bool failOwnerActions = false;

  /// 도움돼요 호출(팁 id · 켜기 여부, 순서대로)
  final helpfulCalls = <(String, bool)>[];
  bool failHelpful = false;

  /// 등록한 답글 본문 · 지운 답글 id(순서대로)
  final postedReplies = <String>[];
  final deletedReplies = <String>[];

  /// 답글 쓰기 · 지우기가 이 상태 코드로 실패합니다(null 이면 성공).
  int? replyFailStatus;

  final _replies = <String, List<Reply>>{
    't1': [
      const Reply(
        id: 'r1',
        author: TipAuthor(nickname: '느린오후', initial: '느'),
        createdAt: '2026-11-12T09:00:00+09:00',
        body: '저도 가 봤는데 좋았어요.',
      ),
      const Reply(
        id: 'r2',
        author: TipAuthor(nickname: '두이', initial: '두'),
        createdAt: '2026-11-13T09:00:00+09:00',
        body: '주차는 어디에 하셨나요?',
        mine: true,
      ),
    ],
  };

  var _tips = const TipsResponse(
    total: 2,
    items: [
      Tip(
        id: 't1',
        author: TipAuthor(nickname: '바다러버', initial: '바'),
        createdAt: '2026-11-11T09:00:00+09:00',
        dongName: '거진읍',
        stayLabel: '2주 체류',
        visitMonth: '2025-10',
        body: '거진항 근처 카페는 평일 오전이 한산해요.',
        helpful: 12,
        replies: 2,
      ),
      Tip(
        id: 't2',
        author: TipAuthor(nickname: '도시탈출', initial: '도'),
        createdAt: '2026-10-24T19:00:00+09:00',
        body: '저녁 7시 이후엔 식당이 거의 닫아요.',
        helpful: 5,
      ),
    ],
  );
  PollResponse _poll;

  void _check(CommunityTarget t) {
    if (fail) throw NetworkException('${t.path}/community');
  }

  @override
  Future<TipsResponse> tips(CommunityTarget target, {String? cursor}) async {
    _check(target);
    tipCursors.add(cursor);
    final more = moreTips;
    if (cursor != null) {
      if (failMoreTips) throw NetworkException('${target.path}/notes');
      return TipsResponse(
        total: _tips.total + (more?.length ?? 0),
        items: more ?? const [],
      );
    }
    return more == null
        ? _tips
        : _tips.copyWith(total: _tips.total + more.length, nextCursor: '20');
  }

  @override
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  }) async {
    _check(target);
    final status = postFailStatus;
    if (status != null) throw ServerException('${target.path}/notes', status);
    posted.add(body);
    postedMonths.add(visitMonth);
    final tip = Tip(
      id: 'mine${posted.length}',
      author: TipAuthor(nickname: authorName, initial: authorName[0]),
      createdAt: DateTime.now().toIso8601String(),
      visitMonth: visitMonth,
      body: body,
      mine: true,
    );
    _tips = _tips.copyWith(
      total: _tips.total + 1,
      items: [tip, ..._tips.items],
    );
    return tip;
  }

  @override
  Future<Tip> updateTip(String tipId, {required String body}) async {
    if (fail || failOwnerActions) {
      throw NetworkException('/api/me/tips/$tipId');
    }
    editedTips.add((tipId, body));
    _changeTip(tipId, (t) => t.copyWith(body: body));
    return _tips.items.firstWhere((t) => t.id == tipId);
  }

  @override
  Future<void> deleteTip(String tipId) async {
    if (fail || failOwnerActions) {
      throw NetworkException('/api/me/tips/$tipId');
    }
    deletedTips.add(tipId);
    final left = [
      for (final t in _tips.items)
        if (t.id != tipId) t,
    ];
    _tips = _tips.copyWith(
      total: _tips.total - (_tips.items.length - left.length),
      items: left,
    );
  }

  void _changeTip(String id, Tip Function(Tip) change) {
    _tips = _tips.copyWith(
      items: [for (final t in _tips.items) t.id == id ? change(t) : t],
    );
  }

  @override
  Future<HelpfulResult> setHelpful(String tipId, {required bool on}) async {
    helpfulCalls.add((tipId, on));
    if (fail || failHelpful) {
      throw NetworkException('/api/tips/$tipId/helpful');
    }
    final tip = _tips.items.firstWhere((t) => t.id == tipId);
    final helpful = tip.myHelpful == on
        ? tip.helpful
        : tip.helpful + (on ? 1 : -1);
    _changeTip(tipId, (t) => t.copyWith(helpful: helpful, myHelpful: on));
    return (helpful: helpful, myHelpful: on);
  }

  @override
  Future<List<Reply>> replies(String tipId) async {
    if (fail) throw NetworkException('/api/tips/$tipId/replies');
    return List.of(_replies[tipId] ?? const []);
  }

  @override
  Future<Reply> postReply(
    String tipId, {
    required String body,
    required String authorName,
  }) async {
    final status = replyFailStatus;
    if (status != null) {
      throw ServerException('/api/tips/$tipId/replies', status);
    }
    postedReplies.add(body);
    final reply = Reply(
      id: 'new${postedReplies.length}',
      author: TipAuthor(nickname: authorName, initial: authorName[0]),
      createdAt: DateTime.now().toIso8601String(),
      body: body,
      mine: true,
    );
    (_replies[tipId] ??= []).add(reply);
    return reply;
  }

  @override
  Future<void> deleteReply(String tipId, String replyId) async {
    final status = replyFailStatus;
    if (status != null) {
      throw ServerException('/api/me/replies/$replyId', status);
    }
    deletedReplies.add(replyId);
    _replies[tipId]?.removeWhere((r) => r.id == replyId);
  }

  @override
  Future<PollResponse> poll(
    CommunityTarget target,
    String month, {
    PresetKey? preset,
  }) async {
    _check(target);
    pollPresets.add(preset);
    return _poll;
  }

  @override
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice? choice, {
    PresetKey? preset,
  }) async {
    _check(target);
    votes.add(choice);
    pollPresets.add(preset);
    var yes = _poll.yes;
    var no = _poll.no;
    if (_poll.myVote == PollChoice.yes) yes--;
    if (_poll.myVote == PollChoice.no) no--;
    if (choice == PollChoice.yes) yes++;
    if (choice == PollChoice.no) no++;
    return _poll = PollResponse(
      question: _poll.question,
      yes: yes,
      no: no,
      total: yes + no,
      photos: _poll.photos,
      myVote: choice,
    );
  }
}
