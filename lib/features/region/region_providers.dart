import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/metric.dart';
import '../../data/models/popular_region.dart';
import '../../data/models/region_detail.dart';
import '../../data/repositories/region_repository.dart';

/// 지역 상세. 인자는 시군구 코드와 월(`2025-10` · `annual`).
final regionDetailProvider =
    FutureProvider.family<RegionDetail, ({String id, String month})>(
      (ref, arg) =>
          ref.watch(regionRepositoryProvider).detail(arg.id, arg.month),
    );

/// 12곳 안에서 본 한 지역의 종합 점수 · 순위 · 등급.
class RegionRank {
  const RegionRank({
    required this.score,
    required this.rank,
    required this.total,
    required this.grade,
    required this.scores,
  });

  /// 프리셋 가중 평균(반올림 전)
  final double score;

  /// 1부터. 같은 점수는 같은 순위
  final int rank;
  final int total;

  /// 종합 점수의 사분위 등급
  final Grade grade;
  final MetricScores scores;

  /// 예: `12곳 중 3위 · S`
  String get label => '$total곳 중 $rank위 · ${grade.label}';
}

/// [id] 의 순위를 구합니다. 웹 `region/rank.ts` 와 같이 종합 점수는 사분위로
/// 등급을 매기고([toGrades]), 같은 점수는 같은 순위입니다. 목록에 없으면 null.
RegionRank? rankRegion(List<PopularRegion> items, String id, Weights weights) {
  final index = items.indexWhere((r) => r.id == id);
  if (index < 0) return null;
  final scores = [
    for (final r in items) composite((k) => r.scores[k], weights),
  ];
  final mine = scores[index];
  return RegionRank(
    score: mine,
    rank: scores.where((s) => s > mine).length + 1,
    total: items.length,
    grade: toGrades(scores)[index],
    scores: items[index].scores,
  );
}
