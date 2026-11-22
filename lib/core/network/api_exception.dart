import 'package:dio/dio.dart';

/// API 호출 실패. 화면은 이 타입만 보고 에러 상태를 고릅니다.
sealed class ApiException implements Exception {
  const ApiException(this.path);

  /// 요청 경로. 예: `/api/regions/popular`
  final String path;

  /// DioException 을 화면에서 다루는 종류로 바꿉니다.
  factory ApiException.fromDio(DioException e, String path) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(path);
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        // 서버의 에러 본문: {"error": {"code", "message"}}
        final body = e.response?.data;
        final error = body is Map ? body['error'] : null;
        final code = error is Map ? error['code'] : null;
        final message = error is Map ? error['message'] : null;
        return switch (status) {
          401 => UnauthorizedException(path),
          404 => NotFoundException(path),
          _ => ServerException(
            path,
            status,
            code: code is String ? code : null,
            message: message is String ? message : null,
          ),
        };
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return UnknownApiException(path, e.message);
    }
  }
}

/// 연결 실패 · 타임아웃. "다시 시도" 를 보여줍니다.
final class NetworkException extends ApiException {
  const NetworkException(super.path);

  @override
  String toString() => 'NetworkException($path)';
}

/// 401. 로그인이 필요합니다.
final class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.path);

  @override
  String toString() => 'UnauthorizedException($path)';
}

/// 404. 없는 지역 · 동네 등.
final class NotFoundException extends ApiException {
  const NotFoundException(super.path);

  @override
  String toString() => 'NotFoundException($path)';
}

/// 그 밖의 4xx · 5xx.
final class ServerException extends ApiException {
  const ServerException(super.path, this.statusCode, {this.code, this.message});

  final int statusCode;

  /// 서버가 준 에러 코드. 예: `INVALID_PHOTO` · `PHOTO_RATE_LIMIT`
  final String? code;

  /// 서버가 준 안내 문구. 사용자에게 그대로 보여 줘도 되는 것은 호출부가 고릅니다.
  final String? message;

  @override
  String toString() => 'ServerException($statusCode, $path)';
}

/// 분류하지 못한 실패(취소, 인증서 등).
final class UnknownApiException extends ApiException {
  const UnknownApiException(super.path, this.message);

  final String? message;

  @override
  String toString() => 'UnknownApiException($path, $message)';
}
