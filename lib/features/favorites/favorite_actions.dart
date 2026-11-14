import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/me.dart';
import '../auth/auth_providers.dart';
import '../auth/login_gate.dart';
import 'favorites_providers.dart';

abstract final class FavoriteCopy {
  static const limit = '최대 $favoriteLimit개까지 저장할 수 있어요';
  static const failed = '저장하지 못했어요 · 잠시 후 다시 시도해 주세요';
  static const removed = '즐겨찾기에서 뺐어요';
  static const undo = '되돌리기';
}

/// 하트(저장) 버튼의 공통 동작.
///
/// 비로그인이면 M-06 로그인을 띄우고, 로그인에 성공하면 이어서 **저장**합니다
/// (이미 서버에 있던 항목이면 그대로 둡니다). 로그인 상태면 저장 ↔ 해제를 바꿉니다.
/// 로그인을 닫으면 아무 일도 하지 않습니다.
Future<void> toggleFavoriteWithLogin(
  BuildContext context,
  WidgetRef ref,
  FavoriteKind kind,
  String id,
) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final wasLoggedIn = ref.read(isLoggedInProvider);
  if (!await ensureLoggedIn(context, ref)) return;

  final notifier = ref.read(favoriteIdsProvider.notifier);
  final result = wasLoggedIn
      ? await notifier.toggle(kind, id)
      : await notifier.setSaved(kind, id, saved: true);

  final message = switch (result) {
    SaveResult.ok => null,
    SaveResult.limit => FavoriteCopy.limit,
    SaveResult.failed => FavoriteCopy.failed,
  };
  if (message != null && messenger != null) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
