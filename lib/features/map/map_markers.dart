import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../data/models/explore.dart';
import '../../data/models/geo_area.dart';
import '../../shared/widgets/area_label.dart';
import '../../shared/widgets/dong_pin.dart';
import 'map_decor.dart';
import 'map_logic.dart';
import 'map_projection.dart';

// ---------------------------------------------------------------------------
// 마커 한 개의 명세
// ---------------------------------------------------------------------------

/// 마커로 그릴 그림. 같은 그림(`==`)은 비트맵을 한 번만 만들어 다시 씁니다.
@immutable
sealed class MarkerVisual {
  const MarkerVisual();
}

/// 행정동 이름 핀(`DongPin`). 흐린 핀은 같은 비트맵에 마커 투명도만 낮춥니다.
class PinVisual extends MarkerVisual {
  const PinVisual({required this.name, this.tag, this.selected = false});

  final String name;
  final String? tag;
  final bool selected;

  @override
  bool operator ==(Object other) =>
      other is PinVisual &&
      other.name == name &&
      other.tag == tag &&
      other.selected == selected;

  @override
  int get hashCode => Object.hash(PinVisual, name, tag, selected);
}

/// 구역 이름 라벨(`AreaLabel`).
class LabelVisual extends MarkerVisual {
  const LabelVisual({
    required this.name,
    this.summary,
    this.state = AreaLabelState.normal,
  });

  final String name;
  final String? summary;
  final AreaLabelState state;

  @override
  bool operator ==(Object other) =>
      other is LabelVisual &&
      other.name == name &&
      other.summary == summary &&
      other.state == state;

  @override
  int get hashCode => Object.hash(LabelVisual, name, summary, state);
}

/// "N곳 더" 묶음 필(`PinClusterPill`).
class ClusterVisual extends MarkerVisual {
  const ClusterVisual(this.count);

  final int count;

  @override
  bool operator ==(Object other) =>
      other is ClusterVisual && other.count == count;

  @override
  int get hashCode => Object.hash(ClusterVisual, count);
}

/// 지도에 붙일 마커 하나. 타일 지도(Google Maps)에서 `Marker` 로 바뀝니다.
class MapMarkerSpec {
  const MapMarkerSpec({
    required this.id,
    required this.at,
    required this.visual,
    this.alpha = 1,
    this.zIndex = 0,
    this.onTap,
  });

  final String id;
  final GeoPoint at;
  final MarkerVisual visual;

  /// 마커 투명도 0~1
  final double alpha;

  /// 클수록 위에 그립니다.
  final int zIndex;
  final VoidCallback? onTap;
}

/// 흐린 핀의 투명도(위젯 `DongPin` 의 dimmed 와 같은 값).
const kDimmedPinAlpha = 0.6;

/// 비트맵으로 그릴 때 위젯 둘레에 두는 여백(논리 px). 그림자가 잘리지 않게 합니다.
const kMarkerBitmapPadding = 12.0;

/// 비트맵 안에서 지도 위 위치에 맞출 점(0~1 비율). [bitmapSize] 는 여백
/// [padding] 을 둘러 그린 전체 크기입니다.
///
/// 핀은 아래 가운데의 위치 점 중심, 라벨 · 묶음은 한가운데입니다.
Offset markerAnchor(
  MarkerVisual visual,
  Size bitmapSize, {
  double padding = kMarkerBitmapPadding,
}) => switch (visual) {
  PinVisual() => Offset(
    0.5,
    (bitmapSize.height - padding - DongPin.dotSize / 2) / bitmapSize.height,
  ),
  LabelVisual() || ClusterVisual() => const Offset(0.5, 0.5),
};

// ---------------------------------------------------------------------------
// ⓪ 시군구 라벨
// ---------------------------------------------------------------------------

/// 시군구 라벨의 한 줄 요약. 예: `동 21 · 카페 · 해수욕장`
String areaSummary(GeoArea a) =>
    [if (a.dongCount != null) '동 ${a.dongCount}', ?a.hint].join(' · ');

/// 글자 폭 어림(한글 12px ≈ 12, 숫자 · 기호 ≈ 7)으로 잡은 라벨 상자 크기.
Size areaLabelSize(String name, String summary) => Size(
  20 + name.length * 12.0 + (summary.isEmpty ? 0 : 6 + summary.length * 9.0),
  26,
);

/// 화면에 놓기로 한 시군구 라벨 하나. [spot] 은 라벨 가운데의 화면 좌표입니다.
typedef PlacedAreaLabel = ({GeoArea area, Offset spot});

