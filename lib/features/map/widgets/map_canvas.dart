import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/explore.dart';
import '../../../data/models/geo_area.dart';
import '../map_projection.dart';

/// 지도에 칠하는 면 하나. 좌표는 세계 좌표(메르카토르)로 한 번만 바꿔 둡니다.
class MapShape {
  MapShape({
    required this.id,
    required this.polygons,
    this.fill,
    this.stroke,
    this.strokeWidth = 1,
  });

  /// 위경도 [area] 의 경계로 만듭니다.
  factory MapShape.fromArea(
    GeoArea area, {
    Color? fill,
    Color? stroke,
    double strokeWidth = 1,
  }) => MapShape(
    id: area.id,
    polygons: _worldCache[area] ??= [
      for (final polygon in area.polygons)
        [
          for (final ring in polygon)
            [for (final p in ring) MapProjection.toWorld(p)],
        ],
    ],
    fill: fill,
    stroke: stroke,
    strokeWidth: strokeWidth,
  );

  /// 위경도 점들로 이은 닫힌 면(바다 같은 장식).
  factory MapShape.fromPoints(
    String id,
    List<GeoPoint> points, {
    Color? fill,
    Color? stroke,
    double strokeWidth = 1,
  }) => MapShape(
    id: id,
    polygons: [
      [
        [for (final p in points) MapProjection.toWorld(p)],
      ],
    ],
    fill: fill,
    stroke: stroke,
    strokeWidth: strokeWidth,
  );

  static final _worldCache = Expando<List<List<List<Offset>>>>('worldPolygons');

  final String id;
  final List<List<List<Offset>>> polygons;
  final Color? fill;
  final Color? stroke;
  final double strokeWidth;
}

/// 밖에서 카메라를 옮기는 손잡이.
class MapCanvasController {
  _MapCanvasState? _state;

  /// [bounds] 가 화면에 들어오게 부드럽게 옮깁니다.
  void fitBounds(GeoBounds bounds, {EdgeInsets? padding}) =>
      _state?._animateToBounds(bounds, padding: padding);
}

/// 지도 한 장. 배경 · 면([shapes])을 직접 그리고, 이름 라벨 · 핀은 [overlayBuilder] 가
/// 돌려주는 위젯을 그 위에 겹칩니다. 끌어서 이동, 두 손가락으로 확대 · 축소합니다.
///
/// 나중에 Google Maps 로 바꿀 때 이 위젯 한 곳을 `GoogleMap` 으로 갈아 끼웁니다.
/// 투영은 [MapCamera](웹 메르카토르, Google Maps 와 같음)이고, 겹쳐 놓는 위젯은
/// 카메라로 위경도를 화면 좌표로 바꿔 자리를 잡으므로 지도 SDK 에 묶이지 않습니다.
class MapCanvas extends StatefulWidget {
  const MapCanvas({
    super.key,
    required this.bounds,
    this.fitKey,
    this.padding = const EdgeInsets.all(24),
    this.controller,
    this.shapes = const [],
    this.overlayBuilder,
    this.onTapGeo,
    this.maxZoomIn = 40,
    this.maxZoomOut = 8,
  });

  /// 처음 보여 줄 범위. [fitKey] 가 바뀌면 이 범위로 다시 맞춥니다.
  final GeoBounds bounds;
  final Object? fitKey;
  final EdgeInsets padding;
  final MapCanvasController? controller;

  /// 아래에서부터 칠할 면
  final List<MapShape> shapes;

  /// 라벨 · 핀. 카메라가 움직일 때마다 다시 불립니다.
  final Widget Function(BuildContext context, MapCamera camera)? overlayBuilder;

  /// 빈 곳(또는 면)을 눌렀을 때 위경도
  final ValueChanged<GeoPoint>? onTapGeo;

  /// 처음 맞춘 배율의 몇 배까지 확대 · 축소할 수 있는지
  final double maxZoomIn;
  final double maxZoomOut;

  @override
  State<MapCanvas> createState() => _MapCanvasState();
}

