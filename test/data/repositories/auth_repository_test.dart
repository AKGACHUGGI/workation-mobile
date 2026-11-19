import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/data/repositories/auth_repository.dart';

void main() {
  group('waitForSession (iOS 다시 로그인: 브라우저 첫 로드 실패 뒤 딥링크로 세션)', () {
    const step = Duration(milliseconds: 5);

    test('이미 세션이 있으면 바로 true', () async {
      expect(await waitForSession(() => true, step: step), isTrue);
    });

    test('기다리는 동안 세션이 생기면 true', () async {
      var calls = 0;
      final ok = await waitForSession(
        () => ++calls >= 3,
        grace: const Duration(seconds: 1),
        step: step,
      );
      expect(ok, isTrue);
      expect(calls, 3);
    });

    test('끝까지 세션이 없으면 false (진짜 실패는 그대로 안내)', () async {
      final watch = Stopwatch()..start();
      final ok = await waitForSession(
        () => false,
        grace: const Duration(milliseconds: 40),
        step: step,
      );
      expect(ok, isFalse);
      expect(
        watch.elapsed,
        greaterThanOrEqualTo(const Duration(milliseconds: 40)),
      );
    });
  });
}
