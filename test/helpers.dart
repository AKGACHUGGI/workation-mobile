import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/app.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';

/// 위젯 하나를 앱 테마 안에서 띄웁니다.
Future<void> pumpInTheme(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

/// 앱 전체를 가짜 리포지토리로 띄웁니다.
/// (위젯 테스트에서는 실제 에셋 읽기가 끝나지 않아 mock 리포지토리를 쓸 수 없습니다.)
Future<void> pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        regionRepositoryProvider.overrideWithValue(FakeRegionRepository()),
      ],
      child: const WorkationApp(),
    ),
  );
  await tester.pumpAndSettle();
}

/// 고성군 · 양양군 · 정읍시 3곳을 돌려주는 가짜. [fail] 이면 연결 실패를 던집니다.
class FakeRegionRepository implements RegionRepository {
  FakeRegionRepository({this.fail = false});

  bool fail;

  @override
  Future<PopularResponse> popular(String month) async {
    if (fail) throw const NetworkException('/api/regions/popular');
    PopularRegion region(String id, String name, int fav, List<Terrain> t) =>
        PopularRegion(
          id: id,
          name: name,
          province: '강원특별자치도',
          tags: const ['해안'],
          terrain: t,
          scores: const MetricScores(
            quiet: 55,
            crowd: 37,
            peer: 48,
            overnight: 76,
            vibe: 30,
          ),
          favoriteCount: fav,
          viewCount: 8200,
        );
    return PopularResponse(
      month: month,
      asOf: '2025-12-31T00:00:00Z',
      items: [
        region('51830', '양양군', 1172, [Terrain.coast]),
        region('51820', '고성군', 1284, [Terrain.coast]),
        region('52140', '정읍시', 221, [Terrain.mountain]),
      ],
    );
  }
}
