import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/tag.dart';

/// "AI가 이해한 조건" 줄 (Figma M-01 ParsedConditions). 조건 태그 + 조건 수정 · 조건 지우기.
///
/// `조건 지우기` 는 Figma 에 없고 웹 W-01 에 있는 동작입니다. 검색을 되돌릴 길이
/// 필요해 같이 둡니다.
class ParsedConditions extends StatelessWidget {
  const ParsedConditions({
    super.key,
    required this.tags,
    required this.onEdit,
    required this.onClear,
  });

  final List<String> tags;

  /// 입력 화면(M-01b)으로 돌아가 문장을 고칩니다.
  final VoidCallback onEdit;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'AI가 이해한 조건',
          style: AppTextStyles.captionXsMedium.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        for (final tag in tags) Tag(tag),
        _Link(
          label: '조건 수정',
          style: AppTextStyles.captionXsMedium,
          onTap: onEdit,
        ),
        _Link(
          label: '조건 지우기',
          style: AppTextStyles.captionXs.copyWith(color: tertiary),
          onTap: onClear,
        ),
      ],
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.label, required this.style, required this.onTap});

  final String label;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          // 글자는 작아도 누르는 자리는 넉넉하게
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
          child: Text(
            label,
            style: style.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: style.color,
            ),
          ),
        ),
      ),
    );
  }
}
