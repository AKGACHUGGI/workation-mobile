import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 조건 선택 칩 (Figma Chip). 선택 = 잉크 배경 + 흰 글자, 브랜드 색은 쓰지 않습니다.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.secondary : scheme.surface,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? scheme.secondary : scheme.outlineVariant,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: 10,
            ),
            child: Text(
              label,
              style: AppTextStyles.bodySmMedium.copyWith(
                color: selected ? scheme.onSecondary : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 가로로 스크롤되는 칩 줄. 화면 좌우 여백 밖으로 흘러 나갑니다.
class AppChipRow extends StatelessWidget {
  const AppChipRow({super.key, required this.children, this.padding});

  final List<Widget> children;

  /// 스크롤 영역 안쪽 여백. 기본은 좌우 16.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Row(spacing: AppSpacing.s2, children: children),
    );
  }
}
