import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/network/retry.dart';

void main() {
  test('noRetry 는 어떤 실패도 다시 부르지 않는다', () {
    expect(noRetry(0, const NetworkException('/x')), isNull);
    expect(noRetry(0, const ServerException('/x', 500)), isNull);
  });

  group('retryTransient', () {
    test('연결 실패 · 5xx 는 다시 부른다', () {
      expect(retryTransient(0, const NetworkException('/x')), isNotNull);
      expect(retryTransient(0, const ServerException('/x', 500)), isNotNull);
      expect(retryTransient(0, const ServerException('/x', 503)), isNotNull);
    });

    test('501 · 4xx 는 다시 불러도 같으니 한 번으로 끝낸다', () {
      expect(retryTransient(0, const ServerException('/x', 501)), isNull);
      expect(retryTransient(0, const ServerException('/x', 400)), isNull);
      expect(retryTransient(0, const UnauthorizedException('/x')), isNull);
      expect(retryTransient(0, const NotFoundException('/x')), isNull);
      expect(retryTransient(0, StateError('bug')), isNull);
    });

    test('계속 실패하면 10번에서 멈춘다', () {
      expect(retryTransient(9, const NetworkException('/x')), isNotNull);
      expect(retryTransient(10, const NetworkException('/x')), isNull);
    });
  });
}
