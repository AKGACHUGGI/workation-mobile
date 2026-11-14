import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/metric/metric.dart';
import 'popular_region.dart';

part 'search_intent.freezed.dart';
part 'search_intent.g.dart';

/// 조건 태그가 가리키는 축.
enum IntentAxis { month, preset, terrain, stay, peer }

/// 머무는 기간.
enum StayLength {
  week,
  @JsonValue('two_weeks')
  twoWeeks,
  month,
}

/// "AI가 이해한 조건" 태그 한 개.
@freezed
abstract class IntentTag with _$IntentTag {
  const factory IntentTag({required IntentAxis axis, required String label}) =
      _IntentTag;

  factory IntentTag.fromJson(Map<String, dynamic> json) =>
      _$IntentTagFromJson(json);
}

/// `POST /api/search/parse` 응답 (웹 `search/types.ts` 와 같음).
/// 문장에서 읽어낸 조건입니다. [tags] 가 비어 있으면 조건을 찾지 못한 것입니다.
@freezed
abstract class SearchIntent with _$SearchIntent {
  const SearchIntent._();

  const factory SearchIntent({
    /// `2025-10`
    String? month,

    /// 계절처럼 여러 달일 때. 예: 봄 = `[3, 4, 5]`
    List<int>? monthRange,
    PresetKey? preset,
    List<Terrain>? terrain,
    StayLength? stay,
    bool? peer,
    @Default(<IntentTag>[]) List<IntentTag> tags,
  }) = _SearchIntent;

  factory SearchIntent.fromJson(Map<String, dynamic> json) =>
      _$SearchIntentFromJson(json);

  bool get isEmpty => tags.isEmpty;

  /// [tag] 를 뺀 조건. 그 축의 태그가 더 없으면 축의 값도 같이 지웁니다.
  SearchIntent without(IntentTag tag) {
    final rest = [
      for (final t in tags)
        if (t != tag) t,
    ];
    if (rest.any((t) => t.axis == tag.axis)) return copyWith(tags: rest);
    return switch (tag.axis) {
      IntentAxis.month => copyWith(tags: rest, month: null, monthRange: null),
      IntentAxis.preset => copyWith(tags: rest, preset: null),
      IntentAxis.terrain => copyWith(tags: rest, terrain: null),
      IntentAxis.stay => copyWith(tags: rest, stay: null),
      IntentAxis.peer => copyWith(tags: rest, peer: null),
    };
  }
}
