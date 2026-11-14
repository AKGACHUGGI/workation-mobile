import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_theme.dart';

/// 종합 점수 (Figma ScoreDisplay, M-03). 화면에서 유일하게 64px 숫자를 쓰는 곳입니다.
class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    super.key,
    required this.score,
    required this.tagline,
    required this.sub,
  });

  final double score;

  /// 예: `조용한 곳 프리셋 · 12곳 중 3위 · S`
  final String tagline;

  /// 예: `10월 기준 · 조용 A · 시기 B · 또래 B · 숙박 S · 활기 B`
  final String sub;

  @override
  Widget build(BuildContext context) {
    const laurel = ExcludeSemantics(child: _Laurel());

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s6,
        vertical: AppSpacing.s4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.s2,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s3,
            children: [
              laurel,
              Text(
                score.round().toString(),
                style: AppTextStyles.numberRating.copyWith(
                  letterSpacing: -1.28,
                ),
                semanticsLabel: '종합 점수 ${score.round()}점',
              ),
              laurel,
            ],
          ),
          Text(
            tagline,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMd,
          ),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _Laurel extends StatelessWidget {
  const _Laurel();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/icons/laurel.svg', width: 40, height: 40);
  }
}
