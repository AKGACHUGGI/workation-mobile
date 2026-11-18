import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/metric/metric.dart';
import '../../core/metric/month.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../models/popular_region.dart';
import '../models/search_intent.dart';

/// 자연어 검색(M-01b).
abstract class SearchRepository {
  /// `POST /api/search/parse` — 문장에서 조건을 읽습니다 (웹 `search/api.ts` 와 같음).
  Future<SearchIntent> parse(String text);
}

class ApiSearchRepository implements SearchRepository {
  const ApiSearchRepository(this._client);

  final ApiClient _client;

  @override
  Future<SearchIntent> parse(String text) async {
    final json = await _client.post('/api/search/parse', body: {'text': text});
    return SearchIntent.fromJson(json as Map<String, dynamic>);
  }
}

/// 실제 응답(LLM) 대신 낱말을 찾아 조건을 만드는 mock.
/// 시연에서 예시가 아닌 문장을 넣어도 조건이 나오도록 JSON 파일 대신 규칙으로 둡니다.
class MockSearchRepository implements SearchRepository {
  const MockSearchRepository({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;

  @override
  Future<SearchIntent> parse(String text) async {
    if (delay > Duration.zero) await Future<void>.delayed(delay);
    return mockParseIntent(text);
  }
}

final _monthPattern = RegExp(r'(\d{1,2})\s*월');

/// mock 파서. 월(숫자) · 분위기 · 지형 · 기간 · 또래 낱말만 봅니다.
SearchIntent mockParseIntent(String text) {
  bool has(List<String> words) => words.any(text.contains);
  final tags = <IntentTag>[];

  String? month;
  final m = int.tryParse(_monthPattern.firstMatch(text)?.group(1) ?? '');
  if (m != null && m >= 1 && m <= 12) {
    month = Months.of(m);
    tags.add(IntentTag(axis: IntentAxis.month, label: '$m월'));
  }

  PresetKey? preset;
  if (has(const ['조용', '한적', '한산'])) {
    preset = PresetKey.quiet;
  } else if (has(const ['활기', '밤에도', '저녁', '북적'])) {
    preset = PresetKey.lively;
  }
  if (preset != null) {
    tags.add(IntentTag(axis: IntentAxis.preset, label: preset.label));
  }

  final terrain = <Terrain>[
    if (has(const ['바다', '바닷가', '해안', '해변'])) Terrain.coast,
    if (has(const ['산간', '산 ', '산에', '단풍', '숲'])) Terrain.mountain,
    if (has(const ['도시', '시내'])) Terrain.city,
  ];
  for (final t in terrain) {
    tags.add(IntentTag(axis: IntentAxis.terrain, label: t.label));
  }

  StayLength? stay;
  String? stayLabel;
  if (has(const ['한 달', '한달', '1개월'])) {
    (stay, stayLabel) = (StayLength.month, '한 달 살기');
  } else if (has(const ['2주', '이주', '보름'])) {
    (stay, stayLabel) = (StayLength.twoWeeks, '2주');
  } else if (has(const ['일주일', '1주'])) {
    (stay, stayLabel) = (StayLength.week, '일주일');
  }
  if (stayLabel != null) {
    tags.add(IntentTag(axis: IntentAxis.stay, label: stayLabel));
  }

  final peer = has(const ['또래', '20대', '30대', '청년']);
  if (peer) {
    tags.add(const IntentTag(axis: IntentAxis.peer, label: '또래 20~40대'));
  }

  return SearchIntent(
    month: month,
    preset: preset,
    terrain: terrain.isEmpty ? null : terrain,
    stay: stay,
    peer: peer ? true : null,
    tags: tags,
  );
}

final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => ApiConfig.useMock
      ? const MockSearchRepository()
      : ApiSearchRepository(ref.watch(apiClientProvider)),
);
