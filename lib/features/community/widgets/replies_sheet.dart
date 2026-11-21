import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/relative_time.dart';
import '../../../data/models/community.dart';
import '../../../shared/widgets/avatar.dart';
import '../../auth/auth_providers.dart';
import '../../auth/login_gate.dart';
import '../community_providers.dart';
import 'section_header.dart';

/// 답글 한 개의 최대 글자 수(서버 `REPLY_MAX_LEN`).
const replyMaxLength = 300;

/// 팁의 답글 시트를 띄웁니다. 원래 팁 · 답글 목록(오래된 순) · 입력칸.
/// 읽기는 로그인 없이 되고, 쓰기 · 삭제는 로그인한 사용자만 합니다.
/// 답글 수가 바뀌면 [target] 의 팁 목록에서 그 팁의 숫자도 맞춥니다.
Future<void> showRepliesSheet(
  BuildContext context, {
  required CommunityTarget target,
  required Tip tip,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => RepliesSheet(target: target, tip: tip),
  );
}

/// [showRepliesSheet] 의 내용.
class RepliesSheet extends ConsumerStatefulWidget {
  const RepliesSheet({super.key, required this.target, required this.tip});

  final CommunityTarget target;
  final Tip tip;

  @override
  ConsumerState<RepliesSheet> createState() => _RepliesSheetState();
}

class _RepliesSheetState extends ConsumerState<RepliesSheet> {
  final _controller = TextEditingController();
  var _busy = false;

  /// 시트 안에 보여 주는 실패 안내(스낵바는 시트 뒤에 가려집니다).
  String? _error;

  String get _tipId => widget.tip.id;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 목록 길이로 팁 카드의 답글 수를 맞춥니다.
  void _syncCount() {
    final count = ref.read(repliesProvider(_tipId)).value?.length;
    if (count == null) return;
    ref.read(tipsProvider(widget.target).notifier).setReplyCount(_tipId, count);
  }

  Future<void> _run(Future<void> Function() action, String failMessage) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      if (mounted) _syncCount();
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(
        () => _error = e is ServerException && e.statusCode == 429
            ? '답글을 너무 빠르게 올리고 있어요. 잠시 후 다시 시도해 주세요'
            : failMessage,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _submit() async {
    final body = _controller.text.trim();
    if (body.isEmpty || _busy) return;
    if (!await ensureLoggedIn(context, ref)) return;
    final user = ref.read(sessionProvider);
    if (!mounted || user == null) return;
    await _run(() async {
      await ref
          .read(repliesProvider(_tipId).notifier)
          .post(body, authorName: user.nickname);
      _controller.clear();
    }, '답글을 등록하지 못했어요');
  }

  Future<void> _delete(Reply reply) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('답글을 삭제할까요?'),
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
    if (ok != true || !mounted) return;
    await _run(
      () => ref.read(repliesProvider(_tipId).notifier).delete(reply.id),
      '답글을 삭제하지 못했어요',
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    final replies = ref.watch(repliesProvider(_tipId));
    final items = replies.value;
    final tip = widget.tip;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      child: Padding(
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
              items == null ? '답글' : '답글 ${items.length}',
              style: AppTextStyles.headingLg,
            ),
            // 원래 팁
            Container(
              padding: const EdgeInsets.all(AppSpacing.s3),
              decoration: BoxDecoration(
                color: colors.bgSubtle,
                borderRadius: AppRadius.lgAll,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.s1,
                children: [
                  Text(
                    tip.author.nickname,
                    style: AppTextStyles.captionXsBold.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    tip.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySm,
                  ),
                ],
              ),
            ),
            Flexible(
              child: items != null
                  ? items.isEmpty
                        ? const SectionNotice('아직 답글이 없어요. 첫 답글을 남겨보세요')
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: items.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.s3),
                            itemBuilder: (_, i) => _ReplyTile(
                              items[i],
                              key: ValueKey(items[i].id),
                              onDelete: _busy ? null : () => _delete(items[i]),
                            ),
                          )
                  : replies.hasError
                  ? SectionNotice(
                      '답글을 불러오지 못했어요',
                      onRetry: () => ref.invalidate(repliesProvider(_tipId)),
                    )
                  : const SectionNotice('불러오는 중…'),
            ),
            if (_error != null)
              Text(
                _error!,
                style: AppTextStyles.captionXs.copyWith(color: scheme.error),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppSpacing.s2,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLength: replyMaxLength,
                    maxLines: 3,
                    minLines: 1,
                    textInputAction: TextInputAction.newline,
                    style: AppTextStyles.bodySm,
                    decoration: InputDecoration(
                      hintText: '답글을 남겨보세요',
                      hintStyle: AppTextStyles.bodySm.copyWith(
                        color: colors.textTertiary,
                      ),
                      // 글자 수는 상한에 가까워질 때만 보입니다.
                      counterText: '',
                      isDense: true,
                    ),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, _) => IconButton.filled(
                    tooltip: '답글 등록',
                    onPressed: value.text.trim().isEmpty || _busy
                        ? null
                        : _submit,
                    icon: const Icon(LucideIcons.send, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplyTile extends StatelessWidget {
  const _ReplyTile(this.reply, {super.key, this.onDelete});

  final Reply reply;

  /// 내 답글일 때만 [삭제] 가 보입니다. null 이면 누를 수 없습니다(처리 중).
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Avatar(initial: reply.author.initial, size: AvatarSize.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Row(
                spacing: AppSpacing.s2,
                children: [
                  Flexible(
                    child: Text(
                      reply.author.nickname,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.captionXsBold,
                    ),
                  ),
                  Text(
                    relativeTime(reply.createdAt),
                    style: AppTextStyles.captionXs.copyWith(color: tertiary),
                  ),
                ],
              ),
              Text(reply.body, style: AppTextStyles.bodySm),
            ],
          ),
        ),
        if (reply.mine)
          TextButton(
            onPressed: onDelete,
            style: TextButton.styleFrom(
              foregroundColor: scheme.onSurfaceVariant,
              textStyle: AppTextStyles.captionXs,
              minimumSize: const Size(44, 32),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('삭제'),
          ),
      ],
    );
  }
}
