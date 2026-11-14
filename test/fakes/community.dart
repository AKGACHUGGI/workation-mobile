import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/data/repositories/community_repository.dart';

/// 팁 2개 · 투표(그래요 3 · 아니요 1)로 시작하는 메모리 가짜. 등록 · 투표가 결과에 반영됩니다.
/// [fail] 이면 모든 호출이 연결 실패를 던집니다. 위젯 테스트에서는 에셋 읽기가 끝나지 않아 씁니다.
class FakeCommunityRepository implements CommunityRepository {
  FakeCommunityRepository({this.fail = false, bool withPhotos = false})
    : _poll = PollResponse(
        yes: 3,
        no: 1,
        total: 4,
        photos: [
          if (withPhotos)
            const UserPhoto(url: 'assets/none.jpg', author: '바다러버'),
        ],
      );

  bool fail;

  /// 등록한 팁 본문(순서대로)
  final posted = <String>[];

  /// 투표한 선택(순서대로)
  final votes = <PollChoice>[];

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
  Future<TipsResponse> tips(CommunityTarget target) async {
    _check(target);
    return _tips;
  }

  @override
  Future<Tip> postTip(
    CommunityTarget target, {
    required String body,
    required String authorName,
    String? visitMonth,
  }) async {
    _check(target);
    posted.add(body);
    final tip = Tip(
      id: 'mine${posted.length}',
      author: TipAuthor(nickname: authorName, initial: authorName[0]),
      createdAt: DateTime.now().toIso8601String(),
      visitMonth: visitMonth,
      body: body,
    );
    _tips = _tips.copyWith(
      total: _tips.total + 1,
      items: [tip, ..._tips.items],
    );
    return tip;
  }

  @override
  Future<PollResponse> poll(CommunityTarget target, String month) async {
    _check(target);
    return _poll;
  }

  @override
  Future<PollResponse> vote(
    CommunityTarget target,
    String month,
    PollChoice choice,
  ) async {
    _check(target);
    votes.add(choice);
    var yes = _poll.yes;
    var no = _poll.no;
    if (_poll.myVote == PollChoice.yes) yes--;
    if (_poll.myVote == PollChoice.no) no--;
    choice == PollChoice.yes ? yes++ : no++;
    return _poll = _poll.copyWith(
      yes: yes,
      no: no,
      total: yes + no,
      myVote: choice,
    );
  }
}
