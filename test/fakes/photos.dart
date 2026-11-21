import 'package:workation_mobile/core/photo/photo_picker.dart';

/// 정해 둔 사진을 돌려주는 가짜 사진 고르기. 부를 때마다 [queue] 의 앞 묶음을 꺼내 줍니다
/// (비면 빈 목록 = 고르지 않고 닫음). [fail] 이면 보관함을 열지 못한 것으로 칩니다.
class FakePhotoPicker implements PhotoPicker {
  FakePhotoPicker([List<List<PickedPhoto>>? queue]) : queue = queue ?? [];

  final List<List<PickedPhoto>> queue;
  bool fail = false;

  /// 부를 때 받은 max(순서대로)
  final asked = <int>[];

  @override
  Future<List<PickedPhoto>> pick({required int max}) async {
    asked.add(max);
    if (fail) throw const PhotoPickException();
    return queue.isEmpty ? const [] : queue.removeAt(0);
  }
}

/// 테스트용 사진 한 장. 파일은 없어도 됩니다(미리 보기는 회색 상자).
PickedPhoto photo(String name, {int bytes = 1024}) =>
    PickedPhoto(path: '/tmp/none/$name', name: name, bytes: bytes);
