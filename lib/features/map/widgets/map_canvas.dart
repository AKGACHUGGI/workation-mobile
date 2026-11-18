import 'package:flutter/material.dart';

import '../../../core/network/api_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/explore.dart';
import '../../../data/models/geo_area.dart';
import '../map_projection.dart';
import 'google_map_canvas.dart';

/// 지도에 칠하는 면 하나. 경계는 위경도로 두고, 직접 그릴 때 쓰는 세계 좌표(메르카토르)는
/// 처음 필요할 때 한 번만 바꿔 둡니다.
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
    polygons: area.polygons,
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
      [points],
    ],
    fill: fill,
    stroke: stroke,
    strokeWidth: strokeWidth,
  );

  static final _worldCache = Expando<List<List<List<Offset>>>>('worldPolygons');

  final String id;

  /// 폴리곤 → 고리(첫 고리가 바깥, 나머지는 구멍) → 점
  final List<List<List<GeoPoint>>> polygons;
  final Color? fill;
  final Color? stroke;
  final double strokeWidth;

  /// [polygons] 를 세계 좌표로 바꾼 것. 같은 경계 목록이면 다시 계산하지 않습니다.
  List<List<List<Offset>>> get world => _worldCache[polygons] ??= [
    for (final polygon in polygons)
      [
        for (final ring in polygon)
          [for (final p in ring) MapProjection.toWorld(p)],
      ],
  ];

  /// 그린 모양이 같은지. id 가 같으면 경계도 같다고 보고 색 · 선만 비교합니다.
  static bool sameList(List<MapShape> a, List<MapShape> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id ||
          a[i].fill != b[i].fill ||
          a[i].stroke != b[i].stroke ||
          a[i].strokeWidth != b[i].strokeWidth ||
          a[i].polygons.length != b[i].polygons.length) {
        return false;
      }
    }
    return true;
  }
}

/// 밖에서 카메라를 옮기는 손잡이.
class MapCanvasController {
  void Function(GeoBounds bounds, EdgeInsets? padding)? _fit;

  /// [bounds] 가 화면에 들어오게 부드럽게 옮깁니다.
  void fitBounds(GeoBounds bounds, {EdgeInsets? padding}) =>
      _fit?.call(bounds, padding);
}

/// 컨트롤러를 지도 구현에 붙였다 떼는 도우미(같은 라이브러리 안에서만 씁니다).
extension MapCanvasControllerBinding on MapCanvasController {
  void attach(void Function(GeoBounds, EdgeInsets?) fit) => _fit = fit;

  void detach(void Function(GeoBounds, EdgeInsets?) fit) {
    if (_fit == fit) _fit = null;
  }
}

/// 지도 한 장. 면([shapes])을 칠하고, 이름 라벨 · 핀은 [overlayBuilder] 가 돌려주는 위젯을
/// 그 위에 겹칩니다. 끌어서 이동, 두 손가락으로 확대 · 축소합니다.
///
/// Google Maps 키가 있으면(`ApiConfig.mapsEnabled`) 타일 지도 위에 면을 폴리곤으로 올리고
/// ([GoogleMapCanvas]), 없으면(테스트 포함) 배경 · 면을 직접 그립니다. 투영은 둘 다
/// [MapCamera](웹 메르카토르)라, 겹쳐 놓는 위젯은 어느 쪽이든 같은 카메라로 자리를 잡습니다.
class MapCanvas extends StatelessWidget {
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
    this.tiles,
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

  /// Google Maps 타일을 쓸지. null 이면 `ApiConfig.mapsEnabled`.
  final bool? tiles;

  /// 지금 설정으로 타일 지도를 쓰는지. 화면은 이 값으로 바다 · 이웃 지역 이름 같은
  /// 장식(타일이 대신 그려 주는 것)을 넣을지 정합니다.
  static bool get usesTiles => ApiConfig.mapsEnabled;

  @override
  Widget build(BuildContext context) {
    if (tiles ?? usesTiles) {
      return GoogleMapCanvas(
        bounds: bounds,
        fitKey: fitKey,
        padding: padding,
        controller: controller,
        shapes: shapes,
        overlayBuilder: overlayBuilder,
        onTapGeo: onTapGeo,
        maxZoomIn: maxZoomIn,
        maxZoomOut: maxZoomOut,
      );
    }
    return _PaintedMapCanvas(this);
  }
}

/// 키가 없을 때의 지도: 배경과 면을 CustomPaint 로 직접 그립니다.
class _PaintedMapCanvas extends StatefulWidget {
  const _PaintedMapCanvas(this.config);

  final MapCanvas config;

  @override
  State<_PaintedMapCanvas> createState() => _MapCanvasState();
}

class _MapCanvasState extends State<_PaintedMapCanvas>
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

  MapCanvas get _config => widget.config;

  @override
  void initState() {
    super.initState();
    _config.controller?.attach(_animateToBounds);
  }

  @override
  void didUpdateWidget(_PaintedMapCanvas old) {
    super.didUpdateWidget(old);
    if (old.config.controller != _config.controller) {
      old.config.controller?.detach(_animateToBounds);
      _config.controller?.attach(_animateToBounds);
    }
    if (old.config.fitKey != _config.fitKey && _size != Size.zero) {
      _animateToBounds(_config.bounds, null);
    }
  }

  @override
  void dispose() {
    _config.controller?.detach(_animateToBounds);
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

  void _animateToBounds(GeoBounds bounds, EdgeInsets? padding) {
    final from = _camera;
    if (from == null) return;
    final to = MapCamera.fit(
      bounds,
      _size,
      padding: padding ?? _config.padding,
      maxScale: _maxScale,
    );
    _animFrom = from;
    _animTo = to;
    _anim.forward(from: 0);
  }

  double get _maxScale => (_baseScale ?? 1) * _config.maxZoomIn;
  double get _minScale => (_baseScale ?? 1) / _config.maxZoomOut;

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
            _config.bounds,
            size,
            padding: _config.padding,
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
            onTapUp: _config.onTapGeo == null
                ? null
                : (d) => _config.onTapGeo!(cam.toGeo(d.localPosition)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: semantic.mapLandAlt),
                CustomPaint(
                  painter: _ShapePainter(cam, _config.shapes),
                  size: size,
                ),
                if (_config.overlayBuilder != null)
                  _config.overlayBuilder!(context, cam),
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
      for (final polygon in shape.world) {
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
      !MapShape.sameList(old.shapes, shapes);
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
