import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/core/network/api_client.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/photo/photo_picker.dart';
import 'package:workation_mobile/data/models/community.dart';
import 'package:workation_mobile/data/models/dong_detail.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/community_repository.dart';
import 'package:workation_mobile/data/repositories/dong_repository.dart';
import 'package:workation_mobile/data/repositories/mock_assets.dart';

/// 호출한 경로 · 본문을 기록하고 정해 둔 응답을 돌려주는 ApiClient.
class _RecordingClient extends ApiClient {
  _RecordingClient(this.reply) : super(Dio());

  final dynamic reply;
  final calls = <String>[];
  Object? lastBody;
  Map<String, Object?>? lastQuery;

  /// 마지막 multipart 요청의 글자 칸 · 파일 칸 이름 · 파일 이름
  Map<String, String>? lastFields;
  String? lastFileField;
  List<String>? lastFiles;

  @override
  Future<dynamic> postMultipart(
    String path, {
    Map<String, String> fields = const {},
    required String fileField,
    required List<UploadFile> files,
  }) async {
    calls.add('MULTIPART $path');
    lastFields = fields;
    lastFileField = fileField;
    lastFiles = [for (final f in files) f.filename];
    return reply;
  }

  @override
  Future<dynamic> get(String path, {Map<String, Object?>? query}) async {
    calls.add('GET $path');
    lastQuery = query;
    return reply;
  }

  @override
  Future<dynamic> post(String path, {Object? body}) async {
    calls.add('POST $path');
    lastBody = body;
    return reply;
  }

  @override
  Future<dynamic> put(String path, {Object? body}) async {
    calls.add('PUT $path');
    lastBody = body;
    return reply;
  }

  @override
  Future<dynamic> patch(String path, {Object? body}) async {
    calls.add('PATCH $path');
    lastBody = body;
    return reply;
  }

