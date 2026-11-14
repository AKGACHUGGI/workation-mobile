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
  final VoidCallback? onShare;
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
                  IconButtonCircle(
                    icon: LucideIcons.share,
                    semanticLabel: '공유',
                    onPressed: onShare,
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
}
