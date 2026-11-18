import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/me.dart';
import '../../data/models/region_detail.dart';
import '../../shared/widgets/mobile_sticky_bar.dart';
import '../../shared/widgets/photo_header.dart';
import '../../shared/widgets/score_display.dart';
import '../../shared/widgets/segmented_tabs.dart';
import '../../shared/widgets/tag.dart';
import '../favorites/favorite_actions.dart';
import '../favorites/favorites_providers.dart';
import '../home/home_providers.dart';
import 'region_providers.dart';
import 'widgets/dongs_tab.dart';
import 'widgets/info_tab.dart';
import 'widgets/season_tab.dart';

/// 지역 상세의 탭. [name] 이 `?tab=` 값입니다.
enum RegionTab {
  season('시기'),
  dongs('동네'),
  info('정보');

  const RegionTab(this.label);

  final String label;

  /// `?tab=dongs` → [dongs]. 없거나 모르는 값이면 [season].
  static RegionTab parse(String? raw) =>
      values.asNameMap()[raw] ?? RegionTab.season;
}

/// M-03 지역 상세. 사진 헤더 · 종합 점수 아래에 시기(M-03a) · 동네(M-03b) · 정보(M-03c) 탭.
///
/// 월과 프리셋은 홈에서 고른 값([homeFilterProvider])을 그대로 씁니다. 순위와 등급은
/// 같은 달 인기 지역 12곳 안에서 매깁니다. 정보 탭 · 즐겨찾기 · 공유는 다음 단계입니다.
class RegionScreen extends ConsumerStatefulWidget {
  const RegionScreen({
    super.key,
    required this.regionId,
    this.initialTab = RegionTab.season,
  });

  /// 시군구 코드 5자리
  final String regionId;
  final RegionTab initialTab;

  @override
  ConsumerState<RegionScreen> createState() => _RegionScreenState();
}

class _RegionScreenState extends ConsumerState<RegionScreen> {
  late RegionTab _tab = widget.initialTab;

  void _back() => context.canPop() ? context.pop() : context.go(AppRoutes.home);

  void _comingSoon(String what) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$what 기능은 준비 중이에요')));
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(homeFilterProvider);
    final arg = (id: widget.regionId, month: filter.month);
    final detail = ref.watch(regionDetailProvider(arg));
    final popular = ref.watch(popularRegionsProvider(filter.month));

    void retry() {
      ref.invalidate(regionDetailProvider(arg));
      ref.invalidate(popularRegionsProvider(filter.month));
    }

    // 다시 시도하는 동안에는 앞선 오류 대신 불러오는 중을 보여줍니다.
    Object? errorOf(AsyncValue<Object?> v) => v.isLoading ? null : v.error;
    final error = errorOf(detail) ?? errorOf(popular);
    if (error != null) {
      final notFound = error is NotFoundException;
      return _Fallback(
        onBack: _back,
        message: notFound ? '없는 지역이에요' : '지역 정보를 불러오지 못했습니다',
        onRetry: notFound ? null : retry,
      );
    }
    final d = detail.value;
    final items = popular.value?.items;
    if (d == null || items == null) return _Fallback(onBack: _back);

    final rank = rankRegion(items, d.id, filter.weights);
    if (rank == null) {
      return _Fallback(onBack: _back, message: '없는 지역이에요');
    }
    final month = Months.label(d.month);
    final preset = filter.preset.label;
    final saved = ref.watch(isRegionSavedProvider(d.id));
    void toggleSave() =>
        toggleFavoriteWithLogin(context, ref, FavoriteKind.regions, d.id);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PhotoHeader(
                photos: [for (final p in d.photos) p.url],
                onBack: _back,
                onShare: () => _comingSoon('공유'),
                saved: saved,
                onToggleSave: toggleSave,
              ),
            ),
            SliverToBoxAdapter(
              child: _TitleBlock(
                detail: d,
                meta: [...d.tags, month, '$preset 프리셋'].join(' · '),
                rankTag: '$preset ${rank.rank}위 · ${rank.grade.label}',
              ),
            ),
            const SliverToBoxAdapter(child: _Hairline()),
            SliverToBoxAdapter(
              child: Center(
                child: ScoreDisplay(
                  score: rank.score,
                  tagline: '$preset 프리셋 · ${rank.label}',
                  sub: [
                    '$month 기준',
                    for (final key in MetricKey.values)
                      '${key.shortLabel} '
                          '${metricGrade(rank.scores[key]).label}',
                  ].join(' · '),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: _Hairline()),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabsHeader(
                tab: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s6),
              sliver: SliverToBoxAdapter(
                child: switch (_tab) {
                  RegionTab.season => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s4,
                    ),
                    child: SeasonTab(detail: d),
                  ),
                  RegionTab.dongs => DongsTab(
                    detail: d,
                    onDongTap: (dong) => context.push(AppRoutes.dong(dong.id)),
                  ),
                  RegionTab.info => InfoTab(
                    detail: d,
                    rank: rank,
                    presetLabel: preset,
                    onLinkTap: (link) => _comingSoon('외부 링크 열기'),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MobileStickyBar(
        score: rank.score,
        scoreSuffix: '점 · $month',
        sub: '$preset · ${rank.label}',
        actionLabel: saved ? '저장됨' : '즐겨찾기',
        onAction: toggleSave,
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.detail,
    required this.meta,
    required this.rankTag,
  });

  final RegionDetail detail;

  /// 예: `해안 · 속초시 인접 · 10월 · 조용한 곳 프리셋`
  final String meta;

  /// 예: `조용한 곳 3위 · S`
  final String rankTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s4,
        AppSpacing.s4,
        AppSpacing.s4,
        AppSpacing.s3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            '${detail.name}, ${detail.province}',
            style: AppTextStyles.headingXl,
          ),
          Text(
            meta,
            style: AppTextStyles.bodySm.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (detail.tags.isNotEmpty) Tag(detail.tags.first),
              Tag(detail.seasonType.label),
              Tag(rankTag, tone: TagTone.brand),
            ],
          ),
        ],
      ),
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Divider(),
    );
  }
}

/// 스크롤해도 위에 붙어 있는 시기 · 동네 · 정보 탭.
class _TabsHeader extends SliverPersistentHeaderDelegate {
  const _TabsHeader({required this.tab, required this.onChanged});

  final RegionTab tab;
  final ValueChanged<RegionTab> onChanged;

  // 위 8 + 탭 44 + 아래 12
  static const _height = 64.0;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s4,
          AppSpacing.s2,
          AppSpacing.s4,
          AppSpacing.s3,
        ),
        child: SegmentedTabs(
          labels: [for (final t in RegionTab.values) t.label],
          index: tab.index,
          onChanged: (i) => onChanged(RegionTab.values[i]),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_TabsHeader oldDelegate) => oldDelegate.tab != tab;
}

/// 불러오는 중이거나 실패했을 때. 뒤로 가기는 항상 둡니다.
class _Fallback extends StatelessWidget {
  const _Fallback({required this.onBack, this.message, this.onRetry});

  final VoidCallback onBack;

  /// null 이면 불러오는 중
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          tooltip: '뒤로',
          onPressed: onBack,
        ),
      ),
      body: Center(
        child: message == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.s3,
                children: [
                  Text(
                    message!,
                    style: AppTextStyles.bodyBase.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (onRetry != null)
                    OutlinedButton(
                      onPressed: onRetry,
                      child: const Text('다시 시도'),
                    ),
                ],
              ),
      ),
    );
  }
}
