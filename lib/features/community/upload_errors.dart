import '../../core/network/api_exception.dart';

/// 팁 · 사진 올리기 실패를 사용자에게 보여 줄 한 줄로 바꿉니다.
/// 서버 코드(`webapi/me.py` · `webapi/uploads.py`)를 먼저 보고, 없으면 상태 코드로 고릅니다.
/// [fallback] 은 그 밖의 실패(연결 끊김 · 5xx)에 쓰는 문구입니다.
String uploadErrorMessage(
  ApiException error, {
  required String fallback,
  bool photos = false,
}) {
  if (error is! ServerException) return fallback;
  switch (error.code) {
    case 'INVALID_PHOTO':
      // 서버가 몇 번째 사진이 왜 안 되는지 알려 줍니다.
      return error.message ?? _invalidPhoto;
    case 'PHOTO_RATE_LIMIT':
      return '사진은 1시간에 30장까지 올릴 수 있어요. 잠시 후 다시 시도해 주세요';
    case 'TIP_RATE_LIMIT':
      return _tipRateLimit;
  }
  return switch (error.statusCode) {
    429 => photos ? '사진을 너무 많이 올렸어요. 잠시 후 다시 시도해 주세요' : _tipRateLimit,
    400 || 413 when photos => _invalidPhoto,
    _ => fallback,
  };
}

const _invalidPhoto = '사진을 확인해 주세요. JPEG · PNG · WebP, 한 장에 10MB 까지 올릴 수 있어요';
const _tipRateLimit = '팁을 너무 빠르게 올리고 있어요. 잠시 후 다시 시도해 주세요';
