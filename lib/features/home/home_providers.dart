import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../data/models/popular_region.dart';
import '../../data/models/search_intent.dart';
import '../../data/repositories/region_repository.dart';

/// 인기 지역 정렬 기준 (웹 W-01 과 같음).
enum PopularSort {
  favorites('즐겨찾기순', '즐겨찾기'),
  views('조회순', '조회'),
  score('종합 점수순', '종합');

  const PopularSort(this.label, this.badgePrefix);

  final String label;

  /// 상위 3곳 배지 접두어. 예: `즐겨찾기 1위`
  final String badgePrefix;
}

/// 홈에서 고른 조건. 월 · 프리셋 · 정렬 · 지형.
class HomeFilter {
  const HomeFilter({
    this.month = Months.defaultMonth,
    this.preset = PresetKey.quiet,
    this.sort = PopularSort.favorites,
    this.terrain,
    this.customWeights = Weights.quietPreset,
  });

  final String month;
  final PresetKey preset;
  final PopularSort sort;

  /// null 이면 지형으로 거르지 않습니다.
  final Terrain? terrain;

  /// 가중치 시트(헤더 슬라이더 버튼)에서 직접 맞춘 값. [preset] 이 `custom` 일 때 씁니다.
  final Weights customWeights;

  Weights get weights => switch (preset) {
    PresetKey.lively => Weights.livelyPreset,
    PresetKey.custom => customWeights,
    PresetKey.quiet => Weights.quietPreset,
  };

  HomeFilter copyWith({
    String? month,
    PresetKey? preset,
    PopularSort? sort,
    Terrain? Function()? terrain,
    Weights? customWeights,
  }) => HomeFilter(
    month: month ?? this.month,
    preset: preset ?? this.preset,
    sort: sort ?? this.sort,
    terrain: terrain == null ? this.terrain : terrain(),
    customWeights: customWeights ?? this.customWeights,
  );
}

class HomeFilterNotifier extends Notifier<HomeFilter> {
  @override
  HomeFilter build() => const HomeFilter();

  void setPreset(PresetKey preset) => state = state.copyWith(preset: preset);

  void setSort(PopularSort sort) => state = state.copyWith(sort: sort);

  /// 지표별 가중치를 직접 맞추고 프리셋을 `직접 설정` 으로 바꿉니다.
  void setCustomWeights(Weights weights) =>
      state = state.copyWith(preset: PresetKey.custom, customWeights: weights);

  /// 자연어 검색이 읽어낸 조건을 반영합니다. 문장에 없던 축은 그대로 둡니다
  /// (웹 `applyIntentToParams` 와 같음). 기간 · 또래는 태그로만 보여줍니다.
  void applyIntent(SearchIntent intent) {
    final preset = intent.preset;
    final terrain = intent.terrain;
    state = state.copyWith(
      month: intent.month,
      preset: preset == PresetKey.custom ? null : preset,
      terrain: terrain == null || terrain.isEmpty ? null : () => terrain.first,
    );
  }

  /// 월 · 프리셋 · 정렬 · 지형을 처음 값으로 되돌립니다.
  void reset() => state = const HomeFilter();

  /// 같은 지형을 다시 누르면 해제합니다.
  void toggleTerrain(Terrain terrain) => state = state.copyWith(
    terrain: () => state.terrain == terrain ? null : terrain,
  );
}

final homeFilterProvider = NotifierProvider<HomeFilterNotifier, HomeFilter>(
  HomeFilterNotifier.new,
);

/// 인기 지역 12곳 원본(정렬 없음).
final popularRegionsProvider = FutureProvider.family<PopularResponse, String>(
  (ref, month) => ref.watch(regionRepositoryProvider).popular(month),
);

/// 카드 한 장에 필요한 값. 지표 점수가 같은 달 12곳 안의 백분위라
/// 등급은 고정 경계([metricGrade])로 매깁니다.
class PopularCard {
  const PopularCard({
    required this.region,
    required this.score,
    required this.grades,
    this.badge,
  });

  final PopularRegion region;
  final double score;
  final Map<MetricKey, Grade> grades;
  final String? badge;
}

/// 정렬 · 지형 필터 · 등급 · 배지를 적용한 카드 목록 (웹 `popular/sort.ts` 규칙).
List<PopularCard> buildPopularCards(
  List<PopularRegion> items,
  HomeFilter filter,
) {
  final weights = filter.weights;
  final score = {
    for (final r in items) r.id: composite((k) => r.scores[k], weights),
  };
  int byScore(PopularRegion a, PopularRegion b) =>
      score[b.id]!.compareTo(score[a.id]!);
  int byFav(PopularRegion a, PopularRegion b) =>
      b.favoriteCount.compareTo(a.favoriteCount);
  int orElse(int first, int Function() second) => first != 0 ? first : second();

  final sorted = [...items]
    ..sort(
      (a, b) => switch (filter.sort) {
        PopularSort.favorites => orElse(byFav(a, b), () => byScore(a, b)),
        PopularSort.views => orElse(
          b.viewCount.compareTo(a.viewCount),
          () => byFav(a, b),
        ),
        PopularSort.score => orElse(byScore(a, b), () => byFav(a, b)),
      },
    );

  final terrain = filter.terrain;
  return [
    for (final (i, r) in sorted.indexed)
      if (terrain == null || r.terrain.contains(terrain))
        PopularCard(
          region: r,
          score: score[r.id]!,
          grades: {
            for (final key in MetricKey.values) key: metricGrade(r.scores[key]),
          },
          badge: i < 3 ? '${filter.sort.badgePrefix} ${i + 1}위' : null,
        ),
  ];
}
