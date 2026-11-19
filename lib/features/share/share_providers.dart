import 'dart:ui' show Rect;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/network/api_config.dart';
import 'share_copy.dart';

/// 휴대폰 기본 공유창을 여는 한 곳. 테스트에서는 [shareServiceProvider] 를 바꿔 끼웁니다.
abstract class ShareService {
  /// [origin] 은 누른 버튼의 화면 위치입니다(iPad · 태블릿 공유창이 여기에 붙음).
  Future<void> share(String text, {Rect? origin});
}

class SharePlusShareService implements ShareService {
  const SharePlusShareService();

  @override
  Future<void> share(String text, {Rect? origin}) async {
    await SharePlus.instance.share(
      ShareParams(text: text, sharePositionOrigin: origin),
    );
  }
}

final shareServiceProvider = Provider<ShareService>(
  (ref) => const SharePlusShareService(),
);

/// 웹 배포 주소. 비어 있으면 공유 글에 링크를 붙이지 않습니다.
final webBaseUrlProvider = Provider<String>((ref) => ApiConfig.webBaseUrl);

/// 지역 상세 공유. [text] 는 [ShareCopy.region] 으로 만든 한 줄.
Future<void> shareRegion(
  WidgetRef ref, {
  required String text,
  required String regionId,
  required String month,
  Rect? origin,
}) {
  final link = ShareCopy.regionLink(
    ref.read(webBaseUrlProvider),
    regionId,
    month,
  );
  return ref
      .read(shareServiceProvider)
      .share(ShareCopy.withLink(text, link), origin: origin);
}

/// 동네 프로필 공유. [text] 는 [ShareCopy.dong] 으로 만든 글.
Future<void> shareDong(
  WidgetRef ref, {
  required String text,
  required String dongId,
  required String month,
  Rect? origin,
}) {
  final link = ShareCopy.dongLink(ref.read(webBaseUrlProvider), dongId, month);
  return ref
      .read(shareServiceProvider)
      .share(ShareCopy.withLink(text, link), origin: origin);
}
