import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';

void main() {
  test('처음에는 로그인하지 않은 상태다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(sessionProvider), isNull);
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('mock 로그인하면 제공자에 맞는 사용자가 들어오고, 로그아웃하면 비워진다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final session = container.read(sessionProvider.notifier);

    session.signInMock(AuthProviderKind.google);
    final user = container.read(sessionProvider)!;
    expect(user.nickname, '두이');
    expect(user.initial, '두');
    expect(user.provider, AuthProviderKind.google);
    expect(user.emailMasked, 'du***@gmail.com');
    expect(container.read(isLoggedInProvider), isTrue);

    session.signOut();
    expect(container.read(sessionProvider), isNull);
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('로그인 제공자는 카카오와 Google 둘뿐이다(Apple 없음)', () {
    expect(AuthProviderKind.values.map((k) => k.label), ['카카오', 'Google']);
  });
}
