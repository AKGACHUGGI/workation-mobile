import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

enum AvatarSize {
  sm(24),
  md(32),
  lg(56);

  const AvatarSize(this.dimension);

  final double dimension;
}

/// 사용자 아바타 (Figma Avatar). 프로필 사진이 없으면 닉네임 첫 글자를 보여줍니다.
class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.initial, this.size = AvatarSize.md});

  final String initial;
  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brandBorder = Theme.of(context)
        .extension<AppSemanticColors>()!
        .brandSoftBorder;
    final style = switch (size) {
      AvatarSize.sm => AppTextStyles.captionXsBold,
      AvatarSize.md => AppTextStyles.bodySmBold,
      AvatarSize.lg => AppTextStyles.headingXl,
    };

    return Container(
      width: size.dimension,
      height: size.dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
        border: Border.all(color: brandBorder),
      ),
      child: Text(initial, style: style.copyWith(color: scheme.primary)),
    );
  }
}
