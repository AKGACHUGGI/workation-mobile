import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/network/api_client.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
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

    test('투표하면 결과가 바뀌고 다시 누르면 선택이 옮겨 간다', () async {
      final repo = MockCommunityRepository(assets);

      var poll = await repo.vote(jumunjin, '2025-10', PollChoice.yes);
      expect((poll.yes, poll.no, poll.total), (48, 11, 59));
      expect(poll.myVote, PollChoice.yes);

      // 같은 쪽을 다시 누르면 그대로
      poll = await repo.vote(jumunjin, '2025-10', PollChoice.yes);
      expect((poll.yes, poll.no, poll.total), (48, 11, 59));

      poll = await repo.vote(jumunjin, '2025-10', PollChoice.no);
      expect((poll.yes, poll.no, poll.total), (47, 12, 59));
      expect(poll.myVote, PollChoice.no);
      expect((await repo.poll(jumunjin, '2025-10')).myVote, PollChoice.no);
      // 달이 다르면 별개의 투표
      expect((await repo.poll(jumunjin, '2025-11')).myVote, isNull);
    });
  });

  group('ApiCommunityRepository', () {
    test('읽기 경로는 웹과 같고 쓰기 경로는 notes · poll/vote 이다', () async {
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

      client = _RecordingClient({'yes': 1, 'no': 0, 'total': 1});
      repo = ApiCommunityRepository(client);
      expect((await repo.poll(jumunjin, '2025-10')).total, 1);
      expect(client.calls, ['GET /api/dongs/5115025000/poll']);
      expect(client.lastQuery, {'month': '2025-10'});

      await repo.vote(jumunjin, '2025-10', PollChoice.no);
      expect(client.calls.last, 'PUT /api/dongs/5115025000/poll/vote');
      expect(client.lastBody, {'month': '2025-10', 'choice': 'no'});
    });
  });

  group('DongRepository', () {
    test('주문진읍 mock 은 Figma 수치다', () async {
      final d = await MockDongRepository(assets)
          .detail('5115025000', '2025-10');

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
      expect(count, 67);
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
