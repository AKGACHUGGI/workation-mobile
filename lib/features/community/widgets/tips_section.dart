import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';
import '../../../shared/widgets/tip_card.dart';
import '../../../shared/widgets/tip_composer.dart';
import '../../auth/auth_providers.dart';
import '../../auth/login_gate.dart';
import '../community_providers.dart';
import 'section_header.dart';

/// 워케이션 노트: 머리 · 입력 바 · 팁 카드 목록. 지역(M-03c)과 동네(M-04)가 같이 씁니다.
/// 입력 바를 누르면 로그인을 확인하고(비로그인이면 로그인 화면) 입력 시트를 엽니다.
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

  /// 등록하는 팁에 붙일 방문 월(`2025-10`). 연간이면 null
  final String? visitMonth;
  final String hint;

  Future<void> _compose(BuildContext context, WidgetRef ref) async {
    if (!await ensureLoggedIn(context, ref)) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final body = await showTipComposerSheet(context, hint: hint);
    final user = ref.read(sessionProvider);
    if (body == null || user == null) return;
    try {
      await ref
          .read(communityRepositoryProvider)
          .postTip(
            target,
            body: body,
            authorName: user.nickname,
            visitMonth: visitMonth,
          );
      ref.invalidate(tipsProvider(target));
    } on ApiException {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('팁을 등록하지 못했어요')));
    }
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
          for (final tip in data.items) TipCard(tip, key: ValueKey(tip.id)),
          if (data.items.isEmpty) const SectionNotice('아직 팁이 없어요. 첫 팁을 남겨보세요'),
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
