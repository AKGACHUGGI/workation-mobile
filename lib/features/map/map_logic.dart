import 'package:flutter/painting.dart';

import '../../core/metric/metric.dart';
import '../../data/models/explore.dart';
import '../../data/models/popular_region.dart';
import '../../shared/widgets/dong_pin.dart';

// ---------------------------------------------------------------------------
// ⓪ 시군구 점수
// ---------------------------------------------------------------------------

/// ⓪ 지표 칩. [metric] 이 null 이면 종합(프리셋 가중 평균)입니다.
typedef MapMetric = MetricKey?;

/// 시군구별 점수 0~100. 종합은 [weights] 가중 평균, 지표는 그 지표 점수입니다.
Map<String, double> sigunguScores(
  List<PopularRegion> items,
  MapMetric metric, {
  Weights weights = Weights.quietPreset,
}) => {
  for (final r in items)
    r.id: metric == null
        ? composite((k) => r.scores[k], weights)
        : r.scores[metric],
};

/// 점수(0~100)를 heat 7단계(0~6)로. 단계 폭은 약 14.3 입니다.
int heatStep(double score) =>
    ((score.clamp(0, 100) / 100) * 7).floor().clamp(0, 6);

// ---------------------------------------------------------------------------
// ① 칩 · 정렬 · 거르기
// ---------------------------------------------------------------------------

/// ① 시트의 칩 선택. 유형 칩은 하나만, 속성 칩(바닷가 · 생활권 · 관광지)은 겹쳐 고릅니다.
class PinFilter {
  const PinFilter({this.type, this.attrs = const {}});

  /// 선택한 워케이션 유형. null 이면 "전체" 입니다.
  final String? type;
  final Set<PinAttr> attrs;

  bool get isAll => type == null && attrs.isEmpty;

  /// 유형 칩을 누릅니다. 이미 고른 칩이면 풉니다.
  PinFilter toggleType(String t) =>
      PinFilter(type: type == t ? null : t, attrs: attrs);

  PinFilter toggleAttr(PinAttr a) {
    final next = {...attrs};
    if (!next.remove(a)) next.add(a);
    return PinFilter(type: type, attrs: next);
  }

  @override
  bool operator ==(Object other) =>
      other is PinFilter &&
      other.type == type &&
      other.attrs.length == attrs.length &&
      other.attrs.containsAll(attrs);

  @override
  int get hashCode => Object.hash(type, Object.hashAllUnordered(attrs));
}

enum PinAttr {
  coast('바닷가'),
  life('생활권'),
  tourist('관광지');

  const PinAttr(this.label);

  final String label;

  bool matches(PinDong d) => switch (this) {
    PinAttr.coast => d.coastal,
    PinAttr.life => d.life == '생활권',
    PinAttr.tourist => d.life == '관광지',
  };
}

/// 속성 칩으로 거른 뒤 정렬합니다. 속성 칩끼리는 모두 만족해야 합니다(AND).
/// 유형 칩이 있으면 그 유형 점수 높은 순(점수 없는 동은 뒤), 없으면 이름순입니다.
/// 점수가 같으면 이름순입니다.
List<PinDong> filterAndSortPins(List<PinDong> pins, PinFilter filter) {
  final type = filter.type;
  final kept = [
    for (final d in pins)
      if (filter.attrs.every((a) => a.matches(d))) d,
  ];
  kept.sort((a, b) {
    if (type != null) {
      final sa = a.scoreOf(type);
      final sb = b.scoreOf(type);
      if (sa != sb) {
        if (sa == null) return 1;
        if (sb == null) return -1;
        return sb.compareTo(sa);
      }
    }
    return a.name.compareTo(b.name);
  });
  return kept;
}

/// 행 오른쪽에 보여 줄 점수와 유형 이름. 유형 칩이 있으면 그 유형, 없으면 1위 유형입니다.
({double score, String type})? rowScore(PinDong d, PinFilter filter) {
  final type = filter.type ?? d.topType;
  if (type == null) return null;
  final score = filter.type != null ? d.scoreOf(type) : d.topScore;
  return score == null ? null : (score: score, type: type);
}

// ---------------------------------------------------------------------------
// ① 핀 아이콘 · 겹침 묶음
// ---------------------------------------------------------------------------

/// 핀에 그릴 대표 태그 1개. 바닷가 · 도심 같은 특성 태그보다 하는 일 · 쉬는 곳 태그를 앞세웁니다.
/// 아이콘이 있는 태그가 없으면 null (아이콘 없는 핀).
String? pinIconTag(List<String> tags) {
  final known = [
    for (final t in tags)
      if (kPinTagGroup.containsKey(t)) t,
  ];
  for (final t in known) {
    if (kPinTagGroup[t] != PinTagGroup.trait) return t;
  }
  return known.isEmpty ? null : known.first;
}