/// 겹치지 않게 보여 줄 시군구 라벨을 고릅니다(우선순위 순: 고른 것 → 점수 높은 것).
/// 겹쳐서 빠진 라벨은 확대하면 나타납니다.
///
/// 대표 점이 화면 안에 있는 라벨이 가장자리에 걸치면 안쪽으로 밀어 넣습니다.
/// [includeOffscreen] 이 true 면 화면 밖 라벨도 제자리에 함께 둡니다(지도에 붙는
/// 마커용 — 끌면 그대로 따라 들어옵니다). false 면 화면 안의 것만 고릅니다(겹친 위젯용).
List<PlacedAreaLabel> pickAreaLabels(
  MapCamera camera,
  List<GeoArea> areas, {
  required Map<String, double> scores,
  String? selected,
  required bool includeOffscreen,
}) {
  final viewport = Offset.zero & camera.size;

  Offset spot(GeoArea a) {
    final p = camera.toScreen(a.label!);
    if (!viewport.contains(p)) return p;
    final half = areaLabelSize(a.name, areaSummary(a)).width / 2 + 8;
    return Offset(p.dx.clamp(half, camera.size.width - half), p.dy);
  }

  final candidates =
      [
        for (final a in areas)
          if (a.label != null &&
              (includeOffscreen ||
                  viewport.contains(camera.toScreen(a.label!))))
            a,
      ]..sort((a, b) {
        if (a.id == selected) return -1;
        if (b.id == selected) return 1;
        return (scores[b.id] ?? -1).compareTo(scores[a.id] ?? -1);
      });
  final spots = [for (final a in candidates) spot(a)];
  final keep = pickNonOverlapping([
    for (var i = 0; i < candidates.length; i++)
      Rect.fromCenter(
        center: spots[i],
        width: areaLabelSize(
          candidates[i].name,
          areaSummary(candidates[i]),
        ).width,
        height: 26,
      ),
  ]);
  return [
    for (var i = 0; i < candidates.length; i++)
      if (keep[i]) (area: candidates[i], spot: spots[i]),
  ];
}

/// 집계 제외 라벨은 충분히 확대했을 때만 보입니다.
bool showsExcludedAreas(MapCamera camera) =>
    camera.visible.north - camera.visible.south < 3;

/// ⓪ 의 마커: 시군구 라벨 + 집계 제외 라벨. [camera] 는 손을 뗀 뒤의 카메라입니다.
List<MapMarkerSpec> sigunguMarkerSpecs(
  MapCamera camera,
  List<GeoArea> areas, {
  required Map<String, double> scores,
  String? selected,
  required ValueChanged<String> onSelect,
}) {
  final labels = pickAreaLabels(
    camera,
    areas,
    scores: scores,
    selected: selected,
    includeOffscreen: true,
  );
  return [
    if (showsExcludedAreas(camera))
      for (final e in kExcludedAreas)
        MapMarkerSpec(
          id: 'excluded:${e.name}',
          at: e.at,
          visual: LabelVisual(
            name: e.name,
            summary: '집계 제외',
            state: AreaLabelState.excluded,
          ),
        ),
    for (var i = 0; i < labels.length; i++)
      MapMarkerSpec(
        id: 'label:${labels[i].area.id}',
        // 가장자리에서 밀어 넣은 자리. 마커는 여기에 붙어 움직이고, 다음에 손을 떼면
        // 다시 맞춥니다.
        at: camera.toGeo(labels[i].spot),
        visual: LabelVisual(
          name: labels[i].area.name,
          summary: areaSummary(labels[i].area),
          state: labels[i].area.id == selected
              ? AreaLabelState.selected
              : AreaLabelState.normal,
        ),
        // 우선순위가 높을수록 위
        zIndex: labels.length - i,
        onTap: () => onSelect(labels[i].area.id),
      ),
  ];
}

// ---------------------------------------------------------------------------
// ① ② 행정동 핀 · 묶음
// ---------------------------------------------------------------------------

/// ① ② 의 마커: 이름 핀 + "N곳 더" 묶음. [camera] 는 손을 뗀 뒤의 카메라입니다.
///
/// 겹침은 이 카메라의 화면 좌표로 풀지만 마커는 위경도에 붙으므로, 끄는 동안은 그대로
/// 지도를 따라가고 묶음이 풀리는 것은 다음에 손을 뗀 뒤입니다. 화면 밖 핀도 함께
/// 놓아 끌면 바로 보이게 합니다. 화면 안의 묶음 필은 가장자리 안쪽으로 밀어 넣습니다.
List<MapMarkerSpec> dongMarkerSpecs(
  MapCamera camera,
  List<PinDong> pins, {
  String? dongId,
  required ValueChanged<String> onPickDong,
  required ValueChanged<PinCluster> onOpenCluster,
}) {
  final layout = layoutPins(
    [
      for (final p in pins)
        if (p.center != null) PlacedPin(p, camera.toScreen(p.center!)),
    ],
    viewport: Rect.largest,
    selectedId: dongId,
  );
  final shown = layout.shown;
  final viewport = Offset.zero & camera.size;
  Offset clusterSpot(PinCluster c) => viewport.contains(c.spot)
      ? Offset(c.spot.dx.clamp(40.0, camera.size.width - 40), c.spot.dy)
      : c.spot;

  return [
    for (var i = 0; i < shown.length; i++)
      MapMarkerSpec(
        id: 'pin:${shown[i].pin.id}',
        at: shown[i].pin.center!,
        visual: PinVisual(
          name: shown[i].pin.name,
          tag: pinIconTag(shown[i].pin.tags),
          selected: shown[i].pin.id == dongId,
        ),
        alpha: dongId != null && shown[i].pin.id != dongId
            ? kDimmedPinAlpha
            : 1,
        // 고른 핀(맨 앞)이 맨 위
        zIndex: shown.length - i,
        onTap: () => onPickDong(shown[i].pin.id),
      ),
    for (final c in layout.clusters)
      MapMarkerSpec(
        id: 'cluster:${c.members.first.id}',
        at: camera.toGeo(clusterSpot(c)),
        visual: ClusterVisual(c.members.length),
        // 묶음은 핀 위
        zIndex: shown.length + 1,
        onTap: () => onOpenCluster(c),
      ),
  ];
}
