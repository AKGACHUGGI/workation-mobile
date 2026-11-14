import 'dart:convert';
import 'dart:io';

import 'package:workation_mobile/data/models/geo_area.dart';
import 'package:workation_mobile/data/repositories/geo_repository.dart';

List<GeoArea> _read(String file) => GeoArea.parseCollection(
  jsonDecode(File('assets/geo/$file').readAsStringSync())
      as Map<String, dynamic>,
);

/// 번들한 경계 파일(`assets/geo/`)을 기다림 없이 읽는 가짜. 위젯 테스트에서는 실제 에셋 읽기가
/// 끝나지 않아 파일에서 직접 읽습니다.
class FakeGeoRepository implements GeoRepository {
  FakeGeoRepository({this.fail = false});

  bool fail;

  @override
  Future<List<GeoArea>> sigungu() async {
    if (fail) throw const FormatException('geo');
    return _read('sigungu.json');
  }

  @override
  Future<List<GeoArea>> dongs(String sigunguId) async {
    final f = File('assets/geo/dongs_$sigunguId.json');
    return f.existsSync() ? _read('dongs_$sigunguId.json') : const [];
  }
}
