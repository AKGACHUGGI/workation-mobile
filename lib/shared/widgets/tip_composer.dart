import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/month.dart';
import '../../core/photo/photo_picker.dart';
import '../../core/theme/app_theme.dart';
import 'app_chip.dart';
import 'avatar.dart';
import 'photo_pick_strip.dart';

/// 팁 한 줄의 최대 글자 수(서버 `TIP_MAX_LEN` · 웹 `NOTE_MAX_LEN` 과 같음).
const tipMaxLength = 300;

/// 팁 입력 시트에서 쓴 내용.
@immutable
class TipDraft {
  const TipDraft({required this.body, this.visitMonth, this.photos = const []});

  /// 앞뒤 공백을 뗀 본문
  final String body;

  /// 방문 월(`2025-10`). 고르지 않았으면 null
  final String? visitMonth;

  /// 붙일 사진(0~3장, 고른 순서)
  final List<PickedPhoto> photos;
}

/// 사진 보관함을 열어 최대 [max] 장을 고르는 함수. 열지 못하면 [PhotoPickException].
typedef PickPhotos = Future<List<PickedPhoto>> Function(int max);

/// 시트의 [등록] 을 눌렀을 때 부르는 함수. 성공하면 null, 실패하면 시트 안에 보여 줄
/// 안내 문구를 돌려줍니다(스낵바는 시트 뒤에 가려집니다).
typedef TipSubmit = Future<String?> Function(TipDraft draft);

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
                      Avatar(initial: initial, size: AvatarSize.sm),
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

/// 팁 입력 바텀시트를 띄웁니다. [등록] 을 누르면 [onSubmit] 을 부르고, 끝날 때까지
/// "올리는 중…" 으로 기다립니다. 성공하면 닫고 true, 실패하면 입력을 그대로 둔 채 안내를
/// 보여 줍니다. 그냥 닫으면 false.
///
/// 빈 값(공백만 포함)은 등록할 수 없고, 글자 수는 [maxLength] 로 막습니다.
/// 방문 월은 [initialVisitMonth](화면의 달, 연간이면 null)에서 시작해 바꿀 수 있습니다.
///
/// [onPickPhotos] 를 주면 사진을 0~3장 붙일 수 있습니다(미리 보기 · 빼기).
///
/// [editingBody] 를 주면 내 팁 고치기입니다. 본문을 채운 채 열고 [저장] 은 본문이 바뀌었을
/// 때만 켜집니다. 서버가 본문만 고치므로 방문 월 · 사진은 고르지 않습니다.
Future<bool> showTipComposerSheet(
  BuildContext context, {
  required TipSubmit onSubmit,
  String hint = '이 지역에서 알게 된 팁을 남겨보세요',
  int maxLength = tipMaxLength,
  String? initialVisitMonth,
  String? editingBody,
  PickPhotos? onPickPhotos,
}) async {
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => TipComposerSheet(
      hint: hint,
      maxLength: maxLength,
      initialVisitMonth: initialVisitMonth,
      editingBody: editingBody,
      onPickPhotos: onPickPhotos,
      onSubmit: onSubmit,
    ),
  );
  return done ?? false;
}

/// [showTipComposerSheet] 의 내용.
class TipComposerSheet extends StatefulWidget {
  const TipComposerSheet({
    super.key,
    required this.hint,
    required this.onSubmit,
    this.maxLength = tipMaxLength,
    this.initialVisitMonth,
    this.editingBody,
    this.onPickPhotos,
  });

  final String hint;
  final TipSubmit onSubmit;
  final int maxLength;
  final String? initialVisitMonth;

  /// 고치는 팁의 지금 본문. null 이면 새 팁입니다.
  final String? editingBody;

  /// 사진 고르기. null 이면 사진 줄을 그리지 않습니다.
  final PickPhotos? onPickPhotos;

  @override
  State<TipComposerSheet> createState() => _TipComposerSheetState();
}

class _TipComposerSheetState extends State<TipComposerSheet> {
  late final _controller = TextEditingController(text: widget.editingBody);
  final _selectedMonthKey = GlobalKey();
  late String? _visitMonth = widget.initialVisitMonth;
  final _photos = <PickedPhoto>[];
  var _sending = false;
  var _picking = false;
  String? _error;

  bool get _editing => widget.editingBody != null;

