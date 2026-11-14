import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';

/// 동네 프로필을 불러오는 중이거나 실패했을 때. 뒤로 가기는 항상 둡니다.
class DongFallback extends StatelessWidget {
  const DongFallback({
    super.key,
    required this.onBack,
    this.message,
    this.onRetry,
  });

  final VoidCallback onBack;

  /// null 이면 불러오는 중
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          tooltip: '뒤로',
          onPressed: onBack,
        ),
      ),
      body: Center(
        child: message == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.s3,
                children: [
                  Text(
                    message!,
                    style: AppTextStyles.bodyBase.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (onRetry != null)
                    OutlinedButton(
                      onPressed: onRetry,
                      child: const Text('다시 시도'),
                    ),
                ],
              ),
      ),
    );
  }
}
