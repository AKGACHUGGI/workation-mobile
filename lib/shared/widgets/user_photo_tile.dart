import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'app_photo.dart';
import 'avatar.dart';

/// 사용자가 올린 사진 타일 (Figma UserPhotoTile). 120×90, 아래쪽에 작성자 아바타 + `@닉네임`.
class UserPhotoTile extends StatelessWidget {
  const UserPhotoTile({super.key, required this.url, required this.author});

  final String? url;
  final String author;

  static const width = 120.0;
  static const height = 90.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final scrim = Theme.of(context).colorScheme.scrim;

    return Semantics(
      label: '$author 님이 올린 사진',
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppPhoto(url),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      scrim.withValues(alpha: 0),
                      scrim.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppSpacing.s1,
                    children: [
                      Avatar(
                        author.isEmpty
                            ? '?'
                            : String.fromCharCode(author.runes.first),
                        size: AvatarSize.sm,
                      ),
                      Flexible(
                        child: Text(
                          '@$author',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.captionXsMedium.copyWith(
                            color: scheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
