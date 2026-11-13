import 'package:flutter/material.dart';

/// 사진 한 장. [url] 이 `http` 로 시작하면 네트워크, 아니면 번들 에셋 경로로 읽습니다.
/// 없거나 읽지 못하면 회색 상자로 대신 그립니다(mock 사진은 커밋하지 않기 때문).
class AppPhoto extends StatelessWidget {
  const AppPhoto(this.url, {super.key, this.fit = BoxFit.cover});

  final String? url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
    );
    final src = url;
    if (src == null || src.isEmpty) return fallback;

    Widget onError(BuildContext context, Object error, StackTrace? stack) =>
        fallback;

    return src.startsWith('http')
        ? Image.network(src, fit: fit, errorBuilder: onError)
        : Image.asset(src, fit: fit, errorBuilder: onError);
  }
}

/// 사진 캐러셀 위치 점. 현재 장만 불투명합니다.
class CarouselDots extends StatelessWidget {
  const CarouselDots({super.key, required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == index ? color : color.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
