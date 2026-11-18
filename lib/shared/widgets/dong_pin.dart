import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';

/// 관광공사 동 태그 묶음. 핀 아이콘 바탕색을 정합니다 (Figma 변수 explore/group/*).
enum PinTagGroup { trait, work, stay, rest, life }

/// 백엔드 PoiTag 이름 → 묶음. 아이콘이 있는 태그만 들어 있습니다.
const kPinTagGroup = <String, PinTagGroup>{
  'coast': PinTagGroup.trait,
  'city': PinTagGroup.trait,
  'cafe': PinTagGroup.work,
  'library': PinTagGroup.work,
  'long_stay': PinTagGroup.stay,
  'resort': PinTagGroup.stay,
  'beach': PinTagGroup.rest,
  'park': PinTagGroup.rest,
  'mountain': PinTagGroup.rest,
  'island': PinTagGroup.rest,
  'surf': PinTagGroup.rest,
  'market': PinTagGroup.life,
};

const kPinTagIcon = <String, IconData>{
  'coast': LucideIcons.map,
  'city': LucideIcons.building2,
  'cafe': LucideIcons.laptop,
  'library': LucideIcons.bookOpen,
  'long_stay': LucideIcons.bedDouble,
  'resort': LucideIcons.hotel,
  'beach': LucideIcons.waves,
  'park': LucideIcons.trees,
  'mountain': LucideIcons.mountain,
  'island': LucideIcons.treePalm,
  'surf': LucideIcons.sailboat,
  'market': LucideIcons.store,
};

enum DongPinState {
  /// 기본 — 흰 알약
  normal,

  /// 고른 핀 — 브랜드 색 알약
  selected,

  /// 다른 핀이 선택돼 흐려진 핀
  dimmed,
}

/// 행정동 이름 핀 (Figma Explore/DongPin). 대표 태그 아이콘 1개 + 이름 + 꼬리 + 위치 점.
///
/// 위젯의 맨 아래 가운데가 지도 위 위치입니다(점의 중심은 아래에서 4px).
class DongPin extends StatelessWidget {
  const DongPin({
    super.key,
    required this.name,
    this.tag,
    this.state = DongPinState.normal,
    this.onTap,
  });

  final String name;

  /// 대표 태그 이름. 예: `cafe`. 없거나 모르는 태그면 아이콘 없이 이름만 그립니다.
  final String? tag;
  final DongPinState state;
  final VoidCallback? onTap;

  /// 위치 점 지름 · 꼬리 높이. 지도에 놓을 때 계산에 씁니다.
  static const dotSize = 8.0;
  static const tailHeight = 6.0;

  Color _groupColor(ThemeData theme, PinTagGroup g) {
    final semantic = theme.extension<AppSemanticColors>()!;
    return switch (g) {
      PinTagGroup.trait => theme.colorScheme.onSurfaceVariant,
      PinTagGroup.work => theme.colorScheme.primary,
      PinTagGroup.stay => semantic.factCoast,
      PinTagGroup.rest => semantic.signalGood,
      PinTagGroup.life => semantic.gradeB.fg,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semantic = theme.extension<AppSemanticColors>()!;
    final selected = state == DongPinState.selected;
    final icon = tag == null ? null : kPinTagIcon[tag];
    final group = tag == null ? null : kPinTagGroup[tag];
    final fill = selected ? scheme.primary : scheme.surface;

    final pin = Semantics(
      button: true,
      selected: selected,
      label: name,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(icon == null ? 12 : 5, 5, 12, 5),
              decoration: BoxDecoration(
                color: fill,
                borderRadius: AppRadius.fullAll,
                border: Border.all(
                  color: selected ? scheme.primary : scheme.outlineVariant,
                ),
                boxShadow: AppShadows.pin,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  if (icon != null)
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: _groupColor(theme, group!),
                        shape: BoxShape.circle,
                        border: Border.all(color: scheme.surface, width: 2),
                      ),
                      child: Icon(icon, size: 14, color: scheme.onPrimary),
                    ),
                  Text(
                    name,
                    style: AppTextStyles.captionXsBold.copyWith(
                      color: selected ? scheme.onPrimary : scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            CustomPaint(
              size: const Size(10, tailHeight),
              painter: _TailPainter(fill),
            ),
            Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: selected ? scheme.primary : semantic.textTertiary,
                shape: BoxShape.circle,
                border: Border.all(color: scheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
    return state == DongPinState.dimmed
        ? Opacity(opacity: 0.6, child: pin)
        : pin;
  }
}

class _TailPainter extends CustomPainter {
  const _TailPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TailPainter old) => old.color != color;
}

/// 겹쳐서 접힌 핀 묶음 필 (Figma cluster). 예: `11곳 더`. 누르면 지도가 확대됩니다.
class PinClusterPill extends StatelessWidget {
  const PinClusterPill({super.key, required this.count, this.onTap});

  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final label = '$count곳 더';

    return Semantics(
      button: true,
      label: '$label 보기',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: semantic.brandSoft,
            borderRadius: AppRadius.fullAll,
            border: Border.all(color: semantic.brandSoftBorder),
          ),
          child: Text(
            label,
            style: AppTextStyles.captionXsMedium.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
