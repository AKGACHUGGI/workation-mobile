import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_theme.dart';
import 'avatar.dart';

/// 팁 한 줄의 최대 글자 수.
const tipMaxLength = 100;

/// 팁 작성 입력 바 (Figma TipComposer). 누르면 입력 시트로 이어집니다.
/// 로그인하지 않았으면 로그인을 권하는 문구와 [로그인] 버튼을 보여줍니다.
class TipComposer extends StatelessWidget {
  const TipComposer({
    super.key,
    required this.loggedIn,
    required this.onTap,
    this.initial = '나',
    this.hint = '이 지역에서 알게 된 팁을 남겨보세요',
  });

  final bool loggedIn;
  final VoidCallback onTap;

  /// 아바타 글자(로그인한 사용자 닉네임의 첫 글자)
  final String initial;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return Semantics(
      button: true,
      label: loggedIn ? hint : '로그인하고 팁 남기기',
      excludeSemantics: true,
      child: Material(
        color: colors.bgSubtle,
        borderRadius: AppRadius.xlAll,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 10, 10, 10),
            child: loggedIn
                ? Row(
                    spacing: AppSpacing.s3,
                    children: [
                      Avatar(initial, size: AvatarSize.sm),
                      Expanded(
                        child: Text(
                          hint,
                          style: AppTextStyles.bodySm.copyWith(
                            color: colors.textTertiary,
                          ),
                        ),
                      ),
                      Icon(
                        LucideIcons.camera,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                      const _FakeButton('등록'),
                    ],
                  )
                : Row(
                    spacing: AppSpacing.s3,
                    children: [
                      Icon(
                        LucideIcons.logIn,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                      Expanded(
                        child: Text(
                          '로그인하면 팁을 남기고 즐겨찾기를 기기 간에 동기화할 수 있어요',
                          style: AppTextStyles.bodySm.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const _FakeButton('로그인'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// 바 전체가 눌리는 영역이라 버튼은 모양만 냅니다.
class _FakeButton extends StatelessWidget {
  const _FakeButton(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s2,
      ),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: AppRadius.lgAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmMedium.copyWith(color: scheme.onPrimary),
      ),
    );
  }
}

/// 팁 입력 바텀시트를 띄우고, 등록한 본문(앞뒤 공백 제거)을 돌려줍니다. 닫으면 null.
/// 빈 값(공백만 포함)은 등록할 수 없고, 글자 수는 [maxLength] 로 막습니다.
Future<String?> showTipComposerSheet(
  BuildContext context, {
  String hint = '이 지역에서 알게 된 팁을 남겨보세요',
  int maxLength = tipMaxLength,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => TipComposerSheet(hint: hint, maxLength: maxLength),
  );
}

/// [showTipComposerSheet] 의 내용.
class TipComposerSheet extends StatefulWidget {
  const TipComposerSheet({
    super.key,
    required this.hint,
    this.maxLength = tipMaxLength,
  });

  final String hint;
  final int maxLength;

  @override
  State<TipComposerSheet> createState() => _TipComposerSheetState();
}

class _TipComposerSheetState extends State<TipComposerSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s4,
        AppSpacing.s4,
        AppSpacing.s4,
        AppSpacing.s4 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: [
          Text('한 줄 팁 남기기', style: AppTextStyles.headingLg),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: widget.maxLength,
            maxLines: 3,
            minLines: 2,
            textInputAction: TextInputAction.newline,
            style: AppTextStyles.bodySm,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodySm.copyWith(color: tertiary),
              counterStyle: AppTextStyles.captionXs.copyWith(color: tertiary),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) => FilledButton(
              onPressed: value.text.trim().isEmpty ? null : _submit,
              child: const Text('등록'),
            ),
          ),
        ],
      ),
    );
  }
}
