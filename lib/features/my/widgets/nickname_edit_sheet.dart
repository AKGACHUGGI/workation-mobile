import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../auth/auth_providers.dart';
import '../../auth/onboarding_screen.dart'
    show nicknameMax, nicknameMin, validateNickname;

/// M-07 프로필 카드 [편집]: 닉네임 바꾸기 시트. 저장하면 닫고 true, 그냥 닫으면 null 입니다.
Future<bool?> showNicknameEditSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const NicknameEditSheet(),
  );
}

/// [showNicknameEditSheet] 의 내용. 지금 닉네임을 채운 채 열고, 2~12자(앞뒤 공백 제거)이면서
/// 지금과 다를 때만 [저장] 이 켜집니다. 실패하면 입력을 그대로 두고 안내를 띄웁니다.
class NicknameEditSheet extends ConsumerStatefulWidget {
  const NicknameEditSheet({super.key});

  @override
  ConsumerState<NicknameEditSheet> createState() => _NicknameEditSheetState();
}

class _NicknameEditSheetState extends ConsumerState<NicknameEditSheet> {
  late final _controller = TextEditingController(
    text: ref.read(sessionProvider)?.nickname ?? '',
  );
  bool _busy = false;
  bool _failed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _current => ref.read(sessionProvider)?.nickname ?? '';

  bool get _canSave =>
      validateNickname(_controller.text) == null &&
      _controller.text.trim() != _current &&
      !_busy;

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await ref.read(sessionProvider.notifier).updateNickname(_controller.text);
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _failed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s4,
        0,
        AppSpacing.s4,
        AppSpacing.s4 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: [
          Text('닉네임 바꾸기', style: AppTextStyles.headingLg),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: nicknameMax,
            enabled: !_busy,
            onChanged: (_) => setState(() => _failed = false),
            decoration: InputDecoration(
              labelText: '닉네임',
              helperText: '$nicknameMin~$nicknameMax자 · 공개',
              errorText: validateNickname(_controller.text),
              border: const OutlineInputBorder(),
            ),
          ),
          if (_failed)
            Text(
              '닉네임을 바꾸지 못했어요',
              style: AppTextStyles.captionXs.copyWith(color: scheme.error),
            ),
          AppButton('저장', expand: true, onPressed: _canSave ? _save : null),
        ],
      ),
    );
  }
}
