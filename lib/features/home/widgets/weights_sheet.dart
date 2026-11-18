import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/metric/metric.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../home_providers.dart';

/// 종합 점수 가중치 시트(M-01 헤더의 슬라이더 버튼). 지표 5개를 0~[max] 로 맞춥니다.
/// [적용] 하면 홈 프리셋이 `직접 설정` 이 되어 카드 점수 · 순서가 바뀝니다.
Future<void> showWeightsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const WeightsSheet(),
  );
}

class WeightsSheet extends ConsumerStatefulWidget {
  const WeightsSheet({super.key});

  /// 슬라이더 최댓값. 기본 프리셋(0~3)보다 넉넉하게 둡니다.
  static const max = 5;

  @override
  ConsumerState<WeightsSheet> createState() => _WeightsSheetState();
}

class _WeightsSheetState extends ConsumerState<WeightsSheet> {
  late Map<MetricKey, double> _values;

  @override
  void initState() {
    super.initState();
    _set(ref.read(homeFilterProvider).weights);
  }

  void _set(Weights w) => _values = {
    for (final key in MetricKey.values)
      key: w[key].clamp(0, WeightsSheet.max).toDouble(),
  };

  Weights get _weights => Weights(
    quiet: _values[MetricKey.quiet]!,
    crowd: _values[MetricKey.crowd]!,
    peer: _values[MetricKey.peer]!,
    overnight: _values[MetricKey.overnight]!,
    vibe: _values[MetricKey.vibe]!,
  );

  bool get _allZero => _values.values.every((v) => v == 0);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s4,
          0,
          AppSpacing.s4,
          AppSpacing.s4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('종합 점수 가중치', style: AppTextStyles.headingLg),
            const SizedBox(height: AppSpacing.s1),
            Text(
              '중요한 지표일수록 높게 맞추세요. 홈 카드의 종합 점수에 반영돼요.',
              style: AppTextStyles.bodySm.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.s3),
            for (final key in MetricKey.values)
              _WeightRow(
                label: key.label,
                value: _values[key]!,
                onChanged: (v) => setState(() => _values[key] = v),
              ),
            if (_allZero)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.s1),
                child: Text(
                  '하나 이상은 0보다 크게 맞춰 주세요',
                  style: AppTextStyles.captionXs.copyWith(color: scheme.error),
                ),
              ),
            const SizedBox(height: AppSpacing.s4),
            Row(
              spacing: AppSpacing.s3,
              children: [
                Expanded(
                  child: AppButton(
                    '초기화',
                    variant: AppButtonVariant.secondary,
                    onPressed: () => setState(() => _set(Weights.quietPreset)),
                  ),
                ),
                Expanded(
                  child: AppButton(
                    '적용',
                    onPressed: _allZero
                        ? null
                        : () {
                            ref
                                .read(homeFilterProvider.notifier)
                                .setCustomWeights(_weights);
                            Navigator.of(context).pop();
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightRow extends StatelessWidget {
  const _WeightRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Text(label, style: AppTextStyles.bodySmMedium),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: scheme.onSurface,
              inactiveTrackColor: scheme.outlineVariant,
              thumbColor: scheme.onSurface,
              overlayColor: scheme.onSurface.withValues(alpha: 0.08),
            ),
            child: Slider(
              value: value,
              max: WeightsSheet.max.toDouble(),
              divisions: WeightsSheet.max,
              semanticFormatterCallback: (v) => '${v.round()}',
              label: label,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 20,
          child: Text(
            '${value.round()}',
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySmBold,
          ),
        ),
      ],
    );
  }
}
