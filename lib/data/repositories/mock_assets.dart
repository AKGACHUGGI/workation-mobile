import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';

/// mock 응답(`assets/mock/*.json`)을 읽는 도우미. 실제 호출처럼 조금 기다렸다 돌려줍니다.
class MockAssets {
  const MockAssets(
    this._bundle, {
    this.delay = const Duration(milliseconds: 200),
  });

  final AssetBundle _bundle;
  final Duration delay;

  /// [file] 은 `assets/mock/` 아래 경로. 파일이 없으면 [NotFoundException] 을 던집니다.
  Future<dynamic> read(String file, {required String path}) async {
    if (delay > Duration.zero) await Future<void>.delayed(delay);
    final String raw;
    try {
      raw = await _bundle.loadString('assets/mock/$file');
    } on FlutterError {
      throw NotFoundException(path);
    }
    return jsonDecode(raw);
  }
}

/// 테스트에서는 `delay: Duration.zero` 로 override 합니다.
final mockAssetsProvider = Provider<MockAssets>(
  (ref) => MockAssets(rootBundle),
);
