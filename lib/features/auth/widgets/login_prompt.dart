import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../login_gate.dart';

/// 비로그인 상태의 탭 화면(M-05 · M-07)에 쓰는 안내. 로그인 버튼은 M-06 을 띄웁니다.
/// 로그인에 성공하면 세션이 바뀌어 화면이 스스로 내용으로 바뀝니다.
class LoginPrompt extends ConsumerWidget {
  const LoginPrompt({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s3,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: scheme.primary),
            ),
            Text(title, style: AppTextStyles.headingLg),
            Text(
              body,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySm.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            AppButton('로그인', onPressed: () => ensureLoggedIn(context, ref)),
          ],
        ),
      ),
    );
  }
}

/// 로그인 안내에 쓰는 기본 아이콘들.
abstract final class LoginPromptIcons {
  static const favorites = LucideIcons.bookmark;
  static const my = LucideIcons.user;
}
