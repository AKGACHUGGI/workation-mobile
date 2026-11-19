import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/widgets/area_label.dart';
import '../../../shared/widgets/dong_pin.dart';
import '../map_markers.dart';

/// 마커 그림을 화면에 겹치던 것과 같은 위젯으로 만듭니다.
Widget markerWidget(MarkerVisual visual) => switch (visual) {
  PinVisual(:final name, :final tag, :final selected) => DongPin(
    name: name,
    tag: tag,
    state: selected ? DongPinState.selected : DongPinState.normal,
  ),
  LabelVisual(:final name, :final summary, :final state) => AreaLabel(
    name: name,
    summary: summary,
    state: state,
  ),
  ClusterVisual(:final count) => PinClusterPill(count: count),
};

/// 위젯을 화면 밖에서 그린 PNG. [size] 는 논리 px 크기입니다.
class RasterizedWidget {
  const RasterizedWidget(this.png, this.size);

  final Uint8List png;
  final Size size;
}

/// [widget] 을 화면에 올리지 않고 따로 만든 렌더 트리에서 그려 PNG 로 돌려줍니다.
///
/// 위젯은 [theme] · [textScaler] 안에서 제 크기대로 놓이고, 둘레에 [padding] 만큼 투명한
/// 여백(그림자 자리)을 둡니다. [pixelRatio] 는 기기 픽셀 비율입니다.
///
/// 서체(Noto Sans KR · 아이콘)는 앱에 묶여 있는 에셋이라 따로 기다리지 않아도 됩니다.
Future<RasterizedWidget> rasterizeWidget(
  Widget widget, {
  required ui.FlutterView view,
  required ThemeData theme,
  required double pixelRatio,
  TextScaler textScaler = TextScaler.noScaling,
  double padding = 0,
  Size maxSize = const Size(480, 240),
}) async {
  final boundary = RenderRepaintBoundary();
  final renderView = RenderView(
    view: view,
    configuration: ViewConfiguration(
      logicalConstraints: BoxConstraints.tight(maxSize),
      physicalConstraints: BoxConstraints.tight(maxSize * pixelRatio),
      devicePixelRatio: pixelRatio,
    ),
    child: RenderPositionedBox(child: boundary),
  );
  final pipelineOwner = PipelineOwner()..rootNode = renderView;
  renderView.prepareInitialFrame();

  final focusManager = FocusManager();
  final buildOwner = BuildOwner(focusManager: focusManager);
  final root = RenderObjectToWidgetAdapter<RenderBox>(
    container: boundary,
    child: MediaQuery(
      data: MediaQueryData(
        size: maxSize,
        devicePixelRatio: pixelRatio,
        textScaler: textScaler,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Theme(
          data: theme,
          child: Padding(padding: EdgeInsets.all(padding), child: widget),
        ),
      ),
    ),
  ).attachToRenderTree(buildOwner);

  try {
    buildOwner
      ..buildScope(root)
      ..finalizeTree();
    pipelineOwner
      ..flushLayout()
      ..flushCompositingBits()
      ..flushPaint();

    final size = boundary.size;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return RasterizedWidget(data!.buffer.asUint8List(), size);
    } finally {
      image.dispose();
    }
  } finally {
    // 따로 만든 트리를 걷어 냅니다.
    RenderObjectToWidgetAdapter<RenderBox>(container: boundary)
        .attachToRenderTree(buildOwner, root);
    buildOwner
      ..buildScope(root)
      ..finalizeTree();
    pipelineOwner.rootNode = null;
    renderView.dispose();
    focusManager.dispose();
  }
}

/// 마커 아이콘과 그 논리 크기.
class MarkerBitmap {
  const MarkerBitmap(this.icon, this.size);

  final BitmapDescriptor icon;
  final Size size;
}

/// 마커 그림 → 비트맵 캐시. 같은 그림은 한 번만 그립니다.
///
/// 테마 · 글자 크기 · 픽셀 비율이 바뀌면 [configure] 가 캐시를 비웁니다.
class MarkerBitmapCache {
  MarkerBitmapCache({this.rasterize = rasterizeWidget});

  /// 테스트에서 바꿔 끼울 수 있는 그리기 함수
  final Future<RasterizedWidget> Function(
    Widget widget, {
    required ui.FlutterView view,
    required ThemeData theme,
    required double pixelRatio,
    TextScaler textScaler,
    double padding,
    Size maxSize,
  })
  rasterize;

  final _ready = <MarkerVisual, MarkerBitmap>{};
  final _pending = <MarkerVisual, Future<MarkerBitmap>>{};

  ui.FlutterView? _view;
  ThemeData? _theme;
  TextScaler _textScaler = TextScaler.noScaling;
  double _pixelRatio = 1;

  /// 캐시를 비울 때마다 올라갑니다. 그리던 중에 설정이 바뀌면 결과를 버립니다.
  int _epoch = 0;

  /// 그릴 환경을 알려 줍니다. 그림이 달라지는 값이 바뀌면 캐시를 비웁니다.
  void configure({
    required ui.FlutterView view,
    required ThemeData theme,
    required TextScaler textScaler,
    required double pixelRatio,
  }) {
    // 테마는 색 구성만 견줍니다(`AppTheme.light` 는 부를 때마다 새로 만들어져,
    // 통째로 견주면 앱이 다시 그려질 때마다 캐시가 비워집니다).
    if (_theme?.colorScheme != theme.colorScheme ||
        _textScaler != textScaler ||
        _pixelRatio != pixelRatio) {
      clear();
    }
    _view = view;
    _theme = theme;
    _textScaler = textScaler;
    _pixelRatio = pixelRatio;
  }

  void clear() {
    _epoch++;
    _ready.clear();
    _pending.clear();
  }

  /// 이미 그려 둔 비트맵. 없으면 null.
  MarkerBitmap? peek(MarkerVisual visual) => _ready[visual];

  /// 비트맵을 돌려줍니다. 없으면 그리고, 같은 그림을 그리는 중이면 그 결과를 기다립니다.
  Future<MarkerBitmap> get(MarkerVisual visual) {
    final ready = _ready[visual];
    if (ready != null) return Future.value(ready);
    return _pending[visual] ??= _draw(visual);
  }

  Future<MarkerBitmap> _draw(MarkerVisual visual) async {
    final epoch = _epoch;
    try {
      final raster = await rasterize(
        markerWidget(visual),
        view: _view!,
        theme: _theme!,
        pixelRatio: _pixelRatio,
        textScaler: _textScaler,
        padding: kMarkerBitmapPadding,
      );
      final bitmap = MarkerBitmap(
        BitmapDescriptor.bytes(
          raster.png,
          width: raster.size.width,
          height: raster.size.height,
        ),
        raster.size,
      );
      if (epoch == _epoch) _ready[visual] = bitmap;
      return bitmap;
    } finally {
      // 실패해도 다음에 다시 그릴 수 있게 비워 둡니다.
      if (epoch == _epoch) _pending.remove(visual);
    }
  }
}
