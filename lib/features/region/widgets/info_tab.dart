import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/metric.dart';
import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../data/models/region_detail.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../community/widgets/photos_section.dart';
import '../../community/widgets/poll_section.dart';
import '../../community/widgets/section_header.dart';
import '../../community/widgets/tips_section.dart';
import '../region_providers.dart';
import '../region_reason.dart';

/// M-03c 정보 탭. 지표 카드 5개 · 추천 사유 · 외부 링크 · 한 줄 팁 · 체감 투표 · 이달의 사진.
class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
    required this.detail,
    required this.rank,
    required this.presetLabel,
    this.onLinkTap,
  });

  final RegionDetail detail;
  final RegionRank rank;
  final String presetLabel;

  /// 외부 링크를 눌렀을 때. 브라우저로 여는 일은 아직 없어서 화면이 안내만 합니다.
  final ValueChanged<RegionLink>? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final d = detail;
    final s = d.stats;
    final scores = rank.scores;
    final monthLabel = Months.label(d.month);
    final target = CommunityTarget.region(d.id);
    final reason = buildReason(
      monthLabel: monthLabel,
      presetLabel: presetLabel,
      composite: rank.score.round(),
      rank: rank.rank,
      total: rank.total,
      grade: rank.grade,
      overnightCoef: s.overnightCoef,
      dayInflow: s.dayInflow,
      crowdIndex: s.crowdIndex,
      crowdGrade: metricGrade(scores.crowd),
      bestMonths: d.bestMonths,
      peerOffpeakMonths: d.peerOffpeakMonths,
    );

    MetricCard card(MetricKey key, String subtitle) => MetricCard(
      label: key.label,
      score: scores[key],
      grade: metricGrade(scores[key]),
      subtitle: subtitle,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s4,
        children: [
          SectionHeader(
            title: '핵심 지표 ${MetricKey.values.length}종',
            caption: '$monthLabel · 시군구 ${rank.total}곳 백분위',
          ),
          MetricGrid(
            cards: [
              card(
                MetricKey.crowd,
                '$monthLabel 혼잡 ${s.crowdIndex} · 최대 대비 ${s.crowdIndex}%',
              ),
              card(
                MetricKey.quiet,
                '낮 유입 지수 ${s.dayInflow.toStringAsFixed(2)}'
                ' · ${s.quietRank}위',
              ),
              card(MetricKey.peer, '20~40대 방문 ${s.peerShare}%'),
              card(
                MetricKey.overnight,
                '숙박 계수 ${s.overnightCoef.toStringAsFixed(2)}',
              ),
              card(MetricKey.vibe, '저녁 유동 ÷ 체류 · ${rankCopy(scores.vibe)}'),
            ],
          ),
          _ReasonCard(sentences: reason),
          if (d.links.isNotEmpty) _LinksCard(links: d.links, onTap: onLinkTap),
          TipsSection(
            target: target,
            title: '워케이션 노트',
            visitMonth: d.month == Months.annual ? null : d.month,
          ),
          PollSection(
            target: target,
            month: d.month,
            question:
                '${Months.label(d.month == Months.annual ? Months.defaultMonth : d.month)} '
                '${d.name}, 실제로 조용했나요?',
            participationLabel: '지표 검증에 반영돼요',
          ),
          PhotosSection(target: target, month: d.month),
        ],
      ),
    );
  }
}

class _ReasonCard extends StatelessWidget {
  const _ReasonCard({required this.sentences});

  final List<String> sentences;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: colors.brandSoft,
        borderRadius: AppRadius.xlAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s3,
        children: [
          Row(
            spacing: AppSpacing.s2,
            children: [
              Icon(LucideIcons.sun, size: 18, color: scheme.primary),
              Text(
                '추천 사유',
                style: AppTextStyles.headingLg.copyWith(color: scheme.primary),
              ),
            ],
          ),
          Text(sentences.join(' '), style: AppTextStyles.bodySm),
          Text(
            '규칙 기반 템플릿(MVP) → 2차 LLM 문장',
            style: AppTextStyles.captionXs.copyWith(color: colors.textTertiary),
          ),
        ],
      ),
    );
  }
}

class _LinksCard extends StatelessWidget {
  const _LinksCard({required this.links, this.onTap});

  final List<RegionLink> links;
  final ValueChanged<RegionLink>? onTap;

  static IconData _icon(String kind) => switch (kind) {
    'support' => LucideIcons.fileText,
    'stay' => LucideIcons.bed,
    _ => LucideIcons.mapPin,
  };

  /// `https://www.gwgs.go.kr/tour` → `gwgs.go.kr`
  static String _host(String url) {
    final host = Uri.tryParse(url)?.host ?? url;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = Theme.of(context).extension<AppSemanticColors>()!;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (final (i, link) in links.indexed)
            InkWell(
              onTap: onTap == null ? null : () => onTap!(link),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s4,
                  vertical: AppSpacing.s3,
                ),
                decoration: BoxDecoration(
                  border: i < links.length - 1
                      ? Border(bottom: BorderSide(color: scheme.outlineVariant))
                      : null,
                ),
                child: Row(
                  spacing: AppSpacing.s3,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colors.bgSubtle,
                        borderRadius: AppRadius.lgAll,
                      ),
                      child: Icon(
                        _icon(link.kind),
                        size: 18,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2,
                        children: [
                          Text(
                            linkKindLabel(link.kind),
                            style: AppTextStyles.captionXsMedium.copyWith(
                              color: colors.textTertiary,
                            ),
                          ),
                          Text(link.title, style: AppTextStyles.bodySmMedium),
                          Text(
                            _host(link.url),
                            style: AppTextStyles.captionXs.copyWith(
                              color: colors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      LucideIcons.externalLink,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
