import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/network/api_exception.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/community.dart';
import '../../data/models/dong_detail.dart';
import '../../shared/widgets/metric_card.dart';
import '../../shared/widgets/mobile_sticky_bar.dart';
import '../../shared/widgets/photo_header.dart';
import '../../shared/widgets/tag.dart';
import '../auth/login_gate.dart';
import '../community/widgets/poll_section.dart';
import '../community/widgets/tips_section.dart';
import '../home/home_providers.dart';
import 'dong_copy.dart';
import 'dong_providers.dart';
import 'widgets/dong_fallback.dart';
import 'widgets/hourly_curve_card.dart';
import 'widgets/location_card.dart';
import 'widgets/month_day_row.dart';
import 'widgets/workation_types_card.dart';

/// M-04 동네 프로필 v3. 사진 헤더 · 워케이션 유형 · 월 + 주중/주말 · 24시간 곡선 ·
/// 지표 4종 · 팁 · 체감 투표 · 위치, 아래에 점수 요약 고정 바.
///
/// 월은 홈에서 고른 값으로 시작하고 이 화면 안에서만 바꿉니다.
/// 유형 카드는 `GET /api/explore/dongs/{id}` 가 실패하면 카드만 숨깁니다.
class DongScreen extends ConsumerStatefulWidget {
  const DongScreen({super.key, required this.dongId});

  /// 행정동 코드 10자리
  final String dongId;

  @override
  ConsumerState<DongScreen> createState() => _DongScreenState();
}

class _DongScreenState extends ConsumerState<DongScreen> {
  late String _month = ref.read(homeFilterProvider).month;
  var _weekend = false;

  void _back() => context.canPop() ? context.pop() : context.go(AppRoutes.home);

  void _comingSoon(String what) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$what 기능은 준비 중이에요')));
  }

  /// 동네 즐겨찾기. 즐겨찾기 상태가 생기면 이 함수만 바꿔 연결합니다.
  Future<void> _onSave() async {
    if (!await ensureLoggedIn(context, ref)) return;
    if (!mounted) return;
    _comingSoon('즐겨찾기');
  }

  @override
  Widget build(BuildContext context) {
    final arg = (id: widget.dongId, month: _month);
    final detail = ref.watch(dongDetailProvider(arg));

    final error = detail.isLoading ? null : detail.error;
    if (error != null) {
      final notFound = error is NotFoundException;
      return DongFallback(
        onBack: _back,
        message: notFound ? '없는 동네예요' : '동네 정보를 불러오지 못했습니다',
        onRetry: notFound
            ? null
            : () => ref.invalidate(dongDetailProvider(arg)),
      );
    }
    final d = detail.value;
    if (d == null) return DongFallback(onBack: _back);

    final types = ref.watch(dongTypesProvider(widget.dongId)).value?.types;
    final scores = d.scores;
    final quietGrade = scores == null ? null : metricGrade(scores.quiet);
    final vibeGrade = scores == null ? null : metricGrade(scores.vibe);
    final dominant = dominantActivity(d.activityMix);
    final target = CommunityTarget.dong(d.id);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PhotoHeader(
                photos: [for (final p in d.photos) p.url],
                onBack: _back,
                onShare: () => _comingSoon('공유'),
                onToggleSave: _onSave,
              ),
              _TitleBlock(
                detail: d,
                dominant: dominant,
                summary: buildDongSummary(
                  dominant: dominant,
                  weekdayPeakHour: d.peaks.weekday.peakHour,
                  vibeGrade: vibeGrade ?? Grade.c,
                  kind: d.kind,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s4),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.s4,
                  children: [
                    if (types != null && types.isNotEmpty)
                      WorkationTypesCard(types: types),
                    MonthDayRow(
                      month: _month,
                      weekend: _weekend,
                      onMonthChanged: (m) => setState(() => _month = m),
                      onWeekendChanged: (w) => setState(() => _weekend = w),
                    ),
                    HourlyCurveCard(
                      hourly: d.hourly,
                      peaks: d.peaks,
                      weekend: _weekend,
                    ),
                    MetricGrid(
                      cards: [
                        MetricCard(
                          label: MetricKey.quiet.label,
                          score: scores?.quiet,
                          grade: quietGrade,
                          subtitle: scores == null
                              ? '집계 제외 동네(특수시설 패턴)'
                              : '낮 유입 지수 ${d.stats.dayInflow.toStringAsFixed(2)}'
                                    ' · 백분위 ${scores.quiet.round()}',
                        ),
                        MetricCard(
                          label: MetricKey.vibe.label,
                          score: scores?.vibe,
                          grade: vibeGrade,
                          subtitle:
                              '저녁 유동 ÷ 체류 '
                              '${d.stats.eveningVibe.toStringAsFixed(2)}',
                        ),
                        MetricCard(
                          label: MetricKey.peer.label,
                          score: scores?.peer,
                          grade: scores == null
                              ? null
                              : metricGrade(scores.peer),
                          subtitle: '20~40대 방문 ${d.stats.peerShare}%',
                        ),
                        MetricCard(
                          label: '생활권 지수',
                          score: d.stats.localLife.toDouble(),
                          grade: localLifeGrade(d.stats.localLife),
                          subtitle:
                              '거주+근무 ${d.stats.localLife}% · '
                              '${localLifeLabel(d.stats.localLife)}',
                        ),
                      ],
                    ),
                    TipsSection(
                      target: target,
                      title: '워케이션 노트 · ${d.name}',
                      visitMonth: d.month == Months.annual ? null : d.month,
                      hint: '이 동네에서 알게 된 팁을 남겨보세요',
                    ),
                    PollSection(
                      target: target,
                      month: _month,
                      question: dongPollQuestion(d.name, vibeGrade ?? Grade.c),
                      participationLabel: '저녁 활기 지수 검증에 반영돼요',
                    ),
                    LocationCard(
                      dongName: d.name,
                      accessNote: d.accessNote,
                      sigunguName: d.sigungu.name,
                      onOtherDongs: () => context.push(
                        AppRoutes.region(d.sigungu.id, tab: 'dongs'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MobileStickyBar(
        score: scores?.quiet ?? 0,
        scoreSuffix: '점 · ${Months.label(_month)}',
        sub: scores == null
            ? '집계 제외 동네'
            : '동네 조용함 ${quietGrade!.label} · '
                  '행정동 ${d.dongCount}곳 백분위 ${scores.quiet.round()}',
        actionLabel: '동네 즐겨찾기',
        onAction: _onSave,
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.detail,
    required this.dominant,
    required this.summary,
  });

  final DongDetail detail;
  final ActivityKey dominant;
  final String summary;

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
            '${detail.name}, ${detail.sigungu.name}',
            style: AppTextStyles.headingXl,
          ),
          Text(
            '${detail.province} ${detail.sigungu.name} · $summary',
            style: AppTextStyles.bodySm.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              Tag(detail.kind.label, tone: TagTone.brand),
              for (final t in detail.tags) Tag(t),
              Tag(dominant.label),
            ],
          ),
        ],
      ),
    );
  }
}
