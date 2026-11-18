import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/dong_detail.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/dong_repository.dart';

const jumunjinId = '5115025000';

/// 24시간 곡선: 11시 100, 3시 48 인 주중 · 13시 100, 3시 47 인 주말.
const _weekday = [
  58, 53, 50, 48, 49, 53, 62, 74, 86, 94, 98, 100, 97, 95, 93, 91, //
  88, 84, 78, 72, 68, 65, 62, 60,
];
const _weekend = [
  55, 51, 49, 47, 48, 50, 56, 64, 74, 84, 92, 97, 99, 100, 98, 96, //
  93, 89, 82, 75, 69, 64, 60, 57,
];

DongDetail fakeJumunjin({String month = '2025-12'}) => DongDetail(
  id: jumunjinId,
  name: '주문진읍',
  sigungu: const DongRef(id: '51150', name: '강릉시'),
  province: '강원특별자치도',
  kind: DongKind.living,
  tags: const ['해안'],
  accessNote: '강릉시 북부 · 바닷가 0.0km',
  month: month,
  stats: const DongStats(
    dayInflow: 0.79,
    localLife: 74,
    peerShare: 39,
    eveningVibe: 0.18,
    eveningSurplus: 0.85,
  ),
  scores: const DongScores(quiet: 31, vibe: 62, peer: 39),
  dongCount: 203,
  hourly: const Hourly(weekday: _weekday, weekend: _weekend),
  peaks: const Peaks(
    weekday: Peak(peakHour: 11, lowHour: 3, lowValue: 48),
    weekend: Peak(peakHour: 13, lowHour: 3, lowValue: 47),
  ),
  activityMix: const {
    'eveningDowntown': 25,
    'weekendTourist': 32,
    'weekdayWork': 24,
    'dawnResidential': 19,
  },
  seasonType: SeasonType.summerBeach,
);

/// 주문진읍만 있고 그 밖은 404 입니다. [fail] 이면 연결 실패를 던집니다.
class FakeDongRepository implements DongRepository {
  FakeDongRepository({this.fail = false});

  bool fail;

  /// 요청한 월(순서대로)
  final months = <String>[];

  @override
  Future<DongDetail> detail(String id, String month) async {
    if (fail) throw NetworkException('/api/dongs/$id');
    if (id != jumunjinId) throw NotFoundException('/api/dongs/$id');
    months.add(month);
    return fakeJumunjin(month: month);
  }
}
