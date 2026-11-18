import 'package:flutter/material.dart';

import '../../../data/models/explore.dart';
import '../../../shared/widgets/type_bar.dart';
import '../../region/widgets/section_card.dart';

/// 워케이션 유형 카드 (Figma WorkationTypes). 4종 막대 · 점수 · 근거 문구, 1위만 브랜드 색.
class WorkationTypesCard extends StatelessWidget {
  const WorkationTypesCard({super.key, required this.types});

  /// 점수 높은 순
  final List<TypeScore> types;

  /// 근거 끝의 괄호 설명은 줄이 길어져 떼어 냅니다. 예: `한산한 달 7개(성수기보다 …)` → `한산한 달 7개`
  static String shortReason(String reason) =>
      reason.replaceFirst(RegExp(r'\s*\([^)]*\)\s*$'), '');

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '워케이션 유형',
      caption: '유형별 적합도 · 0~100',
      children: [
        for (final (i, t) in types.indexed)
          TypeBar(
            name: t.name,
            score: t.score,
            highlight: i == 0,
            reason: t.reason == null ? null : shortReason(t.reason!),
          ),
      ],
    );
  }
}
