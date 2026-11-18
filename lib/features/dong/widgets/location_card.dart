import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';

/// 위치 카드 (Figma Location). 위에 미니맵, 아래에 접근 설명과 시군구 다른 동네 링크.
///
/// TODO: 지도 연동은 M-02 작업이 맡습니다. 그때 [_MiniMapPlaceholder] 를 실제 지도로 바꿉니다.
class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.dongName,
    required this.accessNote,
    required this.sigunguName,
    this.onOtherDongs,
  });

  final String dongName;

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
          _MiniMapPlaceholder(dongName: dongName),
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

class _MiniMapPlaceholder extends StatelessWidget {
  const _MiniMapPlaceholder({required this.dongName});

  final String dongName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return Semantics(
      label: '$dongName 위치. 지도는 준비 중',
      excludeSemantics: true,
      child: Container(
        height: 140,
        alignment: Alignment.center,
        color: colors.bgSubtle,
        child: Container(
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
                style: AppTextStyles.captionXsBold.copyWith(
                  color: scheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
