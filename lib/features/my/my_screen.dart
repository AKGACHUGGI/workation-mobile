import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/me.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_toggle.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/segmented_tabs.dart';
import '../../shared/widgets/tag.dart';
import '../auth/auth_providers.dart';
import '../auth/widgets/login_prompt.dart';
import '../favorites/favorites_providers.dart';
import 'my_providers.dart';
import 'widgets/my_photo_tile.dart';
import 'widgets/my_tip_tile.dart';

enum _MyTab {
  favorites('즐겨찾기'),
  tips('팁'),
  photos('사진');

  const _MyTab(this.label);

  final String label;
}

/// M-07 MY. 로그인 필수. 프로필 · 활동 통계 · 내 즐겨찾기/팁/사진 탭 · 알림 설정 ·
/// 연결된 계정 · 로그아웃. 비로그인이면 안내와 로그인 버튼입니다.
class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

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
                      icon: LoginPromptIcons.my,
                      title: '로그인이 필요해요',
                      body:
                          '로그인하면 프로필 · 내 팁 · 내 사진과\n'
                          '알림 설정을 한곳에서 볼 수 있어요.',
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
  const _Header({this.onSettings});

  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MY',
            style: AppTextStyles.heading2xl.copyWith(letterSpacing: -0.48),
          ),
          if (onSettings != null)
            IconButton(
              tooltip: '설정',
              onPressed: onSettings,
              icon: const Icon(LucideIcons.settings, size: 22),
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
  _MyTab _tab = _MyTab.photos;
  final _settingsKey = GlobalKey();

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _scrollToSettings() {
    final ctx = _settingsKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Future<void> _toggleSetting(NotifySetting setting, bool value) async {
    final ok = await ref.read(meSettingsProvider.notifier).set(setting, value);
    if (!ok && mounted) _snack('설정을 저장하지 못했어요');
  }

  Future<void> _confirmLogout() async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃할까요?'),
        content: const Text('다시 로그인하면 즐겨찾기와 활동이 그대로 보여요.'),
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
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    ref.read(sessionProvider.notifier).signOut();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('로그아웃했습니다')));
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final summary = ref.watch(meSummaryProvider);
    final ids = ref.watch(favoriteIdsProvider);

    return Column(
      children: [
        _Header(onSettings: _scrollToSettings),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.s4),
            children: [
              _ProfileCard(
                user: user,
                summary: summary.value,
                onEdit: () => _snack('프로필 편집은 준비 중이에요'),
              ),
              const SizedBox(height: AppSpacing.s4),
              Row(
                spacing: AppSpacing.s2,
                children: [
                  _Stat(count: ids.total, label: '즐겨찾기'),
                  _Stat(count: summary.value?.tipCount, label: '팁'),
                  _Stat(count: summary.value?.photoCount, label: '사진'),
                ],
              ),
              const SizedBox(height: AppSpacing.s4),
              SegmentedTabs(
                labels: [for (final t in _MyTab.values) t.label],
                index: _tab.index,
                onChanged: (i) => setState(() => _tab = _MyTab.values[i]),
              ),
              const SizedBox(height: AppSpacing.s4),
              switch (_tab) {
                _MyTab.favorites => _FavoritesTab(
                  onOpen: () => context.go(AppRoutes.favorites),
                ),
                _MyTab.tips => _TipsTab(user: user),
                _MyTab.photos => _PhotosTab(
                  user: user,
                  onUpload: () => _snack('사진 올리기는 준비 중이에요'),
                ),
              },
              const SizedBox(height: AppSpacing.s4),
              _SettingsCard(
                key: _settingsKey,
                providerLabel: user.provider.label,
                onToggle: _toggleSetting,
                onAccount: () => _snack(
                  '${user.provider.label} 계정(${user.emailMasked})으로 로그인했어요',
                ),
                onLogout: _confirmLogout,
              ),
              const SizedBox(height: AppSpacing.s6),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.user,
    required this.summary,
    required this.onEdit,
  });

  final AuthUser user;
  final MeSummary? summary;
  final VoidCallback onEdit;

  /// `강릉 2회 · 고성 1회 체류 · 2025.03 가입` (웹 `buildActivitySummary` 에서 팁 · 사진 수는 뺌)
  static String activity(MeSummary s) {
    final stays = s.stays.isEmpty
        ? '아직 체류 기록 없음'
        : '${s.stays.map((x) => '${x.regionName} ${x.count}회').join(' · ')} 체류';
    final joined = s.createdAt.length >= 7
        ? '${s.createdAt.substring(0, 4)}.${s.createdAt.substring(5, 7)}'
        : '';
    return joined.isEmpty ? stays : '$stays · $joined 가입';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        spacing: 14,
        children: [
          Avatar(initial: user.initial, size: AvatarSize.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s1,
              children: [
                Text(user.nickname, style: AppTextStyles.headingLg),
                if (summary != null)
                  Text(
                    activity(summary!),
                    style: AppTextStyles.captionXs.copyWith(color: tertiary),
                  ),
                Tag('${user.provider.label} 연결됨', tone: TagTone.brand),
              ],
            ),
          ),
          AppButton(
            '편집',
            variant: AppButtonVariant.secondary,
            height: 40,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.count, required this.label});

  /// 아직 읽는 중이면 null
  final int? count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s3),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppRadius.xlAll,
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          spacing: 2,
          children: [
            Text(
              count?.toString() ?? '–',
              style: AppTextStyles.number2xl.copyWith(
                color: scheme.primary,
                letterSpacing: -0.48,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.captionXs.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabHeader extends StatelessWidget {
  const _TabHeader({required this.title, this.aside});

  final String title;
  final String? aside;

  @override
  Widget build(BuildContext context) {
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodySmBold),
          if (aside != null)
            Text(
              aside!,
              style: AppTextStyles.captionXs.copyWith(color: tertiary),
            ),
        ],
      ),
    );
  }
}

