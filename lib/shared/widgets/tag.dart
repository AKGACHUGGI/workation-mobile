import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

enum TagTone { neutral, brand }

/// 속성 태그 (Figma Tag). 해안 · 산간 · 도시, 생활권 · 관광지, AI 조건 등.
class Tag extends StatelessWidget {
  const Tag(this.label, {super.key, this.tone = TagTone.neutral});

  final String label;
  final TagTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brand = tone == TagTone.brand;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: brand ? scheme.primaryContainer : scheme.surfaceContainerLow,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.captionXsMedium.copyWith(
          color: brand ? scheme.primary : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
