import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/explore.dart';
import '../map_markers.dart';
import '../map_projection.dart';
import 'map_canvas.dart';
import 'marker_bitmaps.dart';

/// 타일 위 장식을 덜어 낸 지도 스타일: 가게 · 관광지 같은 POI 와 대중교통 표시를 끕니다.
/// 라벨 · 핀은 앱이 마커로 올리므로 타일에는 지형 · 도로 · 지명만 남깁니다.
const _mapStyle =
    '[{"featureType":"poi","stylers":[{"visibility":"off"}]},'
    '{"featureType":"transit","stylers":[{"visibility":"off"}]}]';

LatLng _latLng(GeoPoint p) => LatLng(p.lat, p.lng);

/// [MapCanvas] 의 Google Maps 판. 면은 [Polygon] 으로, 라벨 · 핀은 위젯을 그린
/// 비트맵 [Marker] 로 올립니다([markersBuilder]). 마커는 지도와 한 몸으로 움직이므로
/// 끌거나 확대해도 흔들리지 않습니다.
///
/// 어느 것을 보여 주고 접을지는 화면 좌표가 있어야 정할 수 있어, 손을 뗀 뒤
/// (`onCameraIdle`)의 [MapCamera] 로 다시 계산해 마커를 바꿉니다.
///
/// [overlayBuilder] 는 `onCameraMove` 를 따라 위젯을 겹치는 옛 방식입니다(끌 때 한두
/// 프레임 늦음). [markersBuilder] 가 없을 때만 씁니다.
///
/// 회전 · 기울이기는 꺼 둡니다(겹침 계산이 북쪽 위 · 수직 시점을 가정하기 때문).
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
    this.markersBuilder,
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
  final List<MapMarkerSpec> Function(MapCamera camera)? markersBuilder;
  final ValueChanged<GeoPoint>? onTapGeo;
  final double maxZoomIn;
  final double maxZoomOut;

  @override
  State<GoogleMapCanvas> createState() => _GoogleMapCanvasState();
}

class _GoogleMapCanvasState extends State<GoogleMapCanvas> {
  GoogleMapController? _map;

  /// 지금 카메라. 겹친 위젯([GoogleMapCanvas.overlayBuilder])은 이것을 따라가고,
  /// 마커는 손을 뗀 뒤 이 값으로 다시 놓습니다. 지도가 움직일 때 지도 위젯까지 다시
  /// 그리지 않도록 따로 둡니다.
  final _camera = ValueNotifier<MapCamera?>(null);
  Size _size = Size.zero;
  MinMaxZoomPreference _zoomLimits = MinMaxZoomPreference.unbounded;
  CameraPosition? _initial;
  Set<Polygon> _polygons = const {};

  final _bitmaps = MarkerBitmapCache();
  Set<Marker> _markers = const {};

  /// 마커를 다시 놓을 때마다 올라갑니다. 비트맵을 그리는 사이 더 새 요청이 오면
  /// 늦게 끝난 옛 결과는 버립니다.
  int _markerGen = 0;

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
    // 고른 것 · 점수 · 핀 목록이 바뀌었을 수 있으니 지금 카메라로 다시 놓습니다.
    _syncMarkers(building: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bitmaps.configure(
      view: View.of(context),
      theme: Theme.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      pixelRatio: MediaQuery.devicePixelRatioOf(context),
    );
    _syncMarkers(building: true);
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

  /// [GoogleMapCanvas.markersBuilder] 가 지금 카메라로 정한 마커를 지도에 올립니다.
  /// 처음 보는 그림은 비트맵을 그린 뒤에 한꺼번에 바꿉니다(그동안은 앞의 마커 유지).
  ///
  /// [building] 은 빌드 · 레이아웃 도중에 부를 때 true 로 줍니다(곧 다시 그려지므로
  /// `setState` 를 하지 않음).
  void _syncMarkers({bool building = false}) {
    final build = widget.markersBuilder;
    final camera = _camera.value;
    if (build == null || camera == null || _size.isEmpty) return;
    final specs = build(camera.copyWith(size: _size));
    final gen = ++_markerGen;

    final missing = {
      for (final s in specs)
        if (_bitmaps.peek(s.visual) == null) s.visual,
    };
    if (missing.isEmpty) {
      final next = _toMarkers(specs);
      if (building) {
        _markers = next;
      } else {
        setState(() => _markers = next);
      }
      return;
    }
    Future.wait(missing.map(_bitmaps.get)).then((_) {
      if (!mounted || gen != _markerGen) return;
      // 그리는 사이 캐시가 비워졌으면(테마 변경 등) 다시 맞춥니다.
      if (specs.any((s) => _bitmaps.peek(s.visual) == null)) {
        _syncMarkers();
        return;
      }
      setState(() => _markers = _toMarkers(specs));
    });
  }

  Set<Marker> _toMarkers(List<MapMarkerSpec> specs) => {
    for (final s in specs)
      if (_bitmaps.peek(s.visual) case final bitmap?)
        Marker(
          markerId: MarkerId(s.id),
          position: _latLng(s.at),
          icon: bitmap.icon,
          anchor: markerAnchor(s.visual, bitmap.size),
          alpha: s.alpha,
          zIndexInt: s.zIndex,
          // 누르면 지도가 마커로 옮겨 가는 기본 동작을 막습니다.
          consumeTapEvents: true,
          onTap: s.onTap,
        ),
  };

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
        if (_size != size) {
          // 처음이거나 지도 크기가 바뀌면(아래 시트 높이 변화) 겹침을 다시 풉니다.
          _size = size;
          _syncMarkers(building: true);
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              initialCameraPosition: _initial!,
              onMapCreated: (c) => _map = c,
              onCameraMove: _onCameraMove,
              onCameraIdle: _syncMarkers,
              onTap: widget.onTapGeo == null
                  ? null
                  : (p) => widget.onTapGeo!(
                      GeoPoint(lat: p.latitude, lng: p.longitude),
                    ),
              polygons: _polygons,
              markers: _markers,
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
            if (widget.overlayBuilder != null && widget.markersBuilder == null)
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
