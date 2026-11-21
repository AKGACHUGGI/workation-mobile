import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// 한 번에 올릴 수 있는 사진 수(서버 `photo_upload.MAX_PHOTOS`). 팁 사진 · 이달의 사진 공통.
const photoMaxCount = 3;

/// 사진 한 장의 최대 크기(서버 `photo_upload.MAX_BYTES`).
const photoMaxBytes = 10 * 1024 * 1024;

/// 서버가 받는 형식. 파일 이름의 확장자로 미리 거릅니다(서버는 열어 보고 다시 확인합니다).
const _allowedExtensions = {'jpg', 'jpeg', 'png', 'webp'};

/// 사진 보관함에서 고른 사진 한 장.
@immutable
class PickedPhoto {
  const PickedPhoto({
    required this.path,
    required this.name,
    required this.bytes,
  });

  /// 기기 안의 파일 경로. 앱을 켜 둔 동안만 씁니다.
  final String path;

  /// 파일 이름(확장자 포함)
  final String name;

  /// 파일 크기
  final int bytes;
}

/// 사진을 고르지 못했습니다(보관함 접근 거부 등).
class PhotoPickException implements Exception {
  const PhotoPickException();
}

/// 사진 고르기 창구. 테스트에서는 가짜로 바꿉니다.
abstract class PhotoPicker {
  /// 보관함에서 최대 [max] 장을 고릅니다. 고르지 않고 닫으면 빈 목록.
  /// 열지 못하면 [PhotoPickException] 을 던집니다.
  Future<List<PickedPhoto>> pick({required int max});
}

/// `image_picker` 로 기기 사진 보관함에서 고릅니다.
///
/// 긴 변 2048px · 품질 85 로 줄여 받아 한 장이 10MB 를 넘는 일이 거의 없고, 이때 HEIC 같은
/// 형식도 JPEG 로 바뀝니다(서버는 JPEG · PNG · WebP 만 받고 다시 가로 1600px WebP 로 바꿉니다).
class GalleryPhotoPicker implements PhotoPicker {
  GalleryPhotoPicker([ImagePicker? picker]) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<List<PickedPhoto>> pick({required int max}) async {
    if (max < 1) return const [];
    try {
      final files = await _picker.pickMultiImage(
        limit: max,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      return [
        for (final f in files)
          PickedPhoto(path: f.path, name: f.name, bytes: await f.length()),
      ];
    } on PlatformException {
      throw const PhotoPickException();
    }
  }
}

final photoPickerProvider = Provider<PhotoPicker>(
  (ref) => GalleryPhotoPicker(),
);

/// 고른 사진 가운데 올릴 수 있는 것만 [room] 장까지 추립니다.
/// 걸러 낸 것이 있으면 [rejected] 에 이유를 한 줄로 담습니다(여러 가지면 처음 것).
({List<PickedPhoto> accepted, String? rejected}) checkPhotos(
  List<PickedPhoto> picked, {
  required int room,
}) {
  String? rejected;
  final ok = <PickedPhoto>[];
  for (final photo in picked) {
    final dot = photo.name.lastIndexOf('.');
    final ext = dot < 0 ? '' : photo.name.substring(dot + 1).toLowerCase();
    if (!_allowedExtensions.contains(ext)) {
      rejected ??= 'JPEG · PNG · WebP 사진만 올릴 수 있어요';
    } else if (photo.bytes > photoMaxBytes) {
      rejected ??= '한 장에 10MB 이하인 사진만 올릴 수 있어요';
    } else {
      ok.add(photo);
    }
  }
  if (ok.length > room) rejected ??= '사진은 $photoMaxCount장까지 올릴 수 있어요';
  return (accepted: ok.take(room < 0 ? 0 : room).toList(), rejected: rejected);
}
