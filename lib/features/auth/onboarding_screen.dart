import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import 'auth_providers.dart';

const nicknameMin = 2;
const nicknameMax = 12;

/// 공백을 다듬은 길이가 2~12자면 null, 아니면 안내 문구(웹 `nickname.ts`, 백엔드 PATCH 규칙과 같음).
String? validateNickname(String value) {
  final len = value.trim().runes.length;
  if (len < nicknameMin || len > nicknameMax) {
    return '닉네임은 $nicknameMin~$nicknameMax자로 입력해 주세요';
  }
  return null;
}

/// 첫 로그인: 닉네임 + 약관 2개(웹 OnboardingModal 과 같은 내용, Figma 시안 없음).
/// 마치면 `pop(true)`, 닫으면 로그아웃하고 `pop(false)` 입니다.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, required this.user});

  final AuthUser user;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final _nickname = TextEditingController(text: widget.user.nickname);
  bool _terms = false;
  bool _privacy = false;
  bool _busy = false;

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }

  String? get _error => validateNickname(_nickname.text);

  bool get _canSubmit => _error == null && _terms && _privacy && !_busy;

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(sessionProvider.notifier)
          .completeOnboarding(_nickname.text);
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _busy = false);
      _snack('저장하지 못했습니다. 다시 시도해 주세요');
    }
  }

  Future<void> _cancel() async {
    if (_busy) return;
    setState(() => _busy = true);
    await ref.read(sessionProvider.notifier).cancelOnboarding();
    if (!mounted) return;
    _snack('약관에 동의해야 이용할 수 있어요');
    Navigator.of(context).pop(false);
  }

  void _snack(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  @override
  Widget build(BuildContext context) {
    // onSurfaceVariant = text/secondary
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _cancel();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              tooltip: '닫기',
              onPressed: _busy ? null : _cancel,
              icon: const Icon(LucideIcons.x),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
            children: [
              Text('거의 다 됐어요', style: AppTextStyles.headingXl),
              const SizedBox(height: AppSpacing.s2),
              Text(
                '닉네임과 약관 동의만 하면 바로 시작할 수 있어요.',
                style: AppTextStyles.bodySm.copyWith(color: secondary),
              ),
              const SizedBox(height: AppSpacing.s6),
              TextField(
                controller: _nickname,
                maxLength: nicknameMax,
                enabled: !_busy,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: '닉네임',
                  helperText: '$nicknameMin~$nicknameMax자 · 공개',
                  errorText: _error,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              CheckboxListTile(
                value: _terms,
                onChanged: _busy
                    ? null
                    : (v) => setState(() => _terms = v ?? false),
                title: const Text('이용약관에 동의합니다'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: _privacy,
                onChanged: _busy
                    ? null
                    : (v) => setState(() => _privacy = v ?? false),
                title: const Text('개인정보 처리방침에 동의합니다'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: AppSpacing.s6),
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: _canSubmit ? _submit : null,
                  child: _busy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('시작하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
