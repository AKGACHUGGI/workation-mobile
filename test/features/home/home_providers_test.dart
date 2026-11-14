import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/metric/metric.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/features/home/home_providers.dart';

PopularRegion region(
  String id, {
  required int fav,
  required int views,
  required double quiet,
  List<Terrain> terrain = const [Terrain.coast],
}) => PopularRegion(
  id: id,
  name: id,
  province: '도',
  terrain: terrain,
  scores: MetricScores(
    quiet: quiet,
    crowd: quiet,
    peer: 0,
    overnight: 0,
    vibe: 0,
  ),
  favoriteCount: fav,
  viewCount: views,
);

void main() {
  final items = [
    region('a', fav: 10, views: 300, quiet: 20),
    region('b', fav: 30, views: 100, quiet: 80, terrain: [Terrain.city]),
    region('c', fav: 20, views: 200, quiet: 60),
    region('d', fav: 5, views: 50, quiet: 40),
  ];
  List<String> ids(HomeFilter f) => [
    for (final c in buildPopularCards(items, f)) c.region.id,
  ];

  test('정렬 기준에 따라 순서가 바뀐다', () {
    expect(ids(const HomeFilter()), ['b', 'c', 'a', 'd']);
    expect(ids(const HomeFilter(sort: PopularSort.views)), [
      'a',
      'c',
      'b',
      'd',
    ]);
    expect(ids(const HomeFilter(sort: PopularSort.score)), [
      'b',
      'c',
      'd',
      'a',
    ]);
  });

  test('상위 3곳에만 배지가 붙고, 지형으로 걸러도 순위는 전체 기준이다', () {
    final all = buildPopularCards(items, const HomeFilter());
    expect(all.map((c) => c.badge), ['즐겨찾기 1위', '즐겨찾기 2위', '즐겨찾기 3위', null]);

    final coast = buildPopularCards(
      items,
      const HomeFilter(terrain: Terrain.coast),
    );
    expect(coast.map((c) => c.region.id), ['c', 'a', 'd']);
    expect(coast.first.badge, '즐겨찾기 2위');
  });

  test('등급은 지표 점수의 고정 경계로 매기고 종합 점수는 프리셋 가중 평균이다', () {
    final cards = buildPopularCards(items, const HomeFilter());
    final byId = {for (final c in cards) c.region.id: c};

    expect(byId['b']!.grades[MetricKey.quiet], Grade.s);
    expect(byId['c']!.grades[MetricKey.quiet], Grade.a);
    expect(byId['a']!.grades[MetricKey.quiet], Grade.c);
    // 조용한 곳 프리셋: (80×3 + 80×3) ÷ 8
    expect(byId['b']!.score, 60);
  });

  test('직접 설정 프리셋은 맞춘 가중치로 점수를 매긴다', () {
    const w = Weights(quiet: 0, crowd: 0, peer: 0, overnight: 0, vibe: 1);
    final custom = const HomeFilter().copyWith(
      preset: PresetKey.custom,
      customWeights: w,
    );

    expect(custom.weights, same(w));
    expect(const HomeFilter().weights, same(Weights.quietPreset));
    expect(
      const HomeFilter(preset: PresetKey.lively).weights,
      same(Weights.livelyPreset),
    );
    // 활기 점수만 보면 모두 0 점
    expect(
      buildPopularCards(items, custom).map((c) => c.score),
      everyElement(0),
    );
  });
}
