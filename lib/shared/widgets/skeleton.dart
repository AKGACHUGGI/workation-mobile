import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 로딩 자리 블록 (Figma Explore/Skeleton/Block). 글자 없이 실제 요소와 같은 자리 · 크기로 둡니다.
/// 천천히 밝아졌다 어두워집니다(시스템에서 애니메이션을 끄면 멈춤).
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius = AppRadius.sm,
    this.onMap = false,
  });

  /// null 이면 가능한 만큼 넓게
  final double? width;
  final double height;
  final double radius;

  /// 땅 색 위에서 보이게 한 단계 진하게
  final bool onMap;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = widget.onMap
        ? scheme.surfaceContainerHighest
        : scheme.surfaceContainer;

    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(base, scheme.surface, _controller.value * 0.6),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }
}
