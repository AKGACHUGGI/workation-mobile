import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../auth/auth_providers.dart';

/// M-07 [계정 삭제]: 확인 대화상자 → `DELETE /api/me`. 성공하면 비로그인으로 돌아가고
/// 안내를 띄웁니다(웹 `AccountSection` 과 같은 문구). 실패하면 대화상자를 열어 둬 다시 시도할 수 있습니다.
Future<void> confirmDeleteAccount(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);
  final deleted = await showDialog<bool>(
    context: context,
    builder: (context) => const _DeleteAccountDialog(),
  );
  if (deleted != true) return;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(const SnackBar(content: Text('계정을 삭제했습니다')));
}

class _DeleteAccountDialog extends ConsumerStatefulWidget {
  const _DeleteAccountDialog();

  @override
  ConsumerState<_DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<_DeleteAccountDialog> {
  bool _busy = false;
  bool _failed = false;

  Future<void> _delete() async {
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await ref.read(sessionProvider.notifier).deleteAccount();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _failed = true;
      });
      return;
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final error = Theme.of(context).colorScheme.error;
    return AlertDialog(
      title: const Text('계정을 삭제할까요?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s3,
        children: [
          const Text('계정을 삭제하면 즐겨찾기·팁·사진·투표가 모두 지워지고 되돌릴 수 없습니다.'),
          if (_failed)
            Text(
              '계정을 삭제하지 못했어요 · 잠시 후 다시 시도해 주세요',
              style: AppTextStyles.captionXs.copyWith(color: error),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: _busy ? null : _delete,
          style: TextButton.styleFrom(foregroundColor: error),
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
