import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import 'icon_button_circle.dart';
import 'photo_carousel.dart';

/// 상세 화면 사진 헤더 (M-03 · M-04). 사진 캐러셀 위에 뒤로 · 공유 · 저장 버튼.
class PhotoHeader extends StatelessWidget {
  const PhotoHeader({
    super.key,
    required this.photos,
    this.saved = false,
    this.onBack,
    this.onShare,
    this.onToggleSave,
    this.height = 280,
  });

  final List<String?> photos;
  final bool saved;
  final VoidCallback? onBack;

  /// 누른 공유 버튼의 화면 위치를 함께 넘깁니다(iPad · 태블릿 공유창 위치용).
  final ValueChanged<Rect>? onShare;
  final VoidCallback? onToggleSave;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PhotoCarousel(
        photos: photos,
        overlay: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s4,
                vertical: AppSpacing.s3,
              ),
              child: Row(
                children: [
                  IconButtonCircle(
                    icon: LucideIcons.chevronLeft,
                    semanticLabel: '뒤로',
                    onPressed: onBack,
                  ),
                  const Spacer(),
                  Builder(
                    builder: (context) => IconButtonCircle(
                      icon: LucideIcons.share,
                      semanticLabel: '공유',
                      onPressed: onShare == null
                          ? null
                          : () => onShare!(_originOf(context)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s2),
                  IconButtonCircle.save(saved: saved, onPressed: onToggleSave),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Rect _originOf(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero) & box.size;
  }
}
