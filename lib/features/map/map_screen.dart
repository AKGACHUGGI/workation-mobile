import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/explore.dart';
import '../../data/models/geo_area.dart';
import '../../data/models/popular_region.dart';
import '../../shared/widgets/area_label.dart';
import '../../shared/widgets/dong_pin.dart';
import '../../shared/widgets/heat_legend.dart';
import 'map_decor.dart';
import 'map_logic.dart';
import 'map_projection.dart';
import 'map_providers.dart';
import 'widgets/dong_list_sheet.dart';
import 'widgets/dong_summary_sheet.dart';
import 'widgets/map_canvas.dart';
import 'widgets/map_header.dart';
import 'widgets/sigungu_sheet.dart';

/// 처음 보여 줄 범위: 강원 동해안 5개 시군구(고성 ~ 동해, Figma ⓪).
const _eastCoast = GeoBounds(
  west: 128.25,
  south: 37.4,
  east: 129.2,
  north: 38.65,
);

/// M-02 지도 v3. 세 단계가 한 화면의 상태이고 URL 쿼리와 같습니다.
///
/// * `/map` — ⓪ 시군구 히트맵 + 요약 시트
/// * `/map?sgg=:id` — ① 행정동 핀 + 칩 · 동 목록 시트
/// * `/map?sgg=:id&dong=:id` — ② 고른 핀 강조 + 동 요약 시트
///
/// 단계 이동은 `go` 로 같은 라우트의 쿼리만 바꾸므로 지도(카메라)는 그대로 두고
/// 부드럽게 옮깁니다. 뒤로 가기는 한 단계씩 올라갑니다.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key, this.sgg, this.dong});

  final String? sgg;
  final String? dong;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final _controller = MapCanvasController();

  /// ⓪ 에서 누른 시군구
  String? _selected;

  /// ⓪ 에서 전국 12곳을 한 화면에 볼지(아니면 동해안)
  bool _showAll = false;

  String? get _sgg => widget.sgg;
  String? get _dong => _sgg == null ? null : widget.dong;

  void _back() {
    if (_dong != null) {
      context.go(AppRoutes.mapAt(sgg: _sgg));
    } else if (_sgg != null) {
      context.go(AppRoutes.map);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sggId = _sgg;
    final sigungu = ref.watch(sigunguGeoProvider);
    final areas = sigungu.value;

    // 없는 시군구면 ⓪ 으로, 핀에 없는 동이면 ① 로 되돌립니다.
    if (sggId != null && areas != null && !areas.any((a) => a.id == sggId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(AppRoutes.map);
      });
    }
    if (sggId != null) {
      ref.listen(pinsProvider(sggId), (_, next) {
        final dongs = next.value?.dongs;
        final dong = _dong;
        if (dongs != null && dong != null && !dongs.any((d) => d.id == dong)) {
          context.go(AppRoutes.mapAt(sgg: sggId));
        }
      });
    }

    final month = ref.watch(mapMonthProvider);
    final metric = ref.watch(mapMetricProvider);
    GeoArea? active;
    if (sggId != null && areas != null) {
      for (final a in areas) {
        if (a.id == sggId) active = a;
      }
    }

    return PopScope(
      canPop: sggId == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (sggId == null)
                MapHeader.sigungu(
                  month: month,
                  onMonth: ref.read(mapMonthProvider.notifier).set,
                  metric: metric,
                  onMetric: ref.read(mapMetricProvider.notifier).set,
                )
              else
                MapHeader.dongs(
                  title: active?.name ?? '',
                  month: month,
                  onMonth: ref.read(mapMonthProvider.notifier).set,
                  onBack: _back,
                ),
              Expanded(
                child: sigungu.when(
                  loading: () => const _MapPlaceholder(),
                  error: (_, _) => _MapPlaceholder(
                    onRetry: () => ref.invalidate(sigunguGeoProvider),
                  ),
                  data: (areas) => sggId == null || active == null
                      ? _SigunguMap(
                          areas: areas,
                          controller: _controller,
                          showAll: _showAll,
                          selected: _selected,
                          onToggleAll: () =>
                              setState(() => _showAll = !_showAll),
                          onSelect: (id) => setState(() => _selected = id),
                        )
                      : _DongMap(
                          sigungu: active,
                          areas: areas,
                          controller: _controller,
                          dongId: _dong,
                          onPickDong: (id) =>
                              context.go(AppRoutes.mapAt(sgg: sggId, dong: id)),
                        ),
                ),
              ),
              _sheet(areas, active),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheet(List<GeoArea>? areas, GeoArea? active) {
    final sggId = _sgg;
    if (sggId == null || active == null) {
      final month = ref.watch(mapMonthProvider);
      final metric = ref.watch(mapMetricProvider);
      final popular = ref.watch(mapPopularProvider(month));
      GeoArea? selected;
      for (final a in areas ?? const <GeoArea>[]) {
        if (a.id == _selected) selected = a;
      }
      PopularRegion? region;
      for (final r in popular.value?.items ?? const <PopularRegion>[]) {
        if (r.id == _selected) region = r;
      }
      final scores = sigunguScores(popular.value?.items ?? const [], metric);
      return SigunguSheet(
        area: selected,
        region: region,
        score: scores[_selected],
        month: month,
        loading: popular.isLoading,
        onRetry: popular.hasError && !popular.isLoading
            ? () => ref.invalidate(mapPopularProvider(month))
            : null,
        onOpen: () => context.go(AppRoutes.mapAt(sgg: selected!.id)),
      );
    }
    final dongId = _dong;
    if (dongId == null) {
      return DongListSheet(
        sggId: sggId,
        sggName: active.name,
        onPickDong: (id) => context.go(AppRoutes.mapAt(sgg: sggId, dong: id)),
      );
    }
    final pins = ref.watch(pinsProvider(sggId)).value?.dongs;
    String name = '';
    for (final d in pins ?? const <PinDong>[]) {
      if (d.id == dongId) name = d.name;
    }
    return DongSummarySheet(
      dongId: dongId,
      fallbackName: name,
      sggName: active.name,
      onClose: () => context.go(AppRoutes.mapAt(sgg: sggId)),
      onOpen: () => context.push(AppRoutes.dong(dongId)),
    );
  }
}

/// 경계를 읽는 동안(또는 못 읽었을 때) 지도 자리.
class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder({this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return ColoredBox(
      color: semantic.mapLandAlt,
      child: onRetry == null
          ? null
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.s3,
                children: [
                  Text('지도를 불러오지 못했어요', style: AppTextStyles.bodySm),
                  OutlinedButton(
                    onPressed: onRetry,
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// ⓪ 시군구
// ---------------------------------------------------------------------------

class _SigunguMap extends ConsumerWidget {
  const _SigunguMap({
    required this.areas,
    required this.controller,
    required this.showAll,
    required this.selected,
    required this.onToggleAll,
    required this.onSelect,
  });

  final List<GeoArea> areas;
  final MapCanvasController controller;
  final bool showAll;
  final String? selected;
  final VoidCallback onToggleAll;
  final ValueChanged<String> onSelect;

  GeoBounds get _bounds {
    if (!showAll) return _eastCoast;
    return GeoBounds.of([for (final a in areas) ...a.points])!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final scheme = theme.colorScheme;
    final month = ref.watch(mapMonthProvider);
    final metric = ref.watch(mapMetricProvider);
    final items = ref.watch(mapPopularProvider(month)).value?.items ?? const [];
    final scores = sigunguScores(items, metric);

    Color fillOf(String id, {required bool on}) {
      final s = scores[id];
      if (s == null) {
        return scheme.surfaceContainerHighest.withValues(alpha: 0.7);
      }
      return semantic.heat[heatStep(s)].withValues(alpha: on ? 0.85 : 0.65);
    }

    final shapes = <MapShape>[
      MapShape.fromPoints('sea', kSeaPolygon, fill: semantic.mapSea),
      for (final a in areas)
        if (a.id != selected)
          MapShape.fromArea(
            a,
            fill: fillOf(a.id, on: false),
            stroke: semantic.textTertiary,
          ),
      for (final a in areas)
        if (a.id == selected)
          MapShape.fromArea(
            a,
            fill: fillOf(a.id, on: true),
            stroke: scheme.primary,
            strokeWidth: 2,
          ),
    ];

    void tapGeo(GeoPoint p) {
      for (final a in areas) {
        if (a.polygons.any((poly) => pointInPolygon(p, poly))) {
          onSelect(a.id);
          return;
        }
      }
    }

    return Stack(
      children: [
        MapCanvas(
          bounds: _bounds,
          fitKey: showAll,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
          controller: controller,
          shapes: shapes,
          onTapGeo: tapGeo,
          overlayBuilder: (context, camera) => _SigunguLabels(
            camera: camera,
            areas: areas,
            scores: scores,
            selected: selected,
            onSelect: onSelect,
          ),
        ),
        Positioned(
          left: AppSpacing.s4,
          bottom: AppSpacing.s4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: HeatLegend(),
            ),
          ),
        ),
        Positioned(
          right: AppSpacing.s3,
          bottom: AppSpacing.s3,
          child: _ViewToggle(showAll: showAll, onTap: onToggleAll),
        ),
      ],
    );
  }
}

/// 동해안 ↔ 전국 12곳 보기 전환 버튼
class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.showAll, required this.onTap});

  final bool showAll;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: showAll ? '동해안만 보기' : '전국 12곳 보기',
      excludeSemantics: true,
      child: Material(
        color: scheme.surface,
        shape: const StadiumBorder(),
        elevation: 0,
        shadowColor: scheme.shadow,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppRadius.fullAll,
              boxShadow: AppShadows.cardFloat,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Icon(
                    showAll ? LucideIcons.locate : LucideIcons.map,
                    size: 16,
                  ),
                  Text(
                    showAll ? '동해안' : '전국 12곳',
                    style: AppTextStyles.captionXsMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SigunguLabels extends StatelessWidget {
  const _SigunguLabels({
    required this.camera,
    required this.areas,
    required this.scores,
    required this.selected,
    required this.onSelect,
  });

  final MapCamera camera;
  final List<GeoArea> areas;
  final Map<String, double> scores;
  final String? selected;
  final ValueChanged<String> onSelect;

  static String summaryOf(GeoArea a) =>
      [if (a.dongCount != null) '동 ${a.dongCount}', ?a.hint].join(' · ');

  /// 글자 폭 어림(한글 12px ≈ 12, 숫자 · 기호 ≈ 7)으로 라벨 상자를 잡습니다.
  static Size sizeOf(String name, String summary) => Size(
    20 + name.length * 12.0 + (summary.isEmpty ? 0 : 6 + summary.length * 9.0),
    26,
  );

  @override
  Widget build(BuildContext context) {
    final viewport = Offset.zero & camera.size;

    // 화면 가장자리에 걸치면 안쪽으로 밀어 넣습니다.
    Offset spot(GeoArea a) {
      final p = camera.toScreen(a.label!);
      final half = sizeOf(a.name, summaryOf(a)).width / 2 + 8;
      return Offset(p.dx.clamp(half, camera.size.width - half), p.dy);
    }

    // 고른 것 → 점수 높은 것 순으로 자리를 잡고, 겹치는 라벨은 숨깁니다(확대하면 나타남).
    final candidates =
        [
          for (final a in areas)
            if (a.label != null && viewport.contains(camera.toScreen(a.label!)))
              a,
        ]..sort((a, b) {
          if (a.id == selected) return -1;
          if (b.id == selected) return 1;
          return (scores[b.id] ?? -1).compareTo(scores[a.id] ?? -1);
        });
    final rects = [
      for (final a in candidates)
        Rect.fromCenter(
          center: spot(a),
          width: sizeOf(a.name, summaryOf(a)).width,
          height: 26,
        ),
    ];
    final keep = pickNonOverlapping(rects);

    final zoomedIn = camera.visible.north - camera.visible.south < 3;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (zoomedIn)
          for (final c in kContextLabels)
            if (viewport.contains(camera.toScreen(c.at)))
              MapAnchored(
                at: camera.toScreen(c.at),
                child: Text(
                  c.name,
                  style:
                      (c.sea
                              ? AppTextStyles.bodySmMedium
                              : AppTextStyles.captionXs)
                          .copyWith(
                            color: Theme.of(context)
                                .extension<AppSemanticColors>()!
                                .textTertiary,
                          ),
                ),
              ),
        if (zoomedIn)
          for (final e in kExcludedAreas)
            if (viewport.contains(camera.toScreen(e.at)))
              MapAnchored(
                at: camera.toScreen(e.at),
                child: AreaLabel(
                  name: e.name,
                  summary: '집계 제외',
                  state: AreaLabelState.excluded,
                ),
              ),
        for (var i = candidates.length - 1; i >= 0; i--)
          if (keep[i])
            MapAnchored(
              key: ValueKey(candidates[i].id),
              at: spot(candidates[i]),
              child: AreaLabel(
                name: candidates[i].name,
                summary: summaryOf(candidates[i]),
                state: candidates[i].id == selected
                    ? AreaLabelState.selected
                    : AreaLabelState.normal,
                onTap: () => onSelect(candidates[i].id),
              ),
            ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ① ② 행정동 핀
// ---------------------------------------------------------------------------

class _DongMap extends ConsumerWidget {
  const _DongMap({
    required this.sigungu,
    required this.areas,
    required this.controller,
    required this.dongId,
    required this.onPickDong,
  });

  final GeoArea sigungu;
  final List<GeoArea> areas;
  final MapCanvasController controller;
  final String? dongId;
  final ValueChanged<String> onPickDong;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final scheme = theme.colorScheme;
    final dongGeo = ref.watch(dongGeoProvider(sigungu.id)).value ?? const [];
    final pins = ref.watch(pinsProvider(sigungu.id)).value?.dongs ?? const [];
    final bounds = GeoBounds.of(sigungu.points)!;

    final shapes = <MapShape>[
      MapShape.fromPoints('sea', kSeaPolygon, fill: semantic.mapSea),
      MapShape.fromArea(
        sigungu,
        fill: semantic.mapLand,
        stroke: scheme.primary,
        strokeWidth: 1.5,
      ),
      for (final d in dongGeo)
        MapShape.fromArea(
          d,
          stroke: semantic.textTertiary.withValues(alpha: 0.6),
        ),
    ];

    return MapCanvas(
      bounds: bounds,
      fitKey: sigungu.id,
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 24),
      controller: controller,
      shapes: shapes,
      overlayBuilder: (context, camera) => _PinLayer(
        camera: camera,
        sigungu: sigungu,
        areas: areas,
        pins: pins,
        dongId: dongId,
        controller: controller,
        onPickDong: onPickDong,
      ),
    );
  }
}

class _PinLayer extends StatelessWidget {
  const _PinLayer({
    required this.camera,
    required this.sigungu,
    required this.areas,
    required this.pins,
    required this.dongId,
    required this.controller,
    required this.onPickDong,
  });

  final MapCamera camera;
  final GeoArea sigungu;
  final List<GeoArea> areas;
  final List<PinDong> pins;
  final String? dongId;
  final MapCanvasController controller;
  final ValueChanged<String> onPickDong;

  @override
  Widget build(BuildContext context) {
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final viewport = Offset.zero & camera.size;
    final layout = layoutPins(
      [
        for (final p in pins)
          if (p.center != null) PlacedPin(p, camera.toScreen(p.center!)),
      ],
      viewport: viewport,
      selectedId: dongId,
    );

    DongPinState stateOf(PinDong p) => dongId == null
        ? DongPinState.normal
        : p.id == dongId
        ? DongPinState.selected
        : DongPinState.dimmed;

    final mutedStyle = AppTextStyles.captionXsMedium.copyWith(color: tertiary);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 이웃 시군구 · 동해 이름
        for (final a in areas)
          if (a.id != sigungu.id &&
              a.label != null &&
              viewport.contains(camera.toScreen(a.label!)))
            MapAnchored(
              at: camera.toScreen(a.label!),
              child: Text(a.name, style: mutedStyle),
            ),
        for (final c in kContextLabels)
          if (viewport.contains(camera.toScreen(c.at)))
            MapAnchored(
              at: camera.toScreen(c.at),
              child: Text(c.name, style: mutedStyle),
            ),
        // 고른 핀이 맨 위
        for (final placed in layout.shown.reversed)
          MapAnchored(
            key: ValueKey(placed.pin.id),
            at: placed.anchor,
            verticalAnchor: MapAnchor.bottom,
            dy: DongPin.dotSize / 2,
            child: DongPin(
              name: placed.pin.name,
              tag: pinIconTag(placed.pin.tags),
              state: stateOf(placed.pin),
              onTap: () => onPickDong(placed.pin.id),
            ),
          ),
        for (final c in layout.clusters)
          MapAnchored(
            at: Offset(
              c.spot.dx.clamp(40.0, camera.size.width - 40),
              c.spot.dy,
            ),
            child: PinClusterPill(
              count: c.members.length,
              onTap: () => controller.fitBounds(
                GeoBounds.of([for (final m in c.members) m.center!])!
                    .atLeast(0.012),
                padding: const EdgeInsets.fromLTRB(56, 96, 56, 56),
              ),
            ),
          ),
      ],
    );
  }
}
