import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/metric/format.dart';
import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/listing_card_mobile.dart';
import '../../shared/widgets/search_pill_mobile.dart';
import '../auth/auth_providers.dart';
import '../auth/login_gate.dart';
import '../favorites/favorite_actions.dart';
import '../favorites/favorites_providers.dart';
import '../search/search_providers.dart';
import '../../data/models/me.dart';
import 'home_providers.dart';
import 'widgets/category_strip.dart';
import 'widgets/parsed_conditions.dart';
import 'widgets/select_label.dart';
import 'widgets/weights_sheet.dart';

/// M-01 홈. 검색 필 · 카테고리 스트립 · "AI가 이해한 조건" 줄 · 인기 지역 12곳 카드.
///
/// 검색 필을 누르면 자연어 입력(M-01b), 카드를 누르면 지역 상세(M-03)로 갑니다.
/// 헤더에는 가중치 시트 버튼과 로그인(로그인 후에는 아바타 → MY) 버튼이 있고,
/// 카드의 북마크는 저장합니다(비로그인이면 M-06 로그인 후 이어서 저장).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(homeFilterProvider);
    final notifier = ref.read(homeFilterProvider.notifier);
    final popular = ref.watch(popularRegionsProvider(filter.month));
    final search = ref.watch(appliedSearchProvider);
    void openSearch() => context.push(AppRoutes.search);

    return Scaffold(
      appBar: const _HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s4,
              AppSpacing.s3,
              AppSpacing.s4,
              AppSpacing.s4,
            ),
            sliver: SliverToBoxAdapter(
              child: search == null
                  ? SearchPillMobile(onTap: openSearch)
                  : SearchPillMobile(
                      title: search.query,
                      sub: search.summary,
                      onTap: openSearch,
                    ),
            ),
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
          if (search != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s4,
                AppSpacing.s3,
                AppSpacing.s4,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: ParsedConditions(
                  tags: [for (final t in search.intent.tags) t.label],
                  onEdit: openSearch,
                  onClear: ref.read(appliedSearchProvider.notifier).clear,
                ),
              ),
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
                        saved: ref.watch(isRegionSavedProvider(r.id)),
                        onToggleSave: () => toggleFavoriteWithLogin(
                          context,
                          ref,
                          FavoriteKind.regions,
                          r.id,
                        ),
                        onTap: () => context.push(AppRoutes.region(r.id)),
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

class _HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final user = ref.watch(sessionProvider);

    return AppBar(
      titleSpacing: AppSpacing.s4,
      actionsPadding: const EdgeInsets.only(right: AppSpacing.s3),
      actions: [
        IconButton(
          tooltip: '가중치',
          icon: const Icon(LucideIcons.slidersHorizontal, size: 20),
          onPressed: () => showWeightsSheet(context),
        ),
        if (user == null)
          IconButton(
            tooltip: '로그인',
            icon: const Icon(LucideIcons.logIn, size: 22),
            onPressed: () => ensureLoggedIn(context, ref),
          )
        else
          IconButton(
            tooltip: '내 계정',
            icon: Avatar(initial: user.initial),
            onPressed: () => context.go(AppRoutes.my),
          ),
      ],
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
