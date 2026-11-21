import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/core/photo/photo_picker.dart';
import 'package:workation_mobile/features/community/upload_errors.dart';

import '../../fakes/photos.dart';

void main() {
  group('checkPhotos', () {
    test('올릴 수 있는 사진은 그대로 통과한다', () {
      final picked = [photo('a.jpg'), photo('b.JPEG'), photo('c.webp')];
      final result = checkPhotos(picked, room: 3);
      expect(result.accepted, picked);
      expect(result.rejected, isNull);
    });

    test('자리보다 많이 고르면 앞에서부터 자리만큼만 받고 알린다', () {
      final picked = [photo('a.jpg'), photo('b.png'), photo('c.png')];
      final result = checkPhotos(picked, room: 2);
      expect([for (final p in result.accepted) p.name], ['a.jpg', 'b.png']);
      expect(result.rejected, '사진은 3장까지 올릴 수 있어요');
    });

    test('형식이 다르거나 10MB 를 넘는 사진은 빼고 이유를 알린다', () {
      final result = checkPhotos([
        photo('a.gif'),
        photo('b.jpg', bytes: photoMaxBytes + 1),
        photo('c.png', bytes: photoMaxBytes),
        photo('확장자없음'),
      ], room: 3);
      expect([for (final p in result.accepted) p.name], ['c.png']);
      // 여러 가지면 처음 것
      expect(result.rejected, 'JPEG · PNG · WebP 사진만 올릴 수 있어요');

      expect(
        checkPhotos([
          photo('b.jpg', bytes: photoMaxBytes + 1),
        ], room: 3).rejected,
        '한 장에 10MB 이하인 사진만 올릴 수 있어요',
      );
    });

    test('자리가 없으면 아무것도 받지 않는다', () {
      final result = checkPhotos([photo('a.jpg')], room: 0);
      expect(result.accepted, isEmpty);
      expect(result.rejected, isNotNull);
    });
  });

  group('uploadErrorMessage', () {
    const fallback = '올리지 못했어요';
    String of(ApiException e, {bool photos = true}) =>
        uploadErrorMessage(e, fallback: fallback, photos: photos);

    test('서버 코드가 있으면 그에 맞는 문구를 쓴다', () {
      expect(
        of(
          const ServerException(
            '/p',
            400,
            code: 'INVALID_PHOTO',
            message: '2번째 사진이 10MB 를 넘어요.',
          ),
        ),
        '2번째 사진이 10MB 를 넘어요.',
      );
      expect(
        of(const ServerException('/p', 429, code: 'PHOTO_RATE_LIMIT')),
        contains('1시간에 30장'),
      );
      expect(
        of(const ServerException('/p', 429, code: 'TIP_RATE_LIMIT')),
        contains('팁을 너무 빠르게'),
      );
    });

    test('코드가 없으면 상태 코드로 고른다', () {
      expect(
        of(const ServerException('/p', 400)),
        contains('JPEG · PNG · WebP'),
      );
      expect(of(const ServerException('/p', 413)), contains('10MB'));
      expect(of(const ServerException('/p', 429)), contains('잠시 후'));
      expect(
        of(const ServerException('/p', 429), photos: false),
        contains('팁을 너무 빠르게'),
      );
      // 사진이 없는 팁의 400 은 사진 탓이 아니다.
      expect(of(const ServerException('/p', 400), photos: false), fallback);
    });

    test('그 밖의 실패는 넘겨받은 문구를 쓴다', () {
      expect(
        of(const ServerException('/p', 502, code: 'UPLOAD_FAILED')),
        fallback,
      );
      expect(of(const NetworkException('/p')), fallback);
    });
  });
}
