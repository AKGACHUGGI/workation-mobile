import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';

/// 사진 올리기 타일 (Figma PhotoUploadTile). 120×90 점선 상자. 올리려면 로그인이 필요합니다.
class PhotoUploadTile extends StatelessWidget {
  const PhotoUploadTile({super.key, this.label = '이달의 사진 올리기', this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: CustomPaint(
          foregroundPainter: _DashedBorderPainter(
            color: scheme.outline,
            radius: AppRadius.lg,
          ),
          child: Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: colors.bgSubtle,
              borderRadius: AppRadius.lgAll,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.s1,
              children: [
                Icon(
                  LucideIcons.camera,
                  size: 20,
                  color: scheme.onSurfaceVariant,
                ),
                Text(
                  label,
                  style: AppTextStyles.captionXsMedium.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(0.5),
          Radius.circular(radius),
        ),
      );
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
        d += 7;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}
