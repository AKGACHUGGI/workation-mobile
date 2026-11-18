import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/dong_detail.dart';

/// 24시간 붐빔 곡선 카드 (Figma HourlyCurve). 주중 · 주말 두 선을 겹쳐 그리고
/// 고른 쪽([weekend])을 진하게 그립니다. 아래에는 그 쪽의 피크 · 가장 한산한 시각을 보여줍니다.
/// 차트는 패키지 없이 직접 그립니다(월별 혼잡 막대와 같은 방식).
class HourlyCurveCard extends StatelessWidget {
  const HourlyCurveCard({
    super.key,
    required this.hourly,
    required this.peaks,
    required this.weekend,
  });

  final Hourly hourly;
  final Peaks peaks;

  /// false 면 주중, true 면 주말
  final bool weekend;

  static const chartHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final peak = weekend ? peaks.weekend : peaks.weekday;
    final dayLabel = weekend ? '주말' : '주중';
    final tertiary = AppTextStyles.captionXs.copyWith(
      color: colors.textTertiary,
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('24시간 붐빔 곡선', style: AppTextStyles.headingLg),
              ),
              Text('보행인구 · 최대 시간대 = 100', style: tertiary),
            ],
          ),
          Row(
            spacing: AppSpacing.s4,
            children: [
              _Legend(color: colors.chartWeekday, label: '주중'),
              _Legend(color: colors.chartWeekend, label: '주말'),
            ],
          ),
          Semantics(
            label:
                '24시간 붐빔 곡선. $dayLabel 피크 ${peak.peakHour}시, '
                '가장 한산 ${peak.lowHour}시 ${peak.lowValue}',
            excludeSemantics: true,
            child: SizedBox(
              height: chartHeight,
              child: CustomPaint(
                size: Size.infinite,
                painter: _CurvePainter(
                  hourly: hourly,
                  weekend: weekend,
                  weekdayColor: colors.chartWeekday,
                  weekendColor: colors.chartWeekend,
                  gridColor: colors.chartGrid,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final h in const ['0시', '6시', '12시', '18시', '23시'])
                Text(h, style: tertiary),
            ],
          ),
          Row(
            spacing: AppSpacing.s3,
            children: [
              Expanded(
                child: _Fact(
                  icon: LucideIcons.mapPin,
                  label: '$dayLabel 피크',
                  value: '${peak.peakHour}시 · 100',
                ),
              ),
              Expanded(
                child: _Fact(
                  icon: LucideIcons.moon,
                  label: '가장 한산',
                  value: '${peak.lowHour}시 · ${peak.lowValue}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          label,
          style: AppTextStyles.captionXs.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s2,
      ),
      decoration: BoxDecoration(
        color: colors.bgSubtle,
        borderRadius: AppRadius.lgAll,
      ),
      child: Row(
        spacing: AppSpacing.s2,
        children: [
          Icon(icon, size: 16, color: scheme.onSurfaceVariant),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.captionXs.copyWith(
                    color: colors.textTertiary,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 두 선을 부드럽게 이어 그립니다. y 는 0~100 을 높이에 맞춥니다.
class _CurvePainter extends CustomPainter {
  const _CurvePainter({
    required this.hourly,
    required this.weekend,
    required this.weekdayColor,
    required this.weekendColor,
    required this.gridColor,
  });

  final Hourly hourly;
  final bool weekend;
  final Color weekdayColor;
  final Color weekendColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    const pad = 3.0;
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 0; i <= 4; i++) {
      final y = pad + (size.height - pad * 2) * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    void line(List<int> values, Color color, bool selected) {
      if (values.length < 2) return;
      final points = [
        for (final (i, v) in values.indexed)
          Offset(
            size.width * i / (values.length - 1),
            lerpDouble(size.height - pad, pad, v.clamp(0, 100) / 100)!,
          ),
      ];
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (var i = 0; i < points.length - 1; i++) {
        final p0 = i == 0 ? points[i] : points[i - 1];
        final p1 = points[i];
        final p2 = points[i + 1];
        final p3 = i + 2 < points.length ? points[i + 2] : p2;
        path.cubicTo(
          p1.dx + (p2.dx - p0.dx) / 6,
          p1.dy + (p2.dy - p0.dy) / 6,
          p2.dx - (p3.dx - p1.dx) / 6,
          p2.dy - (p3.dy - p1.dy) / 6,
          p2.dx,
          p2.dy,
        );
      }
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = selected ? 2.5 : 1.5
          ..color = selected ? color : color.withValues(alpha: 0.35),
      );
    }

    // 고른 쪽을 나중에 그려 위에 오게 합니다.
    if (weekend) {
      line(hourly.weekday, weekdayColor, false);
      line(hourly.weekend, weekendColor, true);
    } else {
      line(hourly.weekend, weekendColor, false);
      line(hourly.weekday, weekdayColor, true);
    }
  }

  @override
  bool shouldRepaint(_CurvePainter old) =>
      old.hourly != hourly ||
      old.weekend != weekend ||
      old.weekdayColor != weekdayColor ||
      old.weekendColor != weekendColor ||
      old.gridColor != gridColor;
}
