import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../data/models/me.dart';
import '../../../data/repositories/me_repository.dart';
import '../../community/community_providers.dart';
import '../my_providers.dart';

/// 내 사진 삭제: 확인 대화상자 → 삭제 → 결과 안내.
/// 지우면 내 사진 목록 · 요약(사진 수)과 지역 화면의 이달의 사진을 다시 읽게 합니다.
/// 실패하면 "사진을 삭제하지 못했어요" 를 띄우고 목록은 그대로 둡니다.
Future<void> confirmDeleteMyPhoto(
  BuildContext context,
  WidgetRef ref,
  MyPhoto photo,
) async {
  final messenger = ScaffoldMessenger.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('이 사진을 삭제할까요?'),
      content: const Text('삭제한 사진은 되돌릴 수 없어요.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('삭제'),
        ),
      ],
    ),
  );
  if (ok != true) return;
  var deleted = true;
  try {
    await ref.read(meRepositoryProvider).deletePhoto(photo.id);
  } on ApiException {
    deleted = false;
  }
  if (deleted) {
    ref.invalidate(myPhotosProvider);
    ref.invalidate(meSummaryProvider);
    // 이달의 사진은 투표 응답에 함께 옵니다.
    ref.invalidate(pollProvider);
  }
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(deleted ? '사진을 삭제했어요' : '사진을 삭제하지 못했어요')),
    );
}
