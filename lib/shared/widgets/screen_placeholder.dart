import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 아직 구현하지 않은 화면의 자리표시. 화면을 구현하면 지웁니다.
class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({
    super.key,
    required this.title,
    required this.screenId,
    required this.milestone,
  });

  final String title;

  /// 명세 화면 ID. 예: `M-02`
  final String screenId;

  /// 구현 예정 단계. 예: `M3`
  final String milestone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$screenId $title · $milestone 단계에서 구현',
          style: AppTextStyles.bodyBase.copyWith(
            color: AppSemantic.textSecondary,
          ),
        ),
      ),
    );
  }
}
