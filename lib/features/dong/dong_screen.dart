import 'package:flutter/material.dart';

import '../../shared/widgets/screen_placeholder.dart';

/// M-04 동네 프로필 (M3 에서 구현). 지금은 지역 상세의 행정동 줄이 닿는 자리만 둡니다.
class DongScreen extends StatelessWidget {
  const DongScreen({super.key, required this.dongId});

  /// 행정동 코드 10자리
  final String dongId;

  @override
  Widget build(BuildContext context) {
    return const ScreenPlaceholder(
      title: '동네 프로필',
      screenId: 'M-04',
      milestone: 'M3',
    );
  }
}
