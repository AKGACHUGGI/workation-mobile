import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

enum AreaLabelState {
  /// 기본 — 흰 알약
  normal,

  /// 고른 구역 — 잉크 알약
  selected,

  /// 집계 제외 — 회색 점선 알약
  excluded,
}

/// 지도 위 구역 이름 라벨 (Figma Explore/AreaLabel). 이름 + 한 줄 요약.
/// 예: `강릉시` · `동 21 · 카페 · 해수욕장`.
class AreaLabel extends StatelessWidget {
  const AreaLabel({
    super.key,
    required this.name,
    this.summary,
    this.state = AreaLabelState.normal,
    this.onTap,
  });

  final String name;
  final String? summary;
  final AreaLabelState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semantic = theme.extension<AppSemanticColors>()!;
    final selected = state == AreaLabelState.selected;
    final excluded = state == AreaLabelState.excluded;

    final nameColor = selected
        ? scheme.onSecondary
        : excluded
        ? semantic.textTertiary
        : scheme.onSurface;
    final summaryColor = selected
        ? scheme.onSecondary.withValues(alpha: 0.85)
        : excluded
        ? semantic.textTertiary
        : scheme.onSurfaceVariant;

    final body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Text(
            name,
            style: AppTextStyles.captionXsBold.copyWith(color: nameColor),
          ),
          if (summary != null)
            Text(
              summary!,
              style: AppTextStyles.captionXs.copyWith(color: summaryColor),
            ),
        ],
      ),
    );

    final decorated = excluded
        ? CustomPaint(
            foregroundPainter: _DashedPillBorder(scheme.outlineVariant),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: semantic.bgSurfaceStrong,
                borderRadius: AppRadius.fullAll,
              ),
              child: body,
            ),
          )
        : DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? scheme.secondary : scheme.surface,
              borderRadius: AppRadius.fullAll,
              boxShadow: AppShadows.cardFloat,
            ),
            child: body,
          );

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: summary == null ? name : '$name $summary',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: decorated,
      ),
    );
  }
}

class _DashedPillBorder extends CustomPainter {
  const _DashedPillBorder(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      (Offset.zero & size).deflate(0.5),
      Radius.circular(size.height / 2),
    );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 6) {
        canvas.drawPath(metric.extractPath(d, d + 3), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPillBorder old) => old.color != color;
}
