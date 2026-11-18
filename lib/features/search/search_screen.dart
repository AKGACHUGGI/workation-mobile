import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/search_intent.dart';
import '../../data/repositories/search_repository.dart';
import '../../shared/widgets/tag.dart';
import 'search_providers.dart';

/// "이렇게 물어보세요" 예시 (Figma M-01b v2).
const searchExamples = <(IconData, String)>[
  (LucideIcons.waves, '11월 바다 보이는 조용한 동네에서 2주'),
  (LucideIcons.users, '또래가 많고 밤에도 활기찬 도시'),
  (LucideIcons.mountain, '단풍철 산간 마을에서 한 달 살기'),
];

/// M-01b 자연어 검색 입력.
///
/// 문장을 적고 잠시 멈추면 조건을 읽어 미리 보여주고, [이 조건으로 추천 받기] 를
/// 누르면 홈(M-01)에 반영한 뒤 돌아갑니다. 응답이 몇 초 걸릴 수 있어(LLM) 읽는 중 ·
/// 실패 · 조건 없음 상태를 따로 그리고, 문장을 고치면 앞선 요청의 결과는 버립니다.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  /// 입력을 멈춘 뒤 조건을 읽기까지 기다리는 시간.
  static const debounce = Duration(milliseconds: 600);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  /// 가장 최근 요청 번호. 늦게 온 옛 응답을 버리는 데 씁니다.
  int _seq = 0;

  /// [_result] 가 어느 문장의 결과인지.
  String? _parsedText;
  AsyncValue<SearchIntent>? _result;
  bool _submitting = false;

  String get _text => _controller.text.trim();

  @override
  void initState() {
    super.initState();
    // "조건 수정" 으로 들어오면 적용된 문장과 조건에서 이어서 고칩니다.
    final applied = ref.read(appliedSearchProvider);
    if (applied != null) {
      _controller.text = applied.query;
      _parsedText = applied.query;
      _result = AsyncData(applied.intent);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    _debounce?.cancel();
    final text = _text;
    if (text == _parsedText) return;
    setState(() {
      _seq++;
      _parsedText = null;
      _result = null;
    });
    if (text.isNotEmpty) {
      _debounce = Timer(SearchScreen.debounce, () => _parse(text));
    }
  }

  /// 조건을 읽습니다. 실패했거나 그 사이 문장이 바뀌었으면 null.
  Future<SearchIntent?> _parse(String text) async {
    _debounce?.cancel();
    final seq = ++_seq;
    setState(() {
      _parsedText = text;
      _result = const AsyncLoading();
    });
    try {
      final intent = await ref.read(searchRepositoryProvider).parse(text);
      if (!mounted || seq != _seq) return null;
      setState(() => _result = AsyncData(intent));
      return intent;
    } on Exception catch (error, stack) {
      if (!mounted || seq != _seq) return null;
      setState(() => _result = AsyncError(error, stack));
      return null;
    }
  }

  void _pickExample(String example) {
    _controller.value = TextEditingValue(
      text: example,
      selection: TextSelection.collapsed(offset: example.length),
    );
    _parse(example);
  }

  void _removeTag(IntentTag tag) {
    final intent = _result?.value;
    if (intent == null) return;
    setState(() => _result = AsyncData(intent.without(tag)));
  }

  Future<void> _submit() async {
    final text = _text;
    if (text.isEmpty || _submitting) return;
    FocusScope.of(context).unfocus();

    var intent = _parsedText == text ? _result?.value : null;
    if (intent == null) {
      setState(() => _submitting = true);
      intent = await _parse(text);
      if (!mounted) return;
      setState(() => _submitting = false);
    }
    if (intent == null || intent.isEmpty) return;

    ref.read(appliedSearchProvider.notifier).apply(text, intent);
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final result = _result;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          tooltip: '뒤로',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text('AI 지역 추천', style: AppTextStyles.titleMd),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s4,
                  AppSpacing.s2,
                  AppSpacing.s4,
                  AppSpacing.s4,
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.s4),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: AppRadius.xxlAll,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.s3,
                      children: [
                        TextField(
                          controller: _controller,
                          onChanged: _onChanged,
                          autofocus: _controller.text.isEmpty,
                          minLines: 2,
                          maxLines: 5,
                          maxLength: 200,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submit(),
                          style: AppTextStyles.bodyBase,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                            filled: false,
                            counterText: '',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '예: 10월에 조용한 바닷가에서 한 달',
                            hintStyle: AppTextStyles.bodyBase.copyWith(
                              color: tertiary,
                            ),
                          ),
                        ),
                        Text(
                          '원하는 시기 · 분위기 · 동네를 문장으로 적어보세요. '
                          '12개 시군구 중 맞는 지역을 AI가 추천해요.',
                          style: AppTextStyles.captionXs.copyWith(
                            color: tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (result != null) ...[
                    const SizedBox(height: AppSpacing.s5),
                    _ParsedPreview(
                      result: result,
                      onRemove: _removeTag,
                      onRetry: () => _parse(_text),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.s5),
                  Text(
                    '이렇게 물어보세요',
                    style: AppTextStyles.captionXsMedium.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  for (final (icon, example) in searchExamples) ...[
                    const SizedBox(height: AppSpacing.s2),
                    _ExampleRow(
                      icon: icon,
                      text: example,
                      onTap: () => _pickExample(example),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s4,
                AppSpacing.s2,
                AppSpacing.s4,
                AppSpacing.s6,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) => FilledButton(
                    onPressed: _text.isEmpty || _submitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      textStyle: AppTextStyles.bodyBaseMedium,
                    ),
                    child: _submitting
                        ? SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: scheme.onPrimary,
                            ),
                          )
                        : const Text('이 조건으로 추천 받기'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "AI가 이렇게 이해했어요" 카드. 읽는 중 · 실패 · 조건 없음 · 조건 태그.
class _ParsedPreview extends StatelessWidget {
  const _ParsedPreview({
    required this.result,
    required this.onRemove,
    required this.onRetry,
  });

  final AsyncValue<SearchIntent> result;
  final ValueChanged<IntentTag> onRemove;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    Text note(String text) =>
        Text(text, style: AppTextStyles.captionXs.copyWith(color: tertiary));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: AppSpacing.s2,
            children: [
              const Icon(LucideIcons.sparkles),
              Text('AI가 이렇게 이해했어요', style: AppTextStyles.bodySmMedium),
            ],
          ),
          ...switch (result) {
            AsyncData(:final value) when value.isEmpty => [
              note('조건을 찾지 못했어요. 예시처럼 시기 · 분위기 · 동네를 적어보세요'),
            ],
            AsyncData(:final value) => [
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in value.tags)
                    Semantics(
                      button: true,
                      label: '${tag.label} 조건 빼기',
                      excludeSemantics: true,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onRemove(tag),
                        child: Tag(tag.label),
                      ),
                    ),
                ],
              ),
              note('틀린 조건은 눌러서 뺄 수 있어요'),
            ],
            AsyncError() => [
              Row(
                children: [
                  Expanded(child: note('조건을 읽지 못했어요')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onRetry,
                    child: Text(
                      '다시 시도',
                      style: AppTextStyles.captionXsMedium.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            _ => [
              Row(
                spacing: AppSpacing.s2,
                children: [
                  SizedBox.square(
                    dimension: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: tertiary,
                    ),
                  ),
                  note('조건을 읽는 중이에요'),
                ],
              ),
            ],
          },
        ],
      ),
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.xlAll,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: AppSpacing.s3,
          ),
          child: Row(
            spacing: 10,
            children: [
              Icon(icon),
              Expanded(child: Text(text, style: AppTextStyles.bodySm)),
            ],
          ),
        ),
      ),
    );
  }
}
