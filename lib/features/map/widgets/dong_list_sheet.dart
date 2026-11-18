import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/explore.dart';
import '../../../shared/widgets/app_chip.dart';
import '../../../shared/widgets/dong_row.dart';
import '../../../shared/widgets/fact_pill.dart';
import '../../../shared/widgets/skeleton.dart';
import '../map_logic.dart';
import '../map_providers.dart';
import 'map_sheet.dart';

/// ① 시트: 칩(전체 · 유형 4종 · 바닷가 · 생활권 · 관광지) + 동 목록.
/// 제목 줄은 두지 않습니다. 고른 칩이 정렬 기준을 보여 줍니다.
class DongListSheet extends ConsumerWidget {
  const DongListSheet({
    super.key,
    required this.sggId,
    required this.sggName,
    required this.onPickDong,
  });

  final String sggId;
  final String sggName;
  final ValueChanged<String> onPickDong;

  /// 목록 영역 높이. 두 줄 반이 보여 아래에 더 있음을 알립니다. 시트는 펼쳐지지 않습니다.
  static const listHeight = 164.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(pinsProvider(sggId));
    final filter = ref.watch(pinFilterProvider(sggId));
    final notifier = ref.read(pinFilterProvider(sggId).notifier);

    return MapSheet(
      child: pins.when(
        loading: () => const _ListSkeleton(),
        error: (error, _) => error is NotFoundException
            ? SheetMessage('$sggName 동네 정보는 아직 준비 중이에요')
            : SheetMessage(
                '동네 목록을 불러오지 못했어요',
                onRetry: () => ref.invalidate(pinsProvider(sggId)),
              ),
        data: (response) {
          final rows = filterAndSortPins(response.dongs, filter);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              _Chips(filter: filter, notifier: notifier),
              SizedBox(
                height: listHeight,
                child: rows.isEmpty
                    ? const Center(child: SheetMessage('조건에 맞는 동네가 없어요'))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: rows.length,
                        itemBuilder: (context, i) {
                          final d = rows[i];
                          final s = rowScore(d, filter);
                          return DongScoreRow(
                            name: d.name,
                            facts: [
                              if (d.topType != null)
                                FactPill(d.topType!, kind: FactKind.type),
                              if (d.coastal)
                                const FactPill('바닷가', kind: FactKind.coast),
                              if (d.life != null)
                                FactPill(d.life!, kind: FactKind.life),
                            ],
                            score: s?.score,
                            scoreLabel: s?.type,
                            showDivider: i < rows.length - 1,
                            onTap: () => onPickDong(d.id),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Chips extends StatelessWidget {
  const _Chips({required this.filter, required this.notifier});

  final PinFilter filter;
  final PinFilterNotifier notifier;

  @override
  Widget build(BuildContext context) {
    // 시트 안쪽 여백(16)을 넘어 화면 끝까지 흘러가게 합니다.
    return SizedBox(
      height: 40,
      child: OverflowBox(
        maxWidth: MediaQuery.sizeOf(context).width,
        child: AppChipRow(
          children: [
            AppChip(label: '전체', selected: filter.isAll, onTap: notifier.clear),
            for (final t in WorkationTypes.all)
              AppChip(
                label: t,
                selected: filter.type == t,
                onTap: () => notifier.toggleType(t),
              ),
            for (final a in PinAttr.values)
              AppChip(
                label: a.label,
                selected: filter.attrs.contains(a),
                onTap: () => notifier.toggleAttr(a),
              ),
          ],
        ),
      ),
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: [
        Skeleton(height: 40, radius: AppRadius.full),
        SizedBox(
          height: DongListSheet.listHeight,
          child: Column(
            spacing: AppSpacing.s3,
            children: [
              Skeleton(height: 46, radius: AppRadius.lg),
              Skeleton(height: 46, radius: AppRadius.lg),
              Skeleton(height: 46, radius: AppRadius.lg),
            ],
          ),
        ),
      ],
    );
  }
}
