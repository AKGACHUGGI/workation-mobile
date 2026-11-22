import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import 'app_photo.dart';

/// 사진을 화면 가득 크게 봅니다. 옆으로 넘기고, 두 손가락으로 키울 수 있습니다.
/// [initialIndex] 번째 사진부터 보여 줍니다.
Future<void> showPhotoGallery(
  BuildContext context, {
  required List<String> urls,
  int initialIndex = 0,
}) {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    builder: (_) => PhotoGallery(urls: urls, initialIndex: initialIndex),
  );
}

/// [showPhotoGallery] 의 내용.
class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key, required this.urls, this.initialIndex = 0});

  final List<String> urls;
  final int initialIndex;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  late final _controller = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final count = widget.urls.length;

    return Dialog.fullscreen(
      backgroundColor: scheme.scrim,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: count,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) => Semantics(
                image: true,
                label: '사진 ${i + 1} / $count',
                child: InteractiveViewer(
                  maxScale: 4,
                  child: AppPhoto(widget.urls[i], fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: AppSpacing.s2,
              left: AppSpacing.s2,
              right: AppSpacing.s2,
              child: Row(
                children: [
                  IconButton(
                    tooltip: '닫기',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(LucideIcons.x, color: scheme.onPrimary),
                  ),
                  const Spacer(),
                  if (count > 1)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.s3),
                      child: Text(
                        '${_index + 1} / $count',
                        style: AppTextStyles.bodySmMedium.copyWith(
                          color: scheme.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 팁에 붙은 사진 줄(최대 3장). 정사각 썸네일을 옆으로 놓고, 누르면 크게 봅니다.
/// 좁은 화면에서는 썸네일이 같이 줄어듭니다.
class PhotoThumbRow extends StatelessWidget {
  const PhotoThumbRow({
    super.key,
    required this.urls,
    required this.semanticLabel,
    this.size = 96,
  });

  final List<String> urls;

  /// 사진 한 장의 읽기 문구 앞부분. 예: `바다러버 님의 사진` → `바다러버 님의 사진 1`
  final String semanticLabel;

  /// 썸네일 한 변의 최대 길이
  final double size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Theme.of(context).colorScheme.surfaceContainer;

    return Row(
      spacing: AppSpacing.s2,
      children: [
        for (final (i, url) in urls.indexed)
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size),
              child: AspectRatio(
                aspectRatio: 1,
                child: Semantics(
                  button: true,
                  image: true,
                  label: '$semanticLabel ${i + 1}',
                  child: ClipRRect(
                    borderRadius: AppRadius.lgAll,
                    child: GestureDetector(
                      onTap: () => showPhotoGallery(
                        context,
                        urls: urls,
                        initialIndex: i,
                      ),
                      // 불러오는 동안에도 자리가 보이게 회색을 깝니다.
                      child: ColoredBox(
                        color: placeholder,
                        child: AppPhoto(url),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
