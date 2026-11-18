/// 로그인 제공자. Apple 은 넣지 않습니다(시연 빌드까지만, 구현 플랜 결정 1).
enum AuthProviderKind {
  kakao('카카오'),
  google('Google');

  const AuthProviderKind(this.label);

  final String label;

  /// `GET /api/me` 의 `provider` 값(`kakao` · `google`)
  static AuthProviderKind fromName(String name) =>
      values.firstWhere((k) => k.name == name);
}

/// 로그인한 사용자. `GET /api/me` 의 `Me`(웹 `features/auth/types.ts`)와 같은 모양입니다.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.nickname,
    required this.initial,
    required this.provider,
    required this.emailMasked,
    this.needsOnboarding = false,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    id: json['id'] as String,
    nickname: json['nickname'] as String,
    initial: json['initial'] as String,
    provider: AuthProviderKind.fromName(json['provider'] as String),
    emailMasked: json['emailMasked'] as String? ?? '',
    needsOnboarding: json['needsOnboarding'] as bool? ?? false,
  );

  final String id;
  final String nickname;

  /// 아바타에 쓰는 한 글자
  final String initial;
  final AuthProviderKind provider;

  /// 예: `du***@kakao.com`
  final String emailMasked;

  /// 약관 미동의 또는 닉네임 미설정. true 면 온보딩을 마쳐야 로그인이 끝납니다.
  final bool needsOnboarding;

  AuthUser copyWith({String? nickname, bool? needsOnboarding}) => AuthUser(
    id: id,
    nickname: nickname ?? this.nickname,
    initial: nickname == null || nickname.isEmpty
        ? initial
        : String.fromCharCode(nickname.runes.first),
    provider: provider,
    emailMasked: emailMasked,
    needsOnboarding: needsOnboarding ?? this.needsOnboarding,
  );
}
