import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_photo.dart';
import '../../shared/widgets/social_login_button.dart';
import 'auth_providers.dart';

/// mock 로그인이 끝나기까지 보이는 짧은 로딩.
const loginMockDelay = Duration(milliseconds: 600);

/// M-06 로그인. 로그인하면 `pop(true)`, 닫거나 둘러보기를 고르면 `pop(false)` 입니다.
///
/// 실제 OAuth(인앱 브라우저 · 딥링크)는 아직 없습니다. 버튼을 누르면 짧게 기다린 뒤
/// mock 사용자 "두이" 로 로그인합니다(구현 플랜 결정 1: 세션 전달 방식 합의 전).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  /// 로그인 중인 제공자. null 이면 대기 중.
  AuthProviderKind? _signingIn;

  Future<void> _signIn(AuthProviderKind kind) async {
    if (_signingIn != null) return;
    setState(() => _signingIn = kind);
    await Future<void>.delayed(loginMockDelay);
    if (!mounted) return;
    ref.read(sessionProvider.notifier).signInMock(kind);
    context.pop(true);
  }

  void _close() => context.pop(false);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final busy = _signingIn != null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: Column(
          children: [
            SizedBox(height: 470, child: _Hero(onClose: busy ? null : _close)),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s4,
                        AppSpacing.s6,
                        AppSpacing.s4,
                        AppSpacing.s4,
                      ),
                      child: Column(
                        spacing: AppSpacing.s3,
                        children: [
                          for (final kind in AuthProviderKind.values)
                            SocialLoginButton(
                              provider: kind,
                              loading: _signingIn == kind,
                              onPressed: busy ? null : () => _signIn(kind),
                            ),
                          AppButton(
                            '로그인 없이 둘러보기',
                            variant: AppButtonVariant.ghost,
                            height: 40,
                            expand: true,
                            onPressed: busy ? null : _close,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s6,
                        0,
                        AppSpacing.s6,
                        28,
                      ),
                      child: Text(
                        '계속하면 이용약관 및 개인정보처리방침에 동의하는 것으로 간주됩니다. '
                        '수집 항목: 닉네임·프로필 이미지·이메일(선택)',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.captionXs.copyWith(
                          color: tertiary,
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
    );
  }
}

/// 사진 위에 검은 그라데이션을 깔고 로고 · 제목 · 안내를 얹은 윗부분.
class _Hero extends StatelessWidget {
  const _Hero({required this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onImage = scheme.onPrimary; // 흰색(text/inverse)

    return Stack(
      fit: StackFit.expand,
      children: [
        const AppPhoto('assets/mock-photos/51150.jpg'),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                scheme.shadow.withValues(alpha: 0.15),
                scheme.shadow.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s2),
              child: IconButton(
                tooltip: '닫기',
                onPressed: onClose,
                icon: Icon(LucideIcons.x, color: onImage),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s6,
            0,
            AppSpacing.s6,
            28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 14,
            children: [
              Row(
                spacing: AppSpacing.s2,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: AppRadius.lgAll,
                    ),
                    child: Icon(LucideIcons.mapPin, size: 16, color: onImage),
                  ),
                  Text(
                    '워케이션맵',
                    style: AppTextStyles.displayLogo.copyWith(color: onImage),
                  ),
                ],
              ),
              Text(
                '당신의 장소를 찾으세요',
                style: AppTextStyles.displayLogo.copyWith(
                  fontSize: 32,
                  height: 40 / 32,
                  color: onImage,
                ),
              ),
              Text(
                '탐색·랭킹·지도는 로그인 없이도 쓸 수 있어요. 팁 작성, 사진 올리기, '
                '기기 간 즐겨찾기 동기화에만 계정이 필요합니다.',
                style: AppTextStyles.bodySm.copyWith(
                  color: onImage.withValues(alpha: 0.88),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
