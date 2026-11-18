import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/explore.dart';
import '../map_projection.dart';
import 'map_canvas.dart';

/// 타일 위 장식을 덜어 낸 지도 스타일: 가게 · 관광지 같은 POI 와 대중교통 표시를 끕니다.
/// 라벨 · 핀은 앱이 겹쳐 그리므로 타일에는 지형 · 도로 · 지명만 남깁니다.
const _mapStyle =
    '[{"featureType":"poi","stylers":[{"visibility":"off"}]},'
    '{"featureType":"transit","stylers":[{"visibility":"off"}]}]';

LatLng _latLng(GeoPoint p) => LatLng(p.lat, p.lng);

/// [MapCanvas] 의 Google Maps 판. 면은 [Polygon] 으로 올리고, 라벨 · 핀은
/// 직접 그리는 지도와 똑같이 [MapCamera] 로 자리를 잡아 지도 위에 위젯으로 겹칩니다.
///
/// 회전 · 기울이기는 꺼 둡니다(겹친 위젯이 북쪽 위 · 수직 시점을 가정하기 때문).
/// 직접 쓰지 말고 [MapCanvas] 를 씁니다.
class GoogleMapCanvas extends StatefulWidget {
  const GoogleMapCanvas({
    super.key,
    required this.bounds,
    this.fitKey,
    required this.padding,
    this.controller,
    required this.shapes,
    this.overlayBuilder,
    this.onTapGeo,
    required this.maxZoomIn,
    required this.maxZoomOut,
  });

  final GeoBounds bounds;
  final Object? fitKey;
  final EdgeInsets padding;
  final MapCanvasController? controller;
  final List<MapShape> shapes;
  final Widget Function(BuildContext context, MapCamera camera)? overlayBuilder;
  final ValueChanged<GeoPoint>? onTapGeo;
  final double maxZoomIn;
  final double maxZoomOut;

  @override
  State<GoogleMapCanvas> createState() => _GoogleMapCanvasState();
}

class _GoogleMapCanvasState extends State<GoogleMapCanvas> {
  GoogleMapController? _map;

  /// 겹친 위젯이 따라가는 카메라. 지도가 움직일 때 지도 위젯은 다시 그리지 않고
  /// 겹친 위젯만 다시 그리도록 따로 둡니다.
  final _camera = ValueNotifier<MapCamera?>(null);
  Size _size = Size.zero;
  MinMaxZoomPreference _zoomLimits = MinMaxZoomPreference.unbounded;
  CameraPosition? _initial;
  Set<Polygon> _polygons = const {};

  @override
  void initState() {
    super.initState();
    widget.controller?.attach(_fit);
    _polygons = _toPolygons(widget.shapes);
  }

  @override
  void didUpdateWidget(GoogleMapCanvas old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?.detach(_fit);
      widget.controller?.attach(_fit);
    }
    if (!MapShape.sameList(old.shapes, widget.shapes)) {
      _polygons = _toPolygons(widget.shapes);
    }
    if (old.fitKey != widget.fitKey) _fit(widget.bounds, null);
  }

  @override
  void dispose() {
    widget.controller?.detach(_fit);
    _camera.dispose();
    super.dispose();
  }

  static Set<Polygon> _toPolygons(List<MapShape> shapes) => {
    for (var i = 0; i < shapes.length; i++)
      for (var j = 0; j < shapes[i].polygons.length; j++)
        if (shapes[i].polygons[j].isNotEmpty)
          Polygon(
            polygonId: PolygonId('${shapes[i].id}#$j'),
            points: [for (final p in shapes[i].polygons[j].first) _latLng(p)],
            holes: [
              for (final ring in shapes[i].polygons[j].skip(1))
                [for (final p in ring) _latLng(p)],
            ],
            fillColor: shapes[i].fill ?? Colors.transparent,
            strokeColor: shapes[i].stroke ?? Colors.transparent,
            strokeWidth: shapes[i].stroke == null
                ? 0
                : math.max(1, shapes[i].strokeWidth.round()),
            zIndex: i,
          ),
  };

  static CameraPosition _position(MapCamera camera) =>
      CameraPosition(target: _latLng(camera.target), zoom: camera.zoom);

  void _fit(GeoBounds bounds, EdgeInsets? padding) {
    final map = _map;
    if (map == null || _size.isEmpty) return;
    final camera = MapCamera.fit(
      bounds,
      _size,
      padding: padding ?? widget.padding,
      maxScale: MapCamera.scaleForZoom(_zoomLimits.maxZoom ?? 21),
    );
    map.animateCamera(
      CameraUpdate.newCameraPosition(_position(camera)),
      duration: const Duration(milliseconds: 350),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _camera.value = MapCamera.fromZoom(
      _size,
      GeoPoint(lat: position.target.latitude, lng: position.target.longitude),
      position.zoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (_initial == null) {
          // 처음 크기에 맞춘 줌을 기준으로 확대 · 축소 한도를 정합니다.
          final camera = MapCamera.fit(
            widget.bounds,
            size,
            padding: widget.padding,
          );
          final base = camera.zoom;
          _zoomLimits = MinMaxZoomPreference(
            base - math.log(widget.maxZoomOut) / math.ln2,
            base + math.log(widget.maxZoomIn) / math.ln2,
          );
          _initial = _position(camera);
          _camera.value = camera; // 아직 듣는 위젯이 없을 때라 빌드 중에 바꿔도 됩니다
        }
        _size = size;

        return Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              initialCameraPosition: _initial!,
              onMapCreated: (c) => _map = c,
              onCameraMove: _onCameraMove,
              onTap: widget.onTapGeo == null
                  ? null
                  : (p) => widget.onTapGeo!(
                      GeoPoint(lat: p.latitude, lng: p.longitude),
                    ),
              polygons: _polygons,
              minMaxZoomPreference: _zoomLimits,
              style: _mapStyle,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              buildingsEnabled: false,
              indoorViewEnabled: false,
            ),
            if (widget.overlayBuilder != null)
              ValueListenableBuilder<MapCamera?>(
                valueListenable: _camera,
                builder: (context, camera, _) => camera == null
                    ? const SizedBox.shrink()
                    : widget.overlayBuilder!(
                        context,
                        camera.copyWith(size: size),
                      ),
              ),
          ],
        );
      },
    );
  }
}
