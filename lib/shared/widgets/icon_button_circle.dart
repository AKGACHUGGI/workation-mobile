import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum IconButtonCircleSize {
  sm(32, 16),
  md(40, 20);

  const IconButtonCircleSize(this.box, this.icon);

  final double box;
  final double icon;
}

/// 사진 위에 올리는 흰 원형 아이콘 버튼 (Figma IconButtonCircle). 뒤로 · 공유 · 저장.
class IconButtonCircle extends StatelessWidget {
  const IconButtonCircle({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.size = IconButtonCircleSize.md,
    this.onPressed,
  }) : saved = null;

  /// 저장(즐겨찾기) 버튼. 저장 상태만 브랜드 색으로 채웁니다.
  const IconButtonCircle.save({
    super.key,
    required bool this.saved,
    this.size = IconButtonCircleSize.md,
    this.onPressed,
  }) : icon = LucideIcons.bookmark,
       semanticLabel = saved ? '즐겨찾기 해제' : '즐겨찾기';

  final IconData icon;
  final String semanticLabel;
  final IconButtonCircleSize size;
  final VoidCallback? onPressed;

  /// null 이면 일반 아이콘 버튼.
  final bool? saved;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: semanticLabel,
      toggled: saved,
      excludeSemantics: true,
      child: Material(
        color: scheme.surface,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: size.box,
            child: Center(
              child: saved == true
                  ? SvgPicture.asset(
                      'assets/icons/bookmark_filled.svg',
                      width: size.icon,
                      height: size.icon,
                    )
                  : Icon(icon, size: size.icon, color: scheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
