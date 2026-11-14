import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/explore.dart';
import 'package:workation_mobile/data/repositories/explore_repository.dart';

dynamic _json(String file) =>
    jsonDecode(File('assets/mock/explore/$file').readAsStringSync());

/// mock 파일을 기다림 없이 돌려주는 가짜. 강릉시(51150) 핀 21동과 주문진읍(5115025000) 요약만 있고
/// 나머지는 404 입니다.
///
/// * [failPins] · [failDong] 이면 연결 실패를 던집니다.
/// * [dongGate] · [pinsGate] 를 주면 그 Completer 가 끝날 때까지 동 요약 · 핀이 로딩 중입니다.
class FakeExploreRepository implements ExploreRepository {
  FakeExploreRepository({
    this.failPins = false,
    this.failDong = false,
    this.dongGate,
    this.pinsGate,
  });

  bool failPins;
  bool failDong;
  Completer<void>? dongGate;
  Completer<void>? pinsGate;

  final pinCalls = <String>[];
  final dongCalls = <String>[];

  @override
  Future<PinsResponse> pins(String sigunguId) async {
    pinCalls.add(sigunguId);
    await pinsGate?.future;
    if (failPins) {
      throw NetworkException('/api/explore/sigungu/$sigunguId/pins');
    }
    if (sigunguId != '51150') {
      throw NotFoundException('/api/explore/sigungu/$sigunguId/pins');
    }
    return PinsResponse.fromJson(
      _json('pins_51150.json') as Map<String, dynamic>,
    );
  }

  @override
  Future<ExploreDong> dong(String dongId) async {
    dongCalls.add(dongId);
    await dongGate?.future;
    if (failDong) throw NetworkException('/api/explore/dongs/$dongId');
    if (dongId != '5115025000') {
      throw NotFoundException('/api/explore/dongs/$dongId');
    }
    return ExploreDong.fromJson(
      _json('dong_5115025000.json') as Map<String, dynamic>,
    );
  }
}
