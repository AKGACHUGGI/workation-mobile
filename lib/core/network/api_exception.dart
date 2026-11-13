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
        return switch (status) {
          401 => UnauthorizedException(path),
          404 => NotFoundException(path),
          _ => ServerException(path, status),
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
  const ServerException(super.path, this.statusCode);

  final int statusCode;

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
