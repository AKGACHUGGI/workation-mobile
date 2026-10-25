import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// M-01 홈. 아래는 토큰 적용 확인용 샘플이며 실제 화면 구현 시 교체합니다.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return Scaffold(
      appBar: AppBar(title: Text('워케이션맵', style: AppTextStyles.displayLogo)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s4),
        children: [
          Text('디자인 토큰이 적용되었습니다', style: AppTextStyles.heading2xl),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Figma 01 Foundations 의 Tokens 컬렉션과 동일한 값입니다. M-01 화면부터 구현을 시작하세요.',
            style: AppTextStyles.bodyBase.copyWith(
              color: AppSemantic.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.s6),
          Wrap(
            spacing: AppSpacing.s3,
            runSpacing: AppSpacing.s3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton(onPressed: () {}, child: const Text('Primary CTA')),
              const ChoiceChip(label: Text('선택된 칩'), selected: true),
              const ChoiceChip(label: Text('기본 칩'), selected: false),
              for (final g in const ['S', 'A', 'B', 'C'])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s2,
                    vertical: AppSpacing.s1,
                  ),
                  decoration: BoxDecoration(
                    color: semantic.gradeOf(g).bg,
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Text(
                    g,
                    style: AppTextStyles.captionBadge.copyWith(
                      color: semantic.gradeOf(g).fg,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.s6),
          Container(
            width: 288,
            decoration: BoxDecoration(
              color: AppSemantic.bgSurface,
              borderRadius: AppRadius.xlAll,
              boxShadow: AppShadows.cardFloat,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ColoredBox(color: semantic.bgSubtle),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.s4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('고성 · 10월', style: AppTextStyles.bodySmMedium),
                      Text(
                        '조용함 · 또래 밀도 낮음',
                        style: AppTextStyles.captionXs.copyWith(
                          color: semantic.textTertiary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      Text('8.7', style: AppTextStyles.number2xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
