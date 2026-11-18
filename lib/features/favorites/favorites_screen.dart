import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/me.dart';
import '../../data/models/region_detail.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/dong_row.dart';
import '../../shared/widgets/icon_button_circle.dart';
import '../../shared/widgets/listing_card_mobile.dart';
import '../../shared/widgets/tag.dart';
import '../auth/auth_providers.dart';
import '../auth/widgets/login_prompt.dart';
import '../home/home_providers.dart';
import 'favorite_actions.dart';
import 'favorites_providers.dart';

/// M-05 즐겨찾기. 로그인 필수(결정 3). 저장한 지역 카드 + 동네 목록.
///
/// 비로그인이면 안내와 로그인 버튼, 저장한 것이 없으면 빈 상태를 보여줍니다.
/// 카드 → 지역 상세, 동네 → 동네 프로필. 저장 해제는 카드의 북마크, 동네는 [편집] 에서 합니다.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: user == null
            ? const Column(
                children: [
                  _Header(),
                  Expanded(
                    child: LoginPrompt(
                      icon: LoginPromptIcons.favorites,
                      title: '로그인하고 저장해 보세요',
                      body:
                          '마음에 드는 지역과 동네를 저장하려면 로그인이 필요해요.\n'
                          '같은 계정이면 웹·앱에서 함께 볼 수 있어요.',
                    ),
                  ),
                ],
              )
            : _LoggedIn(user: user),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.user, this.subtitle});

  final AuthUser? user;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s4,
        AppSpacing.s2,
        AppSpacing.s4,
        AppSpacing.s3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s1,
        children: [
          Row(
            children: [
              Expanded(child: Text('즐겨찾기', style: AppTextStyles.headingXl)),
              if (user != null)
                GestureDetector(
                  onTap: () => context.go(AppRoutes.my),
                  child: Semantics(
                    button: true,
                    label: 'MY 로 이동',
                    excludeSemantics: true,
                    child: Avatar(initial: user!.initial),
                  ),
                ),
            ],
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTextStyles.bodySm.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

class _LoggedIn extends ConsumerStatefulWidget {
  const _LoggedIn({required this.user});

  final AuthUser user;

  @override
  ConsumerState<_LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends ConsumerState<_LoggedIn> {
  bool _editing = false;

  Future<void> _remove(FavoriteKind kind, String id) async {
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(favoriteIdsProvider.notifier);
    final result = await notifier.setSaved(kind, id, saved: false);
    if (result != SaveResult.ok) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text(FavoriteCopy.failed)));
      return;
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text(FavoriteCopy.removed),
          action: SnackBarAction(
            label: FavoriteCopy.undo,
            onPressed: () => notifier.setSaved(kind, id, saved: true),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(favoritesListProvider);
    final ids = ref.watch(favoriteIdsProvider);
    final weights = ref.watch(homeFilterProvider.select((f) => f.weights));

    return list.when(
      loading: () => Column(
        children: [
          _Header(user: widget.user),
          const Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      ),
      error: (error, stack) => Column(
        children: [
          _Header(user: widget.user),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.s3,
                children: [
                  Text(
                    '즐겨찾기를 불러오지 못했습니다',
                    style: AppTextStyles.bodyBase.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => ref.invalidate(favoritesListProvider),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      data: (data) {
        // 해제하면 목록을 다시 읽기 전에도 바로 사라지도록 id 로 한 번 더 거릅니다.
        final regions = [
          for (final r in data.regions)
            if (ids.contains(FavoriteKind.regions, r.id)) r,
        ];
        final dongs = [
          for (final d in data.dongs)
            if (ids.contains(FavoriteKind.dongs, d.id)) d,
        ];
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                user: widget.user,
                subtitle:
                    '${widget.user.nickname}님 · 웹·앱 동기화됨'
                    ' · 지역 ${regions.length} · 동네 ${dongs.length}',
              ),
            ),
            if (regions.isEmpty && dongs.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _Empty(onExplore: () => context.go(AppRoutes.home)),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                sliver: SliverList.list(
                  children: [
                    if (regions.isNotEmpty) ...[
                      _SectionTitle(
                        '지역',
                        trailing: _EditButton(
                          editing: _editing,
                          onTap: () => setState(() => _editing = !_editing),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      for (final (i, r) in regions.indexed) ...[
                        if (i > 0) const SizedBox(height: AppSpacing.s6),
                        _RegionCard(
                          region: r,
                          month: data.month,
                          weights: weights,
                          onRemove: () => _remove(FavoriteKind.regions, r.id),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.s4),
                    ],
                    if (dongs.isNotEmpty) ...[
                      _SectionTitle(
                        '동네',
                        // 지역이 없으면 동네 쪽에서 편집합니다.
                        trailing: regions.isEmpty
                            ? _EditButton(
                                editing: _editing,
                                onTap: () =>
                                    setState(() => _editing = !_editing),
                              )
                            : Text(
                                '${Months.label(data.month)} 기준',
                                style: AppTextStyles.captionXs.copyWith(
                                  color: Theme.of(context)
                                      .extension<AppSemanticColors>()!
                                      .textTertiary,
                                ),
                              ),
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      _DongList(
                        dongs: dongs,
                        editing: _editing,
                        onRemove: (d) => _remove(FavoriteKind.dongs, d.id),
                      ),
                      const SizedBox(height: AppSpacing.s4),
                    ],
                    const _SyncNote(),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headingLg),
        ?trailing,
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.editing, required this.onTap});

  final bool editing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s1),
          child: Text(
            editing ? '완료' : '편집',
            style: AppTextStyles.bodySmMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// 지역 카드. 메모 → 방문 예정 월 → 시기 여유 순으로 두 번째 줄을 정합니다(웹 `favoriteMeta2`).
class _RegionCard extends StatelessWidget {
  const _RegionCard({
    required this.region,
    required this.month,
    required this.weights,
    required this.onRemove,
  });

  final FavoriteRegion region;
  final String month;
  final Weights weights;
  final VoidCallback onRemove;

  static String meta2(FavoriteRegion r, String month) {
    final note = r.note;
    if (note != null && note.isNotEmpty) return note;
    final visit = r.visitMonth;
    if (visit != null) return '${Months.label(visit)} 방문 예정';
    return '${Months.label(month)} 시기 여유 ${metricGrade(r.scores.crowd).label}'
        ' · 혼잡 ${r.scores.crowd.round()}';
  }

  @override
  Widget build(BuildContext context) {
    return ListingCardMobile(
      key: ValueKey(region.id),
      title: '${region.name}, ${region.province}',
      score: composite((k) => region.scores[k], weights),
      meta: region.tags.join(' · '),
      meta2: meta2(region, month),
      photos: [region.photoUrl],
      saved: true,
      onToggleSave: onRemove,
      onTap: () => context.push(AppRoutes.region(region.id)),
      grades: [
        for (final key in const [
          MetricKey.quiet,
          MetricKey.peer,
          MetricKey.overnight,
        ])
          (key.shortLabel, metricGrade(region.scores[key])),
      ],
    );
  }
}

class _DongList extends StatelessWidget {
  const _DongList({
    required this.dongs,
    required this.editing,
    required this.onRemove,
  });

  final List<FavoriteDong> dongs;
  final bool editing;
  final ValueChanged<FavoriteDong> onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (final (i, d) in dongs.indexed)
            DongRow(
              key: ValueKey(d.id),
              name: d.name,
              kindLabel: d.kind.label,
              kindTone: d.kind == DongKind.living
                  ? TagTone.brand
                  : TagTone.neutral,
              caption:
                  '${d.sigungu.name} · 저녁 활기 ${metricGrade(d.scores.vibe).label}'
                  ' · 또래 ${metricGrade(d.scores.peer).label}',
              metricLabel: '동네 조용함',
              grade: metricGrade(d.scores.quiet),
              showDivider: i < dongs.length - 1,
              trailing: editing
                  ? IconButtonCircle.save(
                      saved: true,
                      size: IconButtonCircleSize.sm,
                      onPressed: () => onRemove(d),
                    )
                  : null,
              onTap: () => context.push(AppRoutes.dong(d.id)),
            ),
        ],
      ),
    );
  }
}

class _SyncNote extends StatelessWidget {
  const _SyncNote();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: AppRadius.xlAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s2,
        children: [
          Icon(LucideIcons.user, size: 16, color: scheme.onSurfaceVariant),
          Expanded(
            child: Text(
              '웹에서도 같은 즐겨찾기를 볼 수 있어요. '
              '같은 계정으로 로그인하면 웹·앱이 동기화됩니다.',
              style: AppTextStyles.captionXs.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s3,
          children: [
            Text('아직 즐겨찾기가 없어요', style: AppTextStyles.headingLg),
            Text(
              '지역 상세·동네 프로필의 북마크를 눌러 담아보세요',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySm.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            AppButton(
              '탐색하기',
              variant: AppButtonVariant.secondary,
              onPressed: onExplore,
            ),
          ],
        ),
      ),
    );
  }
}
