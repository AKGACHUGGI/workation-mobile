import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'app_photo.dart';

/// 옆으로 넘기는 사진 묶음 + 위치 점. 카드 사진과 사진 헤더가 같이 씁니다.
/// [overlay] 는 사진 위에 얹는 버튼 · 배지입니다.
class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({super.key, required this.photos, this.overlay});

  /// 사진 주소. 비어 있으면 회색 상자 한 장을 그립니다.
  final List<String?> photos;
  final Widget? overlay;

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos.isEmpty
        ? const <String?>[null]
        : widget.photos;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (photos.length == 1)
          AppPhoto(photos.first)
        else
          PageView.builder(
            itemCount: photos.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => AppPhoto(photos[i]),
          ),
        if (photos.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.s3,
            child: IgnorePointer(
              child: Center(
                child: CarouselDots(count: photos.length, index: _index),
              ),
            ),
          ),
        ?widget.overlay,
      ],
    );
  }
}
