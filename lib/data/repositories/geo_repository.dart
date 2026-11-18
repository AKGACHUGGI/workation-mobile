import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/geo_area.dart';

/// 지도에 그릴 경계. 앱에 번들한 GeoJSON(`assets/geo/`)을 읽습니다.
/// (경계를 API 로 받기로 정해지면 이 인터페이스만 바꿉니다.)
abstract class GeoRepository {
  /// 시군구 12곳 경계
  Future<List<GeoArea>> sigungu();

  /// [sigunguId] 의 행정동 경계. 번들에 없으면 빈 목록입니다.
  Future<List<GeoArea>> dongs(String sigunguId);
}

class AssetGeoRepository implements GeoRepository {
  const AssetGeoRepository(this._bundle);

  final AssetBundle _bundle;

  Future<List<GeoArea>> _read(String file) async {
    final raw = await _bundle.loadString('assets/geo/$file');
    return GeoArea.parseCollection(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<List<GeoArea>> sigungu() => _read('sigungu.json');

  @override
  Future<List<GeoArea>> dongs(String sigunguId) async {
    try {
      return await _read('dongs_$sigunguId.json');
    } on FlutterError {
      return const [];
    }
  }
}

final geoRepositoryProvider = Provider<GeoRepository>(
  (ref) => AssetGeoRepository(rootBundle),
);
