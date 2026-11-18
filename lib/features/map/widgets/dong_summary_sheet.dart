import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/explore.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../../shared/widgets/type_bar.dart';
import '../map_providers.dart';
import 'map_sheet.dart';

/// ② 시트: 이름 · 바닷가 거리 · 소속 · 1위 유형 막대 · 브리핑 한 줄 · [이 동네 더보기].
/// 불러오는 중에는 스켈레톤, 요약이 없으면(404) 안내, 실패하면 오류 문구와 [다시 시도].
class DongSummarySheet extends ConsumerWidget {
  const DongSummarySheet({
    super.key,
    required this.dongId,
    required this.fallbackName,
    required this.sggName,
    required this.onClose,
    required this.onOpen,
  });

  final String dongId;

  /// 요약을 받기 전(또는 못 받았을 때) 쓸 이름. 핀 응답의 이름입니다.
  final String fallbackName;
  final String sggName;
  final VoidCallback onClose;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dongSummaryProvider(dongId));

    return MapSheet(
      child: summary.when(
        loading: () => const _SummarySkeleton(),
        error: (error, _) {
          final missing = error is NotFoundException;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              _Header(name: fallbackName, subtitle: sggName, onClose: onClose),
              missing
                  ? const SheetMessage('이 동네의 요약은 아직 준비 중이에요')
                  : SheetMessage(
                      '동네 정보를 불러오지 못했어요',
                      onRetry: () =>
                          ref.invalidate(dongSummaryProvider(dongId)),
                    ),
              if (missing)
                FilledButton(onPressed: onOpen, child: const Text('이 동네 더보기')),
            ],
          );
        },
        data: (dong) => _Loaded(dong: dong, onClose: onClose, onOpen: onOpen),
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({
    required this.dong,
    required this.onClose,
    required this.onOpen,
  });

  final ExploreDong dong;
  final VoidCallback onClose;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final top = dong.types.isEmpty ? null : dong.types.first;
    final brief = dong.briefing.isEmpty ? null : dong.briefing.first;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: [
        _Header(
          name: dong.name,
          subtitle: '${dong.sido} · ${dong.sigungu.name}',
          coastKm: dong.coastKm,
          onClose: onClose,
        ),
        if (top != null)
          TypeBar(name: top.name, score: top.score, highlight: true),
        if (brief != null) Text(brief, style: AppTextStyles.bodySm),
        FilledButton(onPressed: onOpen, child: const Text('이 동네 더보기')),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.name,
    required this.subtitle,
    required this.onClose,
    this.coastKm,
  });

  final String name;
  final String subtitle;
  final double? coastKm;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coast = theme.extension<AppSemanticColors>()!.gradeS;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s1,
            children: [
              Wrap(
                spacing: AppSpacing.s2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(name, style: AppTextStyles.headingXl),
                  if (coastKm != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: coast.bg,
                        borderRadius: AppRadius.fullAll,
                      ),
                      child: Text(
                        '바닷가 ${coastKm!.toStringAsFixed(1)}km',
                        style: AppTextStyles.captionXsMedium.copyWith(
                          color: coast.fg,
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                subtitle,
                style: AppTextStyles.bodySm.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          tooltip: '닫기',
          icon: const Icon(LucideIcons.x, size: 24),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

/// Figma ② 로딩(451:2379)과 같은 자리: 제목 · 소속 · 막대 · 브리핑 · 버튼.
class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s3,
      children: [
        Skeleton(width: 140, height: 28),
        Skeleton(width: 180, height: 16),
        Skeleton(height: 16),
        Skeleton(height: 36, radius: AppRadius.lg),
        Skeleton(height: 48, radius: AppRadius.lg),
      ],
    );
  }
}
