import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인 제공자. Apple 은 넣지 않습니다(시연 빌드까지만, 구현 플랜 결정 1).
enum AuthProviderKind {
  kakao('카카오'),
  google('Google');

  const AuthProviderKind(this.label);

  final String label;
}

/// 로그인한 사용자. 웹 `features/auth/types.ts` 의 `Me` 와 같은 모양입니다.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.nickname,
    required this.initial,
    required this.provider,
    required this.emailMasked,
  });

  final String id;
  final String nickname;

  /// 아바타에 쓰는 한 글자
  final String initial;
  final AuthProviderKind provider;

  /// 예: `du***@kakao.com`
  final String emailMasked;
}

/// 지금 로그인한 사용자. 로그인하지 않았으면 null 입니다.
/// 세션 전달 방식(결정 1)이 정해지기 전이라 메모리에만 둡니다.
class SessionNotifier extends Notifier<AuthUser?> {
  @override
  AuthUser? build() => null;

  /// mock 로그인. 웹 mock 의 가짜 사용자 "두이" 로 들어갑니다.
  void signInMock(AuthProviderKind provider) {
    state = AuthUser(
      id: 'u_1',
      nickname: '두이',
      initial: '두',
      provider: provider,
      emailMasked: provider == AuthProviderKind.kakao
          ? 'du***@kakao.com'
          : 'du***@gmail.com',
    );
  }

  void signOut() => state = null;
}

final sessionProvider = NotifierProvider<SessionNotifier, AuthUser?>(
  SessionNotifier.new,
);

final isLoggedInProvider = Provider<bool>(
  (ref) => ref.watch(sessionProvider) != null,
);
