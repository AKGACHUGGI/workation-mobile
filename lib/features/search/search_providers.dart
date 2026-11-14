import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/search_intent.dart';
import '../home/home_providers.dart';

/// 홈에 적용된 자연어 검색. 문장과 그 문장에서 읽어낸 조건.
class AppliedSearch {
  const AppliedSearch({required this.query, required this.intent});

  final String query;
  final SearchIntent intent;

  /// 검색 필 둘째 줄. 예: `AI 추천 · 10월 · 조용한 곳 · 해안`
  String get summary =>
      ['AI 추천', for (final t in intent.tags) t.label].join(' · ');
}

/// M-01b 에서 [apply] 하면 홈(M-01)의 검색 필 · 조건 줄 · 목록이 같이 바뀝니다.
class AppliedSearchNotifier extends Notifier<AppliedSearch?> {
  @override
  AppliedSearch? build() => null;

  void apply(String query, SearchIntent intent) {
    state = AppliedSearch(query: query, intent: intent);
    ref.read(homeFilterProvider.notifier).applyIntent(intent);
  }

  /// 조건을 지우고 홈을 처음 상태로 되돌립니다.
  void clear() {
    state = null;
    ref.read(homeFilterProvider.notifier).reset();
  }
}

final appliedSearchProvider =
    NotifierProvider<AppliedSearchNotifier, AppliedSearch?>(
      AppliedSearchNotifier.new,
    );