class _MapCanvasState extends State<MapCanvas>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  )..addListener(_onTick);

  MapCamera? _camera;
  double? _baseScale;
  MapCamera? _animFrom;
  MapCamera? _animTo;
  Size _size = Size.zero;

  // 확대 · 이동 제스처 시작 시점
  MapCamera? _gestureStart;
  Offset _gestureFocalWorld = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;
  }

  @override
  void didUpdateWidget(MapCanvas old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?._state = null;
      widget.controller?._state = this;
    }
    if (old.fitKey != widget.fitKey && _size != Size.zero) {
      _animateToBounds(widget.bounds);
    }
  }

  @override
  void dispose() {
    if (widget.controller?._state == this) widget.controller?._state = null;
    _anim.dispose();
    super.dispose();
  }

  void _onTick() {
    final from = _animFrom;
    final to = _animTo;
    if (from == null || to == null) return;
    setState(
      () => _camera = MapCamera.lerp(
        from,
        to,
        Curves.easeInOutCubic.transform(_anim.value),
      ),
    );
  }

  void _animateToBounds(GeoBounds bounds, {EdgeInsets? padding}) {
    final from = _camera;
    if (from == null) return;
    final to = MapCamera.fit(
      bounds,
      _size,
      padding: padding ?? widget.padding,
      maxScale: _maxScale,
    );
    _animFrom = from;
    _animTo = to;
    _anim.forward(from: 0);
  }

  double get _maxScale => (_baseScale ?? 1) * widget.maxZoomIn;
  double get _minScale => (_baseScale ?? 1) / widget.maxZoomOut;

  void _onScaleStart(ScaleStartDetails d) {
    _anim.stop();
    final cam = _camera;
    if (cam == null) return;
    _gestureStart = cam;
    _gestureFocalWorld =
        cam.center +
        (d.localFocalPoint - Offset(_size.width / 2, _size.height / 2)) /
            cam.scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails d) {
    final start = _gestureStart;
    if (start == null) return;
    final scale = (start.scale * d.scale).clamp(_minScale, _maxScale);
    final center =
        _gestureFocalWorld -
        (d.localFocalPoint - Offset(_size.width / 2, _size.height / 2)) / scale;
    setState(() => _camera = start.copyWith(center: center, scale: scale));
  }

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        _size = size;
        var camera = _camera;
        if (camera == null) {
          camera = MapCamera.fit(
            widget.bounds,
            size,
            padding: widget.padding,
            maxScale: double.infinity,
          );
          _baseScale = camera.scale;
        } else if (camera.size != size) {
          camera = camera.copyWith(size: size);
        }
        _camera = camera;
        final cam = camera;

        return ClipRect(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onTapUp: widget.onTapGeo == null
                ? null
                : (d) => widget.onTapGeo!(cam.toGeo(d.localPosition)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: semantic.mapLandAlt),
                CustomPaint(
                  painter: _ShapePainter(cam, widget.shapes),
                  size: size,
                ),
                if (widget.overlayBuilder != null)
                  widget.overlayBuilder!(context, cam),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ShapePainter extends CustomPainter {
  _ShapePainter(this.camera, this.shapes);

  final MapCamera camera;
  final List<MapShape> shapes;

  @override
  void paint(Canvas canvas, Size size) {
    final visible = Offset.zero & size;
    for (final shape in shapes) {
      final path = Path()..fillType = PathFillType.evenOdd;
      for (final polygon in shape.polygons) {
        for (final ring in polygon) {
          if (ring.isEmpty) continue;
          final first = camera.worldToScreen(ring.first);
          path.moveTo(first.dx, first.dy);
          for (var i = 1; i < ring.length; i++) {
            final p = camera.worldToScreen(ring[i]);
            path.lineTo(p.dx, p.dy);
          }
          path.close();
        }
      }
      if (!path.getBounds().overlaps(visible.inflate(8))) continue;
      final fill = shape.fill;
      if (fill != null) canvas.drawPath(path, Paint()..color = fill);
      final stroke = shape.stroke;
      if (stroke != null) {
        canvas.drawPath(
          path,
          Paint()
            ..color = stroke
            ..style = PaintingStyle.stroke
            ..strokeWidth = shape.strokeWidth
            ..strokeJoin = StrokeJoin.round,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ShapePainter old) =>
      old.camera.center != camera.center ||
      old.camera.scale != camera.scale ||
      old.camera.size != camera.size ||
      !identical(old.shapes, shapes) && !_sameShapes(old.shapes, shapes);

  static bool _sameShapes(List<MapShape> a, List<MapShape> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id ||
          a[i].fill != b[i].fill ||
          a[i].stroke != b[i].stroke ||
          a[i].strokeWidth != b[i].strokeWidth) {
        return false;
      }
    }
    return true;
  }
}

/// 지도 위에 위젯을 놓는 도우미. 위젯의 가로 가운데를 [at] 에 맞추고,
/// 세로는 [verticalAnchor] 가 정합니다: `bottom` 이면 아래 끝(핀), `center` 면 가운데(라벨).
/// [at] 은 Stack 안의 화면 좌표(px)입니다.
class MapAnchored extends StatelessWidget {
  const MapAnchored({
    super.key,
    required this.at,
    required this.child,
    this.verticalAnchor = MapAnchor.center,
    this.dy = 0,
  });

  final Offset at;
  final Widget child;
  final MapAnchor verticalAnchor;

  /// 맞춘 뒤 더 내려 놓을 px (예: 핀 점 반지름)
  final double dy;

  /// 위젯 가로 폭 상한. 화면 끝에서도 글자가 줄바꿈되지 않게 넉넉히 둡니다.
  static const maxWidth = 320.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: at.dx - maxWidth / 2,
      top: at.dy + dy,
      width: maxWidth,
      child: FractionalTranslation(
        translation: Offset(0, verticalAnchor == MapAnchor.bottom ? -1 : -0.5),
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 1,
          child: child,
        ),
      ),
    );
  }
}

enum MapAnchor { center, bottom }
