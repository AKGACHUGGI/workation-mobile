import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/app/app.dart';
import 'package:workation_mobile/app/router.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/theme/app_theme.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/models/search_intent.dart';
import 'package:workation_mobile/data/repositories/explore_repository.dart';
import 'package:workation_mobile/data/repositories/geo_repository.dart';
import 'package:workation_mobile/data/repositories/region_repository.dart';
import 'package:workation_mobile/data/repositories/search_repository.dart';

import 'fakes/explore.dart';
import 'fakes/geo.dart';

/// 위젯 하나를 앱 테마 안에서 띄웁니다.
Future<void> pumpInTheme(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

/// 앱 전체를 가짜 리포지토리로 띄웁니다. [location] 으로 시작 화면을 고릅니다.
/// (위젯 테스트에서는 실제 에셋 읽기가 끝나지 않아 mock 리포지토리를 쓸 수 없습니다.)
/// 화면은 Figma 와 같은 폭 390 에 세로로 길게 잡아 목록이 다 그려지게 합니다.
Future<void> pumpApp(
  WidgetTester tester, {
  String location = AppRoutes.home,
  RegionRepository? regions,
  SearchRepository? search,
  ExploreRepository? explore,
  bool settle = true,
  Size size = const Size(390, 2400),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final router = createRouter(initialLocation: location);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        routerProvider.overrideWithValue(router),
        regionRepositoryProvider.overrideWithValue(
          regions ?? FakeRegionRepository(),
        ),
        searchRepositoryProvider.overrideWithValue(
          search ?? FakeSearchRepository(),
        ),
        exploreRepositoryProvider.overrideWithValue(
          explore ?? FakeExploreRepository(),
        ),
        geoRepositoryProvider.overrideWithValue(FakeGeoRepository()),
      ],
      child: const WorkationApp(),
    ),
  );
  // 스켈레톤처럼 끝없이 도는 애니메이션이 있는 화면은 settle: false 로 몇 프레임만 돌립니다.
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
}

/// 고성군 · 양양군 · 정읍시 3곳을 돌려주는 가짜. [fail] 이면 연결 실패를 던집니다.
/// 지역 상세는 고성군(51820)만 있고 그 밖은 404 입니다.
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

  @override
  Future<RegionDetail> detail(String id, String month) async {
    if (fail) throw NetworkException('/api/regions/$id');
    if (id != '51820') throw NotFoundException('/api/regions/$id');
    RegionDong dong(
      String id,
      String name,
      DongKind kind,
      String landmark,
      double quiet,
      int ofPeak,
    ) => RegionDong(
      id: id,
      name: name,
      kind: kind,
      landmark: landmark,
      quietScore: quiet,
      peakMonth: 8,
      crowdOfPeak: ofPeak,
    );
    return RegionDetail(
      id: id,
      name: '고성군',
      province: '강원특별자치도',
      tags: const ['해안', '속초시 인접'],
      seasonType: SeasonType.secondHalfRise,
      month: month,
      stats: const RegionStats(
        crowdIndex: 68,
        dayInflow: 0.76,
        quietRank: 6,
        peerShare: 41,
        overnightCoef: 0.98,
        weekendRatio: 1.05,
      ),
      months: [
        for (final (i, crowd) in const [
          53, 41, 41, 46, 60, 60, 80, 100, 52, 68, 52, 47, //
        ].indexed)
          MonthCrowd(month: i + 1, crowd: crowd),
      ],
      bestMonths: const [2, 3],
      avoidMonths: const [7, 8],
      peerOffpeakMonths: const [12, 2],
      dongs: [
        dong('5182025300', '거진읍', DongKind.living, '거진항', 37, 72),
        dong('5182034000', '토성면', DongKind.tourist, '송지호 해안', 68, 61),
        dong('5182033000', '죽왕면', DongKind.tourist, '왕곡마을', 55, 58),
        dong('5182025000', '간성읍', DongKind.living, '고성군청', 28, 100),
        dong('5182031000', '현내면', DongKind.tourist, '화진포', 20, 55),
      ],
      excludedDongs: const [
        ExcludedDong(name: '수동면', reason: 'special_facility'),
      ],
    );
  }
}

/// mock 파서를 기다림 없이 돌려주는 가짜. [fail] 이면 연결 실패를 던집니다.
class FakeSearchRepository implements SearchRepository {
  FakeSearchRepository({this.fail = false});

  bool fail;

  /// 받은 문장(순서대로)
  final calls = <String>[];

  @override
  Future<SearchIntent> parse(String text) async {
    calls.add(text);
    if (fail) throw const NetworkException('/api/search/parse');
    return mockParseIntent(text);
  }
}
