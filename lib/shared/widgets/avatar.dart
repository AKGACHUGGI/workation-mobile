import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

enum AvatarSize { sm, md }

/// 사용자 아바타 (Figma Avatar). 프로필 사진이 없으면 닉네임 첫 글자를 브랜드 색 원 안에 둡니다.
class Avatar extends StatelessWidget {
  const Avatar(this.initial, {super.key, this.size = AvatarSize.md});

  final String initial;
  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final scheme = Theme.of(context).colorScheme;
    final md = size == AvatarSize.md;

    return ExcludeSemantics(
      child: Container(
        width: md ? 32 : 24,
        height: md ? 32 : 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.brandSoft,
          shape: BoxShape.circle,
          border: Border.all(color: colors.brandSoftBorder),
        ),
        child: Text(
          initial,
          style: (md ? AppTextStyles.bodySmBold : AppTextStyles.captionXsBold)
              .copyWith(color: scheme.primary),
        ),
      ),
    );
  }
}
