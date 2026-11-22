import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/default_month.dart';
import '../../core/network/retry.dart';
import '../../data/models/explore.dart';
import '../../data/models/geo_area.dart';
import '../../data/models/popular_region.dart';
import '../../data/repositories/explore_repository.dart';
import '../../data/repositories/geo_repository.dart';
import '../../data/repositories/region_repository.dart';
import 'map_logic.dart';

/// ⓪ ① 헤더의 월. `2025-10` 또는 `annual`. 처음 값은 오늘의 달입니다.
class MapMonthNotifier extends Notifier<String> {
  @override
  String build() => ref.watch(defaultMonthProvider);

  void set(String month) => state = month;
}

final mapMonthProvider = NotifierProvider<MapMonthNotifier, String>(
  MapMonthNotifier.new,
);

/// ⓪ 지표 칩. null 이면 종합.
class MapMetricNotifier extends Notifier<MapMetric> {
  @override
  MapMetric build() => null;

  void set(MapMetric metric) => state = metric;
}

final mapMetricProvider = NotifierProvider<MapMetricNotifier, MapMetric>(
  MapMetricNotifier.new,
);

/// ⓪ 색칠과 요약 시트에 쓰는 시군구 점수(새 엔드포인트 없이 인기 지역 응답을 씁니다).
final mapPopularProvider = FutureProvider.family<PopularResponse, String>(
  (ref, month) => ref.watch(regionRepositoryProvider).popular(month),
  retry: noRetry,
);

/// 시군구 12곳 경계
final sigunguGeoProvider = FutureProvider<List<GeoArea>>(
  (ref) => ref.watch(geoRepositoryProvider).sigungu(),
  retry: noRetry,
);

/// 한 시군구의 행정동 경계(없으면 빈 목록)
final dongGeoProvider = FutureProvider.family<List<GeoArea>, String>(
  (ref, sggId) => ref.watch(geoRepositoryProvider).dongs(sggId),
  retry: noRetry,
);

/// ① 행정동 핀(지도와 목록이 같은 응답을 씁니다). mock 은 강릉시만 있고 나머지는 404.
final pinsProvider = FutureProvider.family<PinsResponse, String>(
  (ref, sggId) => ref.watch(exploreRepositoryProvider).pins(sggId),
  retry: noRetry,
);

/// ② 동 요약. 시트를 닫으면 버립니다.
final dongSummaryProvider = FutureProvider.autoDispose
    .family<ExploreDong, String>(
      (ref, dongId) => ref.watch(exploreRepositoryProvider).dong(dongId),
      retry: noRetry,
    );

/// ① 칩 선택. ②로 갔다 돌아와도 유지하도록 시군구마다 둡니다.
class PinFilterNotifier extends Notifier<PinFilter> {
  PinFilterNotifier(this.sggId);

  final String sggId;

  @override
  PinFilter build() => const PinFilter();

  void clear() => state = const PinFilter();
  void toggleType(String type) => state = state.toggleType(type);
  void toggleAttr(PinAttr attr) => state = state.toggleAttr(attr);
}

final pinFilterProvider =
    NotifierProvider.family<PinFilterNotifier, PinFilter, String>(
      PinFilterNotifier.new,
    );
