import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/photo/photo_picker.dart';
import '../../core/theme/app_theme.dart';
import 'app_photo.dart';

/// 올릴 사진 고르기 줄: [사진 추가] 칸(`n/3`) + 고른 사진 미리 보기(누르면 빼는 ✕).
/// [max] 장을 채우면 추가 칸이 꺼집니다. 팁 입력 시트와 이달의 사진 올리기 시트가 같이 씁니다.
class PhotoPickStrip extends StatelessWidget {
  const PhotoPickStrip({
    super.key,
    required this.photos,
    required this.onAdd,
    required this.onRemove,
    this.max = photoMaxCount,
    this.size = 64,
  });

  final List<PickedPhoto> photos;

  /// 추가 칸을 눌렀을 때. null 이면 누를 수 없습니다(보내는 중).
  final VoidCallback? onAdd;

  /// 미리 보기의 ✕ 를 눌렀을 때(몇 번째인지). null 이면 누를 수 없습니다.
  final ValueChanged<int>? onRemove;
  final int max;

  /// 칸 한 변의 길이
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final full = photos.length >= max;
    final onAdd = full ? null : this.onAdd;
    final onRemove = this.onRemove;

    return Row(
      spacing: AppSpacing.s2,
      children: [
        Semantics(
          button: true,
          enabled: onAdd != null,
          label: '사진 추가, ${photos.length}/$max',
          excludeSemantics: true,
          child: Material(
            color: colors.bgSubtle,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.lgAll,
              side: BorderSide(color: scheme.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onAdd,
              child: SizedBox.square(
                dimension: size,
                child: Opacity(
                  opacity: onAdd == null ? 0.4 : 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Icon(
                        LucideIcons.camera,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                      Text(
                        '${photos.length}/$max',
                        style: AppTextStyles.captionXsMedium.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        for (final (i, photo) in photos.indexed)
          SizedBox.square(
            dimension: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Semantics(
                  image: true,
                  label: '고른 사진 ${i + 1}',
                  child: ClipRRect(
                    borderRadius: AppRadius.lgAll,
                    child: ColoredBox(
                      color: scheme.surfaceContainer,
                      child: AppPhoto(photo.path),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Semantics(
                    container: true,
                    button: true,
                    label: '고른 사진 ${i + 1} 빼기',
                    excludeSemantics: true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onRemove == null ? null : () => onRemove(i),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: scheme.scrim.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.x,
                          size: 14,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