  @override
  Future<dynamic> delete(String path) async {
    calls.add('DELETE $path');
    return reply;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final assets = MockAssets(rootBundle, delay: Duration.zero);
  const region = CommunityTarget.region('51820');
  const jumunjin = CommunityTarget.dong('5115025000');

  group('MockCommunityRepository', () {
    test('샘플 팁 · 투표를 읽는다', () async {
      final repo = MockCommunityRepository(assets);

      final tips = await repo.tips(region);
      expect(tips.total, 23);
      expect(tips.items.map((t) => t.author.nickname), [
        '바다러버',
        '한달살이킴',
        '원격근무러',
      ]);

      final poll = await repo.poll(region, '2025-10');
      expect(poll.total, 124);
      expect(poll.yesPercent, 73);
      expect(poll.noPercent, 27);
      expect(poll.photos, hasLength(3));
      // 사진을 붙인 샘플 팁이 있다(최대 3장).
      final withPhotos = tips.items.where((t) => t.photos.isNotEmpty);
      expect(withPhotos, isNotEmpty);
      expect(withPhotos.every((t) => t.photos.length <= 3), isTrue);
      expect(poll.myVote, isNull);
    });

    test('샘플이 없는 대상은 비어 있다', () async {
      final repo = MockCommunityRepository(assets);
      const other = CommunityTarget.dong('5182025000');

      expect((await repo.tips(other)).total, 0);
      final poll = await repo.poll(other, '2025-10');
      expect(poll.total, 0);
      expect(poll.yesPercent, 0);
      expect(poll.noPercent, 0);
    });

    test('등록한 팁은 맨 위에 쌓이고 작성자 이름을 쓴다', () async {
      final repo = MockCommunityRepository(assets);

      final tip = await repo.postTip(
        jumunjin,
        body: '새벽 산책이 좋아요',
        authorName: '두이',
        visitMonth: '2025-10',
      );

      expect(tip.author.initial, '두');
      final tips = await repo.tips(jumunjin);
      expect(tips.total, 10);
      expect(tips.items.first.body, '새벽 산책이 좋아요');
      expect(tips.items.first.visitMonth, '2025-10');
      expect(tips.items, hasLength(3));
      // 다른 대상은 영향이 없다
      expect((await repo.tips(region)).total, 23);
    });

    test('올린 이달의 사진은 그 달 투표 응답 맨 앞에 보이고 프리셋 · 투표와 상관없다', () async {
      final repo = MockCommunityRepository(assets);
      const picked = [
        PickedPhoto(path: '/tmp/a.jpg', name: 'a.jpg', bytes: 1),
        PickedPhoto(path: '/tmp/b.jpg', name: 'b.jpg', bytes: 1),
      ];
      final before = await repo.poll(region, '2025-10');

      await repo.uploadMonthPhotos(
        region,
        '2025-10',
        photos: picked,
        authorName: '두이',
      );
      final after = await repo.poll(region, '2025-10');
      expect(after.photos, hasLength(before.photos.length + 2));
      expect(after.photos.take(2).map((p) => p.url), [
        '/tmp/a.jpg',
        '/tmp/b.jpg',
      ]);
      expect(after.photos.first.author, '두이');
      expect(
        (await repo.poll(region, '2025-10', preset: PresetKey.lively)).photos,
        hasLength(before.photos.length + 2),
      );
      // 다른 달 · 다른 대상에는 보이지 않는다.
      expect((await repo.poll(region, '2025-09')).photos, before.photos);
      expect(
        (await repo.poll(
          jumunjin,
          '2025-10',
        )).photos.any((p) => p.author == '두이'),
        isFalse,
      );

      // 투표해도 올린 사진이 그대로 따라온다.
      final voted = await repo.vote(region, '2025-10', PollChoice.yes);
      expect(voted.photos, hasLength(before.photos.length + 2));
      expect(voted.yes, before.yes + 1);

      // 1~3장만 받는다.
      await expectLater(
        repo.uploadMonthPhotos(
          region,
          '2025-10',
          photos: const [],
          authorName: '두이',
        ),
        throwsA(isA<ServerException>()),
      );
    });

    test('사진을 붙여 등록한 팁은 그 사진을 순서대로 갖는다', () async {
      final repo = MockCommunityRepository(assets);
      final tip = await repo.postTip(
        region,
        body: '사진 팁',
        authorName: '두이',
        photos: const [
          PickedPhoto(path: '/tmp/a.jpg', name: 'a.jpg', bytes: 1),
          PickedPhoto(path: '/tmp/b.jpg', name: 'b.jpg', bytes: 1),
        ],
      );
      expect(tip.photos.map((p) => p.url), ['/tmp/a.jpg', '/tmp/b.jpg']);
      expect(tip.photos.map((p) => p.id).toSet(), hasLength(2));
      expect((await repo.tips(region)).items.first.photos, hasLength(2));
    });

    test('내 팁은 고치고 지울 수 있고, 남의 팁은 404 다', () async {
      final repo = MockCommunityRepository(assets);
      final mine = await repo.postTip(region, body: '처음 본문', authorName: '두이');
      final before = await repo.tips(region);

      final updated = await repo.updateTip(mine.id, body: '고친 본문');
      expect(updated.body, '고친 본문');
      expect(updated.id, mine.id);
      expect((await repo.tips(region)).items.first.body, '고친 본문');
      expect((await repo.tips(region)).total, before.total);

      // 샘플 팁(n1)은 남의 팁이다.
      await expectLater(
        repo.updateTip('n1', body: '남의 팁'),
        throwsA(isA<NotFoundException>()),
      );
      await expectLater(
        repo.deleteTip('n1'),
        throwsA(isA<NotFoundException>()),
      );
      await expectLater(
        repo.deleteTip('없는팁'),
        throwsA(isA<NotFoundException>()),
      );

      await repo.deleteTip(mine.id);
      final after = await repo.tips(region);
      expect(after.total, before.total - 1);
      expect(after.items.any((t) => t.id == mine.id), isFalse);
      await expectLater(
        repo.deleteTip(mine.id),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('투표하면 결과가 바뀌고 다시 누르면 선택이 옮겨 간다', () async {
      final repo = MockCommunityRepository(assets);

      var poll = await repo.vote(jumunjin, '2025-10', PollChoice.yes);
      expect((poll.yes, poll.no, poll.total), (48, 11, 59));
      expect(poll.myVote, PollChoice.yes);

      // 같은 쪽을 다시 보내면 그대로
      poll = await repo.vote(jumunjin, '2025-10', PollChoice.yes);
      expect((poll.yes, poll.no, poll.total), (48, 11, 59));

      poll = await repo.vote(jumunjin, '2025-10', PollChoice.no);
      expect((poll.yes, poll.no, poll.total), (47, 12, 59));
      expect(poll.myVote, PollChoice.no);
      expect((await repo.poll(jumunjin, '2025-10')).myVote, PollChoice.no);
      // 달이 다르면 별개의 투표
      expect((await repo.poll(jumunjin, '2025-11')).myVote, isNull);

      // null 이면 취소
      poll = await repo.vote(jumunjin, '2025-10', null);
      expect((poll.yes, poll.no, poll.total), (47, 11, 58));
      expect(poll.myVote, isNull);
    });

    test('지역 투표는 프리셋마다 따로 센다', () async {
      final repo = MockCommunityRepository(assets);

      final quiet = await repo.vote(
        region,
        '2025-10',
        PollChoice.yes,
        preset: PresetKey.quiet,
      );
      expect(quiet.myVote, PollChoice.yes);
      final lively = await repo.poll(
        region,
        '2025-10',
        preset: PresetKey.lively,
      );
      expect(lively.myVote, isNull);
      expect(lively.total, quiet.total - 1);
    });

    test('도움돼요를 켜고 끄면 수가 바뀌고 팁 목록에도 반영된다', () async {
      final repo = MockCommunityRepository(assets);
      final first = (await repo.tips(region)).items.first;

      var res = await repo.setHelpful(first.id, on: true);
      expect(res, (helpful: first.helpful + 1, myHelpful: true));
      // 여러 번 켜도 한 번만 센다
      res = await repo.setHelpful(first.id, on: true);
      expect(res.helpful, first.helpful + 1);
      expect((await repo.tips(region)).items.first.myHelpful, isTrue);

      res = await repo.setHelpful(first.id, on: false);
      expect(res, (helpful: first.helpful, myHelpful: false));

      // 내가 쓴 팁에는 누를 수 없다
      final mine = await repo.postTip(region, body: '내 팁', authorName: '두이');
      expect(mine.mine, isTrue);
      await expectLater(
        repo.setHelpful(mine.id, on: true),
        throwsA(isA<ServerException>()),
      );
    });

    test('답글은 팁의 답글 수만큼 있고, 쓰고 지우면 수가 따라간다', () async {
      final repo = MockCommunityRepository(assets);
      final first = (await repo.tips(region)).items.first;
      expect(first.replies, greaterThan(0));

      var list = await repo.replies(first.id);
      expect(list, hasLength(first.replies));
      // 오래된 순
      expect(
        list.first.createdAt.compareTo(list.last.createdAt),
        lessThanOrEqualTo(0),
      );

      final reply = await repo.postReply(
        first.id,
        body: '답글',
        authorName: '두이',
      );
      expect(reply.mine, isTrue);
      list = await repo.replies(first.id);
      expect(list.last.body, '답글');
      expect((await repo.tips(region)).items.first.replies, first.replies + 1);

      // 남의 답글은 지울 수 없다
      await expectLater(
        repo.deleteReply(first.id, list.first.id),
        throwsA(isA<NotFoundException>()),
      );
      await repo.deleteReply(first.id, reply.id);
      expect(await repo.replies(first.id), hasLength(first.replies));
      expect((await repo.tips(region)).items.first.replies, first.replies);
    });
  });

  group('ApiCommunityRepository', () {
    test('팁 · 투표 경로와 본문은 웹과 같다', () async {
      final tipJson = {
        'id': 'x',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-14T00:00:00Z',
        'body': '본문',
      };
      var client = _RecordingClient({
        'total': 1,
        'items': [tipJson],
      });
      var repo = ApiCommunityRepository(client);
      expect((await repo.tips(region)).items.single.body, '본문');
      expect(client.calls, ['GET /api/regions/51820/notes']);
      expect(client.lastQuery, {'sort': 'helpful'});

      client = _RecordingClient(tipJson);
      repo = ApiCommunityRepository(client);
      await repo.postTip(
        jumunjin,
        body: '본문',
        authorName: '두이',
        visitMonth: '2025-10',
      );
      expect(client.calls, ['POST /api/dongs/5115025000/notes']);
      expect(client.lastBody, {'body': '본문', 'visitMonth': '2025-10'});
      // 방문 월이 없으면 키를 뺀다(null 을 보내지 않는다)
      await repo.postTip(jumunjin, body: '본문', authorName: '두이');
      expect(client.lastBody, {'body': '본문'});

      client = _RecordingClient({'yes': 1, 'no': 0, 'total': 1});
      repo = ApiCommunityRepository(client);
      expect((await repo.poll(jumunjin, '2025-10')).total, 1);
      expect(client.calls, ['GET /api/dongs/5115025000/poll']);
      // 동네는 프리셋을 보내지 않는다
      expect(client.lastQuery, {'month': '2025-10'});

      await repo.vote(jumunjin, '2025-10', PollChoice.no);
      expect(client.calls.last, 'POST /api/dongs/5115025000/poll/vote');
      expect(client.lastBody, {'month': '2025-10', 'choice': 'no'});

      // 지역은 프리셋을 보내고(없으면 조용한 곳), 취소는 choice 를 null 로 보낸다
      await repo.poll(region, '2025-10', preset: PresetKey.lively);
      expect(client.calls.last, 'GET /api/regions/51820/poll');
      expect(client.lastQuery, {'month': '2025-10', 'preset': 'lively'});
      await repo.poll(region, '2025-10');
      expect(client.lastQuery, {'month': '2025-10', 'preset': 'quiet'});

      await repo.vote(region, '2025-10', null, preset: PresetKey.custom);
      expect(client.calls.last, 'POST /api/regions/51820/poll/vote');
      expect(client.lastBody, {
        'month': '2025-10',
        'preset': 'custom',
        'choice': null,
      });
    });

    test('도움돼요 · 답글 경로는 서버 tips.py 와 같다', () async {
      var client = _RecordingClient({'helpful': 4, 'myHelpful': true});
      var repo = ApiCommunityRepository(client);
      expect(await repo.setHelpful('7', on: true), (
        helpful: 4,
        myHelpful: true,
      ));
      expect(client.calls, ['PUT /api/tips/7/helpful']);

      client = _RecordingClient({'helpful': 3, 'myHelpful': false});
      repo = ApiCommunityRepository(client);
      expect(await repo.setHelpful('7', on: false), (
        helpful: 3,
        myHelpful: false,
      ));
      expect(client.calls, ['DELETE /api/tips/7/helpful']);

      final replyJson = {
        'id': '11',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-20T00:00:00Z',
        'body': '답글',
        'mine': true,
      };
      client = _RecordingClient({
        'items': [replyJson],
      });
      repo = ApiCommunityRepository(client);
      final list = await repo.replies('7');
      expect(list.single.body, '답글');
      expect(list.single.mine, isTrue);
      expect(client.calls, ['GET /api/tips/7/replies']);

      client = _RecordingClient(replyJson);
      repo = ApiCommunityRepository(client);
      expect(
        (await repo.postReply('7', body: '답글', authorName: '두이')).id,
        '11',
      );
      expect(client.calls, ['POST /api/tips/7/replies']);
      expect(client.lastBody, {'body': '답글'});

      await repo.deleteReply('7', '11');
      expect(client.calls.last, 'DELETE /api/me/replies/11');
    });

    test('사진이 있으면 팁을 multipart 로, 없으면 JSON 으로 보낸다', () async {
      final client = _RecordingClient({
        'id': '7',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-20T00:00:00Z',
        'body': '본문',
        'photos': [
          {'id': '31', 'url': 'https://r2.example/uploads/tip/a.webp'},
        ],
        'mine': true,
      });
      final repo = ApiCommunityRepository(client);
      const photos = [
        PickedPhoto(path: '/tmp/a.jpg', name: 'a.jpg', bytes: 10),
        PickedPhoto(path: '/tmp/b.png', name: 'b.png', bytes: 20),
      ];

      final tip = await repo.postTip(
        region,
        body: '본문',
        authorName: '두이',
        visitMonth: '2025-10',
        photos: photos,
      );
      expect(client.calls, ['MULTIPART /api/regions/51820/notes']);
      expect(client.lastFields, {'body': '본문', 'visitMonth': '2025-10'});
      expect(client.lastFileField, 'photos');
      expect(client.lastFiles, ['a.jpg', 'b.png']);
      expect(tip.photos.single.id, '31');

      // 방문 월이 없으면 칸을 뺀다
      await repo.postTip(region, body: '본문', authorName: '두이', photos: photos);
      expect(client.lastFields, {'body': '본문'});

      await repo.postTip(region, body: '본문', authorName: '두이');
      expect(client.calls.last, 'POST /api/regions/51820/notes');
      expect(client.lastBody, {'body': '본문'});
    });

    test('이달의 사진은 month 와 photos 를 multipart 로 보낸다', () async {
      final client = _RecordingClient({'items': <Object>[]});
      final repo = ApiCommunityRepository(client);

      await repo.uploadMonthPhotos(
        jumunjin,
        '2025-12',
        photos: const [
          PickedPhoto(path: '/tmp/a.jpg', name: 'a.jpg', bytes: 1),
        ],
        authorName: '두이',
      );
      expect(client.calls, ['MULTIPART /api/dongs/5115025000/photos']);
      expect(client.lastFields, {'month': '2025-12'});
      expect(client.lastFileField, 'photos');
      expect(client.lastFiles, ['a.jpg']);
    });

    test('내 팁 고치기 · 지우기 경로는 서버 me.py 의 MyTipView 와 같다', () async {
      final client = _RecordingClient({
        'id': '7',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-20T00:00:00Z',
        'body': '고친 본문',
        'helpful': 2,
        'replies': 1,
        'photos': <Object>[],
        'mine': true,
      });
      final repo = ApiCommunityRepository(client);

      final tip = await repo.updateTip('7', body: '고친 본문');
      expect(client.calls, ['PATCH /api/me/tips/7']);
      expect(client.lastBody, {'body': '고친 본문'});
      expect((tip.body, tip.mine), ('고친 본문', true));

      await repo.deleteTip('7');
      expect(client.calls.last, 'DELETE /api/me/tips/7');
    });

    test('팁 응답의 mine · myHelpful 을 읽고, 없으면 false 다', () {
      final base = {
        'id': '1',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-20T00:00:00Z',
        'body': '본문',
        'helpful': 2,
        'replies': 1,
        'photos': <Object>[],
      };
      expect(Tip.fromJson(base).mine, isFalse);
      expect(Tip.fromJson(base).myHelpful, isFalse);
      final mine = Tip.fromJson({...base, 'mine': true, 'myHelpful': true});
      expect((mine.mine, mine.myHelpful), (true, true));
    });

    test('팁 응답의 photos 를 순서대로 읽고, 키가 없으면 빈 목록이다', () {
      final base = {
        'id': '1',
        'author': {'nickname': '두이', 'initial': '두'},
        'createdAt': '2026-11-20T00:00:00Z',
        'body': '본문',
      };
      expect(Tip.fromJson(base).photos, isEmpty);
      final tip = Tip.fromJson({
        ...base,
        'photos': [
          {'id': '31', 'url': 'https://r2.example/uploads/tip/a.webp'},
          {'id': '32', 'url': 'https://r2.example/uploads/tip/b.webp'},
        ],
      });
      expect([for (final p in tip.photos) p.id], ['31', '32']);
      expect(tip.photos.first.url, 'https://r2.example/uploads/tip/a.webp');
    });
  });

  group('DongRepository', () {
    test('주문진읍 동네 프로필(Figma 수치)을 읽는다', () {
      final d = DongDetail.fromJson(
        jsonDecode(
          File('test/fixtures/dongs/5115025000.json').readAsStringSync(),
        ) as Map<String, dynamic>,
      );

      expect(d.name, '주문진읍');
      expect(d.sigungu.name, '강릉시');
      expect(d.kind, DongKind.living);
      expect(d.scores!.quiet, 31);
      expect(d.scores!.vibe, 62);
      expect(d.scores!.peer, 39);
      expect(d.stats.localLife, 74);
      expect(d.dongCount, 203);
      expect(d.peaks.weekday.peakHour, 11);
      expect(d.peaks.weekday.lowHour, 3);
      expect(d.peaks.weekday.lowValue, 48);
      expect(d.hourly.weekday, hasLength(24));
      expect(d.hourly.weekday[11], 100);
    });

    test('요청한 달을 그대로 돌려주고 없는 동은 404 이다', () async {
      final repo = MockDongRepository(assets);

      expect((await repo.detail('5115025000', 'annual')).month, 'annual');
      expect(
        repo.detail('0000000000', '2025-10'),
        throwsA(isA<NotFoundException>()),
      );
    });

    // assets/mock 은 실서버 응답을 받아 둔 것이라 값이 아니라 규칙만 봅니다.
    test('M-03b 동 목록에 나오는 동은 모두 열리고 곡선 규칙을 지킨다', () async {
      final repo = MockDongRepository(assets);
      var count = 0;
      for (final f in Directory('assets/mock/regions').listSync()) {
        final region = RegionDetail.fromJson(
          jsonDecode((f as File).readAsStringSync()) as Map<String, dynamic>,
        );
        for (final dong in region.dongs) {
          final d = await repo.detail(dong.id, '2025-10');
          count++;
          expect(d.name, dong.name, reason: dong.id);
          expect(d.sigungu.id, region.id, reason: dong.id);
          // 생활권 · 관광지 구분은 지역 목록과 동 상세가 같아야 합니다(workation-backend #32).
          expect(d.kind, dong.kind, reason: dong.id);
          for (final h in [d.hourly.weekday, d.hourly.weekend]) {
            expect(h, hasLength(24), reason: dong.id);
            expect(h.every((v) => v >= 0 && v <= 100), isTrue);
          }
          // 두 곡선 중 최대는 100
          expect(
            [
              ...d.hourly.weekday,
              ...d.hourly.weekend,
            ].reduce((a, b) => a > b ? a : b),
            100,
            reason: dong.id,
          );
          expect(d.hourly.weekday[d.peaks.weekday.peakHour], 100);
          expect(
            d.hourly.weekday[d.peaks.weekday.lowHour],
            d.peaks.weekday.lowValue,
          );
          expect(d.activityMix.values.reduce((a, b) => a + b), 100);
          expect(d.scores, isNotNull);
        }
      }
      expect(count, 203);
    });
  });

  test('ActivityKey 이름은 응답 키와 같다', () {
    expect(ActivityKey.values.map((k) => k.name), [
      'eveningDowntown',
      'weekendTourist',
      'weekdayWork',
      'dawnResidential',
    ]);
  });
}
