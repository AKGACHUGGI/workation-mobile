import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';
import '../../../shared/widgets/load_more_button.dart';
import '../../../shared/widgets/tip_card.dart';
import '../../../shared/widgets/tip_composer.dart';
import '../../auth/auth_providers.dart';
import '../../auth/login_gate.dart';
import '../../my/my_providers.dart';
import '../community_providers.dart';
import 'replies_sheet.dart';
import 'section_header.dart';
import 'tip_delete_dialog.dart';

/// 워케이션 노트: 머리 · 입력 바 · 팁 카드 목록. 지역(M-03c)과 동네(M-04)가 같이 씁니다.
/// 입력 바를 누르면 로그인을 확인하고(비로그인이면 로그인 화면) 입력 시트를 엽니다.
/// 방문 월은 시트에서 고르고, 등록에 실패하면 쓴 내용을 둔 채 시트 안에서 알립니다.
/// 카드의 도움돼요는 로그인 뒤 켜고 끄고, 답글은 답글 시트를 엽니다(읽기는 로그인 없이).
/// 내 팁은 카드의 ⋯ 메뉴로 고치고 지웁니다.
class TipsSection extends ConsumerWidget {
  const TipsSection({
    super.key,
    required this.target,
    required this.title,
    this.visitMonth,
    this.hint = '이 지역에서 알게 된 팁을 남겨보세요',
  });

  final CommunityTarget target;
  final String title;

  /// 입력 시트의 방문 월 처음 값(`2025-10`, 화면의 달). 연간이면 null
  final String? visitMonth;
  final String hint;

  Future<void> _compose(BuildContext context, WidgetRef ref) async {
    if (!await ensureLoggedIn(context, ref)) return;
    final user = ref.read(sessionProvider);
    if (!context.mounted || user == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final posted = await showTipComposerSheet(
      context,
      hint: hint,
      initialVisitMonth: visitMonth,
      onSubmit: (draft) async {
        try {
          await ref
              .read(communityRepositoryProvider)
              .postTip(
                target,
                body: draft.body,
                authorName: user.nickname,
                visitMonth: draft.visitMonth,
              );
        } on ApiException catch (e) {
          return e is ServerException && e.statusCode == 429
              ? '팁을 너무 빠르게 올리고 있어요. 잠시 후 다시 시도해 주세요'
              : '팁을 등록하지 못했어요';
        }
        ref.invalidate(tipsProvider(target));
        // MY 의 팁 수 · 내 팁 목록에도 보이게 합니다.
        ref.invalidate(meSummaryProvider);
        ref.invalidate(myTipsProvider);
        return null;
      },
    );
    if (!posted) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('팁을 남겼어요')));
  }

  /// 내 팁 고치기: 본문을 채운 입력 시트 → 저장하면 그 카드만 바꿉니다.
  Future<void> _edit(BuildContext context, WidgetRef ref, Tip tip) async {
    final messenger = ScaffoldMessenger.of(context);
    final saved = await showTipComposerSheet(
      context,
      hint: hint,
      editingBody: tip.body,
      onSubmit: (draft) async {
        try {
          await ref
              .read(tipsProvider(target).notifier)
              .editTip(tip, draft.body);
        } on ApiException {
          return '팁을 고치지 못했어요';
        }
        // MY 의 내 팁 목록에도 고친 본문이 보이게 합니다.
        ref.invalidate(myTipsProvider);
        return null;
      },
    );
    if (!saved) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('팁을 고쳤어요')));
  }

  /// 내 팁 지우기: 확인 → 삭제 → 목록 · 개수에서 빼고 MY(요약 · 내 팁)도 다시 읽게 합니다.
  Future<void> _delete(BuildContext context, WidgetRef ref, Tip tip) async {
    final messenger = ScaffoldMessenger.of(context);
    if (!await confirmTipDelete(context)) return;
    final deleted = await ref
        .read(tipsProvider(target).notifier)
        .deleteTip(tip);
    if (deleted) {
      ref.invalidate(meSummaryProvider);
      ref.invalidate(myTipsProvider);
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(deleted ? '팁을 삭제했어요' : '팁을 삭제하지 못했어요')),
      );
  }

  Future<void> _helpful(BuildContext context, WidgetRef ref, Tip tip) async {
    final wasLoggedIn = ref.read(isLoggedInProvider);
    if (!await ensureLoggedIn(context, ref)) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    void say(String message) => messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

    var current = tip;
    if (!wasLoggedIn) {
      // 방금 로그인했으면 목록이 내 표시(내 팁 · 이미 누름)와 함께 다시 읽힙니다.
      try {
        final fresh = await ref.read(tipsProvider(target).future);
        current = fresh.items.firstWhere(
          (t) => t.id == tip.id,
          orElse: () => tip,
        );
      } on ApiException {
        return say('도움돼요를 반영하지 못했어요');
      }
      // 누르려던 것이니, 이미 눌러 둔 팁을 끄지는 않습니다.
      if (current.myHelpful) return;
    }
    if (current.mine) return say('내 팁에는 도움돼요를 누를 수 없어요');

    final ok = await ref
        .read(tipsProvider(target).notifier)
        .toggleHelpful(current);
    if (!ok) say('도움돼요를 반영하지 못했어요');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tips = ref.watch(tipsProvider(target));
    final user = ref.watch(sessionProvider);
    final data = tips.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s4,
      children: [
        SectionHeader(
          title: title,
          caption: data == null ? null : '팁 ${data.total}개 · 도움순',
        ),
        TipComposer(
          loggedIn: user != null,
          initial: user?.initial ?? '나',
          hint: hint,
          onTap: () => _compose(context, ref),
        ),
        if (data != null) ...[
          for (final tip in data.items)
            TipCard(
              tip,
              key: ValueKey(tip.id),
              onHelpful: () => _helpful(context, ref, tip),
              onReplies: () =>
                  showRepliesSheet(context, target: target, tip: tip),
              onEdit: () => _edit(context, ref, tip),
              onDelete: () => _delete(context, ref, tip),
            ),
          if (data.items.isEmpty) const SectionNotice('아직 팁이 없어요. 첫 팁을 남겨보세요'),
          // 서버는 한 쪽에 20개씩 줍니다.
          if (data.nextCursor != null)
            LoadMoreButton(
              label: '팁 더 보기',
              onLoad: ref.read(tipsProvider(target).notifier).loadMore,
            ),
        ] else if (tips.hasError)
          SectionNotice(
            '팁을 불러오지 못했어요',
            onRetry: () => ref.invalidate(tipsProvider(target)),
          )
        else
          const SectionNotice('불러오는 중…'),
      ],
    );
  }
}
