import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_exception.dart';

/// provider 의 `retry:` 에 넣는 정책. Riverpod 기본값은 어떤 실패든 200ms 부터
/// 간격을 늘려 가며 10번까지 다시 부릅니다.

/// 다시 부르지 않습니다. 실패하면 바로 오류 상태를 보여 주고, 다시 시도는 화면의
/// [다시 시도] 로만 합니다.
Duration? noRetry(int retryCount, Object error) => null;

/// 다시 불러도 결과가 같은 응답이면 다시 부르지 않습니다. [다시 시도] 버튼이 없는
/// 화면에 씁니다.
///
/// 연결 실패 · 타임아웃과 5xx 는 기본 간격으로 다시 부르고, 501(아직 없는 기능) ·
/// 4xx(401 · 404 포함)는 한 번으로 끝냅니다.
Duration? retryTransient(int retryCount, Object error) {
  final transient = switch (error) {
    NetworkException() => true,
    ServerException(:final statusCode) =>
      statusCode >= 500 && statusCode != 501,
    _ => false,
  };
  return transient ? ProviderContainer.defaultRetry(retryCount, error) : null;
}
