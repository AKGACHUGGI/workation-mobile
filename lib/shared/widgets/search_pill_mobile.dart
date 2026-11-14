import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';

/// 모바일 자연어 검색 필 (Figma SearchPillMobile). 누르면 M-01b 입력 화면으로 갑니다.
class SearchPillMobile extends StatelessWidget {
  const SearchPillMobile({
    super.key,
    this.title = '어떤 워케이션을 원하세요?',
    this.sub = '예: 10월에 조용한 바닷가에서 한 달',
    this.onTap,
  });

  /// 입력한 문장 또는 안내 문구
  final String title;

  /// AI 가 이해한 조건 요약 또는 예시
  final String sub;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppRadius.fullAll,
          border: Border.all(color: scheme.outlineVariant),
          boxShadow: AppShadows.cardFloat,
        ),
        child: Material(
          type: MaterialType.transparency,
          shape: const StadiumBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.s4,
                right: AppSpacing.s2,
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.search, size: 20),
                  const SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmMedium,
                        ),
                        Text(
                          sub,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.captionXs.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s3),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: const Icon(LucideIcons.sparkles, size: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
