import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 카테고리 스트립 한 칸 (Figma CategoryTab, M-01).
/// 아이콘 24 + 라벨 12, 선택되면 잉크색 + 2px 밑줄.
class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.onSurface : scheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: active,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s1,
            AppSpacing.s2,
            AppSpacing.s1,
            0,
          ),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(icon, size: 24, color: color),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.captionXsMedium.copyWith(color: color),
                ),
                const SizedBox(height: 6),
                Container(height: 2, color: active ? scheme.onSurface : null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
