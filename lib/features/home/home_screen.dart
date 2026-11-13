import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/metric/format.dart';
import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/listing_card_mobile.dart';
import '../../shared/widgets/search_pill_mobile.dart';
import 'home_providers.dart';
import 'widgets/category_strip.dart';
import 'widgets/select_label.dart';

/// M-01 홈. 검색 필 · 카테고리 스트립 · 인기 지역 12곳 카드.
///
/// 아직 없는 것(M2): 자연어 검색 입력(M-01b)과 "AI가 이해한 조건" 줄,
/// 카드 → 지역 상세(M-03) 이동, 즐겨찾기 저장(M4).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(homeFilterProvider);
    final notifier = ref.read(homeFilterProvider.notifier);
    final popular = ref.watch(popularRegionsProvider(filter.month));

    return Scaffold(
      appBar: const _HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.s4,
              AppSpacing.s3,
              AppSpacing.s4,
              AppSpacing.s4,
            ),
            sliver: SliverToBoxAdapter(child: SearchPillMobile()),
          ),
          SliverToBoxAdapter(
            child: CategoryStrip(
              filter: filter,
              onTerrain: notifier.toggleTerrain,
              onPreset: notifier.setPreset,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s4),
            sliver: SliverToBoxAdapter(child: Divider()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s4,
              AppSpacing.s2,
              AppSpacing.s4,
              AppSpacing.s2,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      popular.maybeWhen(
                        data: (r) => '인기 지역 ${r.items.length}곳',
                        orElse: () => '인기 지역',
                      ),
                      style: AppTextStyles.headingLg,
                    ),
                  ),
                  SelectLabel<PresetKey>(
                    label: '${filter.preset.label} 프리셋',
                    value: filter.preset,
                    options: const [PresetKey.quiet, PresetKey.lively],
                    optionLabel: (p) => p.label,
                    onSelected: notifier.setPreset,
                  ),
                  const SizedBox(width: AppSpacing.s3),
                  SelectLabel<PopularSort>(
                    label: filter.sort.label,
                    value: filter.sort,
                    options: PopularSort.values,
                    optionLabel: (s) => s.label,
                    onSelected: notifier.setSort,
                  ),
                ],
              ),
            ),
          ),
          ...popular.when(
            loading: () => const [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
            error: (error, stack) => [
              SliverFillRemaining(
                hasScrollBody: false,
                child: _Message(
                  text: '인기 지역을 불러오지 못했습니다',
                  actionLabel: '다시 시도',
                  onAction: () =>
                      ref.invalidate(popularRegionsProvider(filter.month)),
                ),
              ),
            ],
            data: (response) {
              final cards = buildPopularCards(response.items, filter);
              if (cards.isEmpty) {
                return const [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _Message(text: '조건에 맞는 지역이 없어요'),
                  ),
                ];
              }
              final month = Months.label(response.month);
              return [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s4,
                    AppSpacing.s2,
                    AppSpacing.s4,
                    AppSpacing.s6,
                  ),
                  sliver: SliverList.separated(
                    itemCount: cards.length,
                    separatorBuilder: (context, i) =>
                        const SizedBox(height: AppSpacing.s6),
                    itemBuilder: (context, i) {
                      final card = cards[i];
                      final r = card.region;
                      return ListingCardMobile(
                        key: ValueKey(r.id),
                        title: '${r.name}, ${r.province}',
                        score: card.score,
                        meta: r.tags.join(' · '),
                        meta2:
                            '즐겨찾기 ${formatCount(r.favoriteCount)}'
                            ' · 조회 ${formatCount(r.viewCount)} · $month',
                        photos: [r.photoUrl],
                        badge: card.badge,
                        grades: [
                          for (final key in const [
                            MetricKey.quiet,
                            MetricKey.peer,
                            MetricKey.overnight,
                          ])
                            (key.shortLabel, card.grades[key]!),
                        ],
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AppBar(
      titleSpacing: AppSpacing.s4,
      title: Row(
        spacing: AppSpacing.s2,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: AppRadius.lgAll,
            ),
            child: Icon(LucideIcons.mapPin, size: 16, color: scheme.onPrimary),
          ),
          Text(
            '워케이션맵',
            style: AppTextStyles.displayLogo.copyWith(color: scheme.primary),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.actionLabel, this.onAction});

  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.s3,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBase.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (actionLabel != null)
            OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}
