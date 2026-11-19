import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/me.dart';
import '../my_providers.dart';

/// 내 팁 삭제: 확인 대화상자 → 삭제 → 결과 안내.
/// 실패하면 "팁을 삭제하지 못했어요" 를 띄우고 목록은 그대로 둡니다.
Future<void> confirmDeleteMyTip(
  BuildContext context,
  WidgetRef ref,
  MyTip tip,
) async {
  final messenger = ScaffoldMessenger.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('이 팁을 삭제할까요?'),
      content: const Text('삭제한 팁은 되돌릴 수 없어요.'),
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
  final deleted = await ref.read(myTipsProvider.notifier).deleteTip(tip);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(deleted ? '팁을 삭제했어요' : '팁을 삭제하지 못했어요')),
    );
}
