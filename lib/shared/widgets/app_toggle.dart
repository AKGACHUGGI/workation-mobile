import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 켜짐 · 꺼짐 토글 44×24 (Figma toggle/on · off). 켜면 brand, 끄면 회색.
class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.onChanged,
  });

  final bool value;

  /// 스크린 리더 이름. 예: `가기 좋은 달 알림`
  final String semanticLabel;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      toggled: value,
      label: semanticLabel,
      enabled: onChanged != null,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onChanged == null ? null : () => onChanged!(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 44,
          height: 24,
          padding: const EdgeInsets.all(2),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: value ? scheme.primary : scheme.outline,
            borderRadius: AppRadius.fullAll,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              shape: BoxShape.circle,
            ),
            child: const SizedBox.square(dimension: 20),
          ),
        ),
      ),
    );
  }
}
