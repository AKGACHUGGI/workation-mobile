import 'package:flutter/material.dart';

import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/me.dart';
import '../../../shared/widgets/tag.dart';

/// 내가 쓴 팁 한 장. 어느 지역 · 동네에 남겼는지, 본문, 반응 수.
///
/// MY 전용입니다. 지역 · 동네 상세의 공용 `TipCard` 는 따로 만들어집니다.
/// Figma M-07 v2 에는 팁 탭 화면이 없어 웹 `MyTips` 를 따라 모바일 폭에 맞췄습니다.
class MyTipTile extends StatelessWidget {
  const MyTipTile({super.key, required this.tip, this.onTap});

  final MyTip tip;
  final VoidCallback? onTap;

  /// `2025-10-20T18:30:00+09:00` → `2025.10.20`
  static String dateLabel(String iso) =>
      iso.length >= 10 ? iso.substring(0, 10).replaceAll('-', '.') : iso;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final month = tip.visitMonth;
    final where = [
      ?tip.dongName,
      ?tip.stayLabel,
      if (month != null) '${Months.label(month)} 방문',
    ].join(' · ');

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
          padding: const EdgeInsets.all(AppSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s2,
            children: [
              Row(
                spacing: 6,
                children: [
                  Tag(tip.target.name, tone: TagTone.brand),
                  if (where.isNotEmpty)
                    Expanded(
                      child: Text(
                        where,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.captionXs.copyWith(
                          color: tertiary,
                        ),
                      ),
                    ),
                ],
              ),
              Text(tip.body, style: AppTextStyles.bodySm),
              Text(
                '도움돼요 ${tip.helpful} · 답글 ${tip.replies}'
                ' · ${dateLabel(tip.createdAt)}',
                style: AppTextStyles.captionXs.copyWith(color: tertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