  /// 보낼 수 있는 본문인지: 비어 있지 않고, 고칠 때는 지금 본문과 달라야 합니다.
  bool _canSubmit(String text) {
    final trimmed = text.trim();
    return trimmed.isNotEmpty && trimmed != widget.editingBody?.trim();
  }

  @override
  void initState() {
    super.initState();
    // 고른 달(예: 12월)이 줄 밖에 있으면 보이는 곳으로 옮깁니다.
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealMonth());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _revealMonth() {
    final ctx = _selectedMonthKey.currentContext;
    if (ctx != null) Scrollable.ensureVisible(ctx, alignment: 0.5);
  }

  Future<void> _addPhotos() async {
    final pick = widget.onPickPhotos;
    final room = photoMaxCount - _photos.length;
    if (pick == null || room <= 0 || _picking) return;
    setState(() {
      _picking = true;
      _error = null;
    });
    try {
      final result = checkPhotos(await pick(room), room: room);
      if (!mounted) return;
      setState(() {
        _photos.addAll(result.accepted);
        _error = result.rejected;
      });
    } on PhotoPickException {
      if (!mounted) return;
      setState(() => _error = '사진을 불러오지 못했어요. 사진 접근 권한을 확인해 주세요');
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (!_canSubmit(text) || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    final error = await widget.onSubmit(
      TipDraft(
        body: text,
        visitMonth: _editing ? null : _visitMonth,
        photos: List.unmodifiable(_photos),
      ),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _sending = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    // 보내는 동안에는 바깥을 눌러도 닫히지 않습니다.
    return PopScope(
      canPop: !_sending,
      child: SingleChildScrollView(
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
            Text(
              _editing ? '팁 수정' : '한 줄 팁 남기기',
              style: AppTextStyles.headingLg,
            ),
            TextField(
              controller: _controller,
              autofocus: true,
              enabled: !_sending,
              maxLength: widget.maxLength,
              maxLines: 5,
              minLines: 2,
              textInputAction: TextInputAction.newline,
              style: AppTextStyles.bodySm,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTextStyles.bodySm.copyWith(color: tertiary),
                counterStyle: AppTextStyles.captionXs.copyWith(color: tertiary),
              ),
            ),
            if (!_editing)
              _VisitMonthPicker(
                value: _visitMonth,
                selectedKey: _selectedMonthKey,
                onChanged: _sending
                    ? null
                    : (month) => setState(() => _visitMonth = month),
              ),
            if (!_editing && widget.onPickPhotos != null)
              PhotoPickStrip(
                photos: _photos,
                onAdd: _sending || _picking ? null : _addPhotos,
                onRemove: _sending
                    ? null
                    : (i) => setState(() => _photos.removeAt(i)),
              ),
            if (_error != null)
              Text(
                _error!,
                style: AppTextStyles.captionXs.copyWith(color: scheme.error),
              ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, _) => FilledButton(
                onPressed: !_canSubmit(value.text) || _sending ? null : _submit,
                child: Text(switch ((_editing, _sending)) {
                  (false, false) => '등록',
                  (false, true) => '올리는 중…',
                  (true, false) => '저장',
                  (true, true) => '저장하는 중…',
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 방문 월 고르기: `없음` + 1~12월 가운데 하나. `없음` 은 늘 보이고 달은 옆으로 넘깁니다.
class _VisitMonthPicker extends StatelessWidget {
  const _VisitMonthPicker({
    required this.value,
    required this.selectedKey,
    required this.onChanged,
  });

  /// `2025-10`. 고르지 않았으면 null
  final String? value;

  /// 지금 고른 달의 칩에 붙이는 키(보이는 곳으로 옮길 때 씁니다)
  final Key selectedKey;

  /// null 이면 누를 수 없습니다.
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final onChanged = this.onChanged;

    Widget chip(String? month) => AppChip(
      key: month != null && month == value ? selectedKey : null,
      label: month == null ? '없음' : Months.label(month),
      selected: month == value,
      onTap: onChanged == null ? null : () => onChanged(month),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s2,
      children: [
        Text(
          '방문 월',
          style: AppTextStyles.captionXsMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          spacing: AppSpacing.s2,
          children: [
            chip(null),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: AppSpacing.s2,
                  children: [for (var m = 1; m <= 12; m++) chip(Months.of(m))],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
