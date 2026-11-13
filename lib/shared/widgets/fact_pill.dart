import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 사실 종류. 점 색을 정합니다 (웹 explore/fact/* 와 같음).
enum FactKind { type, coast, life }

/// 색 점 + 사실 이름 (M-02 ① 동 목록). 예: 장기체류형 · 바닷가 · 관광지.
class FactPill extends StatelessWidget {
  const FactPill(this.label, {super.key, required this.kind});

  final String label;
  final FactKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final dot = switch (kind) {
      FactKind.type => semantic.factType,
      FactKind.coast => semantic.factCoast,
      FactKind.life => semantic.factLife,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: semantic.bgSubtle,
        borderRadius: AppRadius.fullAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(label, style: AppTextStyles.captionXsMedium),
        ],
      ),
    );
  }
}