class _TabMessage extends StatelessWidget {
  const _TabMessage(this.text, {this.actionLabel, this.onAction});

  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s6),
      child: Column(
        spacing: AppSpacing.s2,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
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

class _PhotosTab extends ConsumerWidget {
  const _PhotosTab({required this.user, required this.onUpload});

  final AuthUser user;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(myPhotosProvider);

    return photos.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s6),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => _TabMessage(
        '사진을 불러오지 못했어요',
        actionLabel: '다시 시도',
        onAction: () => ref.invalidate(myPhotosProvider),
      ),
      data: (data) {
        final approved = data.items
            .where((p) => p.status == PhotoStatus.approved)
            .length;
        final pending = data.items.length - approved;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TabHeader(
              title: '내가 올린 사진 ${data.items.length}장',
              aside: '검수 완료 $approved · 대기 $pending',
            ),
            // 칸 폭 171 · 높이 128, 가로 간격 16 · 세로 간격 12 (Figma PhotoGrid)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.s3,
              crossAxisSpacing: AppSpacing.s4,
              childAspectRatio: 171 / 128,
              children: [
                for (final p in data.items)
                  MyPhotoTile(
                    key: ValueKey(p.id),
                    photo: p,
                    initial: user.initial,
                  ),
                MyPhotoUploadTile(onTap: onUpload),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TipsTab extends ConsumerWidget {
  const _TipsTab({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tips = ref.watch(myTipsProvider);

    return tips.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s6),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => _TabMessage(
        '팁을 불러오지 못했어요',
        actionLabel: '다시 시도',
        onAction: () => ref.invalidate(myTipsProvider),
      ),
      data: (data) {
        if (data.items.isEmpty) return const _TabMessage('아직 남긴 팁이 없어요');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TabHeader(
              title: '내가 쓴 팁 ${data.items.length}개',
              aside: '도움돼요 합계 ${data.helpfulSum}',
            ),
            for (final (i, tip) in data.items.indexed) ...[
              if (i > 0) const SizedBox(height: AppSpacing.s3),
              MyTipTile(
                key: ValueKey(tip.id),
                tip: tip,
                onTap: () => context.push(
                  tip.target.kind == TipTargetKind.region
                      ? AppRoutes.region(tip.target.id)
                      : AppRoutes.dong(tip.target.id),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _FavoritesTab extends ConsumerWidget {
  const _FavoritesTab({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(favoritesListProvider);
    final ids = ref.watch(favoriteIdsProvider);
    final data = list.value;
    if (data == null) {
      return list.hasError
          ? _TabMessage(
              '즐겨찾기를 불러오지 못했어요',
              actionLabel: '다시 시도',
              onAction: () => ref.invalidate(favoritesListProvider),
            )
          : const Padding(
              padding: EdgeInsets.all(AppSpacing.s6),
              child: Center(child: CircularProgressIndicator()),
            );
    }
    final regions = [
      for (final r in data.regions)
        if (ids.contains(FavoriteKind.regions, r.id)) r.name,
    ];
    final dongs = [
      for (final d in data.dongs)
        if (ids.contains(FavoriteKind.dongs, d.id)) d.name,
    ];
    if (regions.isEmpty && dongs.isEmpty) {
      return _TabMessage(
        '아직 즐겨찾기가 없어요',
        actionLabel: '탐색하기',
        onAction: () => context.go(AppRoutes.home),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TabHeader(title: '저장한 지역 ${regions.length} · 동네 ${dongs.length}'),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final name in regions) Tag(name, tone: TagTone.brand),
            for (final name in dongs) Tag(name),
          ],
        ),
        const SizedBox(height: AppSpacing.s3),
        AppButton(
          '즐겨찾기에서 보기',
          variant: AppButtonVariant.secondary,
          height: 40,
          expand: true,
          onPressed: onOpen,
        ),
      ],
    );
  }
}

class _SettingsCard extends ConsumerWidget {
  const _SettingsCard({
    super.key,
    required this.providerLabel,
    required this.onToggle,
    required this.onAccount,
    required this.onLogout,
  });

  final String providerLabel;
  final void Function(NotifySetting setting, bool value) onToggle;
  final VoidCallback onAccount;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;
    final settings = ref.watch(meSettingsProvider);
    final line = BorderSide(color: scheme.outlineVariant);

    Widget row({
      required String label,
      String? trailingText,
      Color? labelColor,
      required VoidCallback onTap,
      bool divider = true,
    }) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            border: divider ? Border(bottom: line) : null,
          ),
          child: Row(
            spacing: AppSpacing.s2,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodySmMedium.copyWith(color: labelColor),
                ),
              ),
              if (trailingText != null)
                Text(
                  trailingText,
                  style: AppTextStyles.captionXs.copyWith(color: tertiary),
                ),
              Icon(LucideIcons.chevronRight, size: 18, color: scheme.onSurface),
            ],
          ),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: 14,
            ),
            decoration: BoxDecoration(border: Border(bottom: line)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Text('알림 설정', style: AppTextStyles.bodySmMedium),
                settings.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.s4),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, s) => Text(
                    '설정을 불러오지 못했어요',
                    style: AppTextStyles.captionXs.copyWith(color: tertiary),
                  ),
                  data: (s) => Column(
                    spacing: 14,
                    children: [
                      for (final item in NotifySetting.values)
                        Row(
                          spacing: AppSpacing.s3,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    item.label,
                                    style: AppTextStyles.bodySmMedium,
                                  ),
                                  Text(
                                    item.hint,
                                    style: AppTextStyles.captionXs.copyWith(
                                      color: tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppToggle(
                              value: item.valueOf(s),
                              semanticLabel: item.label,
                              onChanged: (v) => onToggle(item, v),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          row(label: '연결된 계정', trailingText: providerLabel, onTap: onAccount),
          row(
            label: '로그아웃',
            labelColor: scheme.error,
            onTap: onLogout,
            divider: false,
          ),
        ],
      ),
    );
  }
}
