import 'dart:ui' show Rect;

import 'package:workation_mobile/features/share/share_providers.dart';

/// 공유창을 열지 않고 보낸 글과 버튼 위치만 기록하는 가짜.
class FakeShareService implements ShareService {
  final texts = <String>[];
  final origins = <Rect?>[];

  @override
  Future<void> share(String text, {Rect? origin}) async {
    texts.add(text);
    origins.add(origin);
  }
}
