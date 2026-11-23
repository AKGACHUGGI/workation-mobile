import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 워케이션맵 로고 글리프 (핀 + 노트북). 빨간 둥근 상자 안에 흰 선으로 쓴다.
class BrandGlyph extends StatelessWidget {
  const BrandGlyph({super.key, this.size = 18, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/brand_glyph.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
