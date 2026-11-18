import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/explore.dart';
import '../../map/widgets/map_canvas.dart';

/// 위치 카드 (Figma Location). 위에 미니맵, 아래에 접근 설명과 시군구 다른 동네 링크.
///
/// 미니맵은 Google Maps 키가 있고 동 위치([center])를 알면 움직이지 않는 지도 위에
/// 동 이름 배지를, 아니면 회색 상자 위에 배지만 그립니다.
class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.dongName,
    required this.accessNote,
    required this.sigunguName,
    this.center,
    this.onOtherDongs,
  });

  final String dongName;

  /// 동 대표 점(`GET /api/explore/sigungu/{id}/pins` 의 center). 모르면 null.
  final GeoPoint? center;

  /// 예: `강릉시 북부 · 바닷가 0.0km`
  final String accessNote;
  final String sigunguName;
  final VoidCallback? onOtherDongs;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MiniMap(dongName: dongName, center: center),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s3,
            ),
            child: Row(
              spacing: AppSpacing.s2,
              children: [
                Expanded(
                  child: Text(
                    accessNote,
                    style: AppTextStyles.bodySm.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onOtherDongs,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 2,
                    children: [
                      Text(
                        '$sigunguName 다른 동네',
                        style: AppTextStyles.bodySmMedium.copyWith(
                          color: scheme.primary,
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                        color: scheme.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMap extends StatelessWidget {
  const _MiniMap({required this.dongName, this.center});

  final String dongName;
  final GeoPoint? center;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final at = center;
    final showMap = at != null && MapCanvas.usesTiles;

    return Semantics(
      label: showMap ? '$dongName 위치 지도' : '$dongName 위치. 지도는 준비 중',
      excludeSemantics: true,
      child: SizedBox(
        height: 140,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (showMap)
              // 스크롤 안에 있으므로 손가락은 지도에 주지 않습니다(보기 전용).
              IgnorePointer(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(at.lat, at.lng),
                    zoom: 13,
                  ),
                  liteModeEnabled: true,
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                ),
              )
            else
              ColoredBox(color: colors.bgSubtle),
            Center(child: _badge(scheme)),
          ],
        ),
      ),
    );
  }

  Widget _badge(ColorScheme scheme) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: scheme.primary,
      borderRadius: AppRadius.fullAll,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Icon(LucideIcons.mapPin, size: 14, color: scheme.onPrimary),
        Text(
          dongName,
          style: AppTextStyles.captionXsBold.copyWith(color: scheme.onPrimary),
        ),
      ],
    ),
  );
}
