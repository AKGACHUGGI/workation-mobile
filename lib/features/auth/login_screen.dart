import 'dart:async';

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
import 'onboarding_screen.dart';

/// 브라우저에서 앱으로 돌아온 뒤 이만큼 기다려도 로그인되지 않으면(브라우저를 닫음 · 취소)
/// 버튼의 진행 표시를 거둡니다. 딥링크 복귀면 그 사이 세션 교환이 끝납니다.
const loginResumeGrace = Duration(seconds: 3);

/// M-06 로그인. 로그인하면 `pop(true)`, 닫거나 둘러보기를 고르면 `pop(false)` 입니다.
///
/// 버튼을 누르면 Supabase OAuth(카카오 · Google) 페이지를 열고, 딥링크로 돌아오면
/// [SessionNotifier] 가 `/api/me` 를 읽습니다. 첫 로그인이면 [OnboardingScreen] 을 거칩니다.
/// mock 모드(`USE_MOCK=true`)는 짧게 기다린 뒤 mock 사용자 "두이" 로 로그인합니다.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with WidgetsBindingObserver {
  /// 로그인 중인 제공자. null 이면 대기 중.
  AuthProviderKind? _signingIn;

  /// 온보딩 화면이 위에 떠 있는 동안은 로그인 완료로 닫지 않고 온보딩 결과를 기다립니다.
  bool _onboarding = false;

  Timer? _resumeTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resumeTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || _signingIn == null) return;
    _resumeTimer?.cancel();
    _resumeTimer = Timer(loginResumeGrace, () {
      if (!mounted || _onboarding) return;
      if (ref.read(sessionProvider) == null) setState(() => _signingIn = null);
    });
  }

  Future<void> _signIn(AuthProviderKind kind) async {
    if (_signingIn != null) return;
    setState(() => _signingIn = kind);
    try {
      await ref.read(sessionProvider.notifier).signIn(kind);
    } catch (_) {
      if (!mounted) return;
      setState(() => _signingIn = null);
      _snack('로그인을 시작하지 못했어요. 잠시 후 다시 시도해 주세요');
    }
  }

  Future<void> _openOnboarding(AuthUser user) async {
    _onboarding = true;
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => OnboardingScreen(user: user),
      ),
    );
    _onboarding = false;
    if (!mounted) return;
    if (ok == true) {
      context.pop(true);
    } else {
      setState(() => _signingIn = null);
    }
  }

  void _snack(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  void _close() => context.pop(false);

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(sessionProvider, (_, next) {
        if (next != null && !_onboarding) context.pop(true);
      })
      ..listen(pendingOnboardingProvider, (_, next) {
        if (next != null && !_onboarding) _openOnboarding(next);
      })
      ..listen(loginFailureProvider, (_, _) {
        setState(() => _signingIn = null);
        _snack('로그인하지 못했어요. 다시 시도해 주세요');
      });

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
