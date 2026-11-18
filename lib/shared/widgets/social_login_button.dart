import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_theme.dart';
import '../../features/auth/auth_providers.dart';

/// 소셜 로그인 버튼 (Figma SocialLoginButton). 카카오 · Google 두 가지(Apple 없음).
///
/// 배경 · 글자색은 각 사의 브랜드 가이드 고정값이라 토큰이 아닙니다(Figma 도 같음).
/// [loading] 이면 로고 대신 작은 진행 표시를 보이고 눌러도 반응하지 않습니다.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.provider,
    this.loading = false,
    this.onPressed,
  });

  final AuthProviderKind provider;
  final bool loading;
  final VoidCallback? onPressed;

  static const _kakaoBg = Color(0xFFFEE500);
  static const _kakaoFg = Color(0xFF191919);
  static const _googleBorder = Color(0xFFDADCE0);
  static const _googleFg = Color(0xFF1F1F1F);

  @override
  Widget build(BuildContext context) {
    final kakao = provider == AuthProviderKind.kakao;
    final fg = kakao ? _kakaoFg : _googleFg;

    return Semantics(
      button: true,
      enabled: !loading,
      label: '${provider.label}로 시작하기',
      excludeSemantics: true,
      child: Material(
        color: kakao ? _kakaoBg : AppPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: kakao
              ? BorderSide.none
              : const BorderSide(color: _googleBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: loading ? null : onPressed,
          child: SizedBox(
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.s2,
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: loading
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: fg,
                          ),
                        )
                      : SvgPicture.asset(
                          kakao
                              ? 'assets/icons/kakao_mark.svg'
                              : 'assets/icons/google_mark.svg',
                        ),
                ),
                Text(
                  '${provider.label}로 시작하기',
                  style: AppTextStyles.bodyBaseMedium.copyWith(color: fg),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
