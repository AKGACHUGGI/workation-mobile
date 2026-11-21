import 'package:flutter/material.dart';

/// 팁을 지울지 묻습니다. [삭제] 를 누르면 true. 지역 · 동네 화면과 MY 가 같이 씁니다.
Future<bool> confirmTipDelete(BuildContext context) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('이 팁을 삭제할까요?'),
      content: const Text('붙인 사진과 답글도 함께 지워지고 되돌릴 수 없어요.'),
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
  return ok ?? false;
}