/// 순서대로 훑으며 앞서 놓은 것과 겹치지 않는 사각형만 남깁니다. 남긴 것은 true.
List<bool> pickNonOverlapping(List<Rect> rects) {
  final kept = <Rect>[];
  return [
    for (final r in rects)
      if (kept.any(r.overlaps))
        false
      else
        (() {
          kept.add(r);
          return true;
        })(),
  ];
}

/// 화면에 놓은 핀 하나(꼬리 끝 = [anchor]).
class PlacedPin {
  const PlacedPin(this.pin, this.anchor);

  final PinDong pin;
  final Offset anchor;
}

/// 겹쳐서 접힌 핀들. [center] 는 화면 좌표입니다.
class PinCluster {
  PinCluster(PlacedPin first) : members = [first.pin], _sum = first.anchor;

  final List<PinDong> members;
  Offset _sum;

  /// 접힌 핀들의 평균 위치
  Offset get center => _sum / members.length.toDouble();

  /// 필을 그릴 위치. 이름 핀과 겹치지 않게 [center] 에서 조금 옮긴 자리([layoutPins] 가 정함).
  late Offset spot = _sum / members.length.toDouble();

  void _add(PlacedPin p) {
    members.add(p.pin);
    _sum += p.anchor;
  }
}

class PinLayout {
  const PinLayout({required this.shown, required this.clusters});

  /// 이름 핀으로 그릴 것(우선순위 순)
  final List<PlacedPin> shown;

  /// "N곳 더" 로 접은 것
  final List<PinCluster> clusters;
}

/// 핀 겹침을 풀어 보여 줄 것과 접을 것으로 나눕니다.
///
/// 우선순위는 고른 핀 → 1위 유형 점수 높은 순 → 이름순입니다. 앞선 핀과 겹치는 핀은
/// 접고, 접힌 핀은 [clusterRadius] 안에 모인 것끼리 하나의 묶음이 됩니다.
/// 확대하면 핀 사이가 벌어져 저절로 풀립니다. [viewport] 밖의 핀은 그리지 않습니다.
PinLayout layoutPins(
  List<PlacedPin> pins, {
  required Rect viewport,
  String? selectedId,
  double Function(PinDong pin)? widthOf,
  double pinHeight = 44,
  double clusterRadius = 110,
}) {
  double width(PinDong d) =>
      widthOf?.call(d) ?? (d.tags.isEmpty ? 24 : 50) + d.name.length * 12.0;

  final ordered =
      [
        for (final p in pins)
          if (viewport.inflate(40).contains(p.anchor)) p,
      ]..sort((a, b) {
        if (a.pin.id == selectedId) return -1;
        if (b.pin.id == selectedId) return 1;
        final sa = a.pin.topScore ?? -1;
        final sb = b.pin.topScore ?? -1;
        if (sa != sb) return sb.compareTo(sa);
        return a.pin.name.compareTo(b.pin.name);
      });

  final rects = [
    for (final p in ordered)
      Rect.fromLTWH(
        p.anchor.dx - width(p.pin) / 2,
        p.anchor.dy - pinHeight,
        width(p.pin),
        pinHeight,
      ),
  ];
  final keep = pickNonOverlapping(rects);
  final shown = <PlacedPin>[];
  final clusters = <PinCluster>[];
  for (var i = 0; i < ordered.length; i++) {
    final p = ordered[i];
    if (keep[i] || p.pin.id == selectedId) {
      shown.add(p);
      continue;
    }
    PinCluster? home;
    for (final c in clusters) {
      if ((c.center - p.anchor).distance <= clusterRadius) {
        home = c;
        break;
      }
    }
    if (home == null) {
      clusters.add(PinCluster(p));
    } else {
      home._add(p);
    }
  }
  // 묶음 필이 이름 핀을 가리지 않는 자리를 찾습니다(평균 위치 → 아래 → 위 → 옆).
  final taken = [
    for (final p in shown)
      Rect.fromLTWH(
        p.anchor.dx - width(p.pin) / 2,
        p.anchor.dy - pinHeight,
        width(p.pin),
        pinHeight + 8,
      ),
  ];
  for (final c in clusters) {
    for (final d in const [
      Offset.zero,
      Offset(0, 40),
      Offset(0, -40),
      Offset(80, 0),
      Offset(-80, 0),
      Offset(0, 80),
      Offset(0, -80),
    ]) {
      final at = c.center + d;
      final rect = Rect.fromCenter(center: at, width: 76, height: 28);
      if (!taken.any(rect.overlaps)) {
        c.spot = at;
        taken.add(rect);
        break;
      }
    }
  }
  return PinLayout(shown: shown, clusters: clusters);
}
