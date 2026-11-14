// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntentTag _$IntentTagFromJson(Map<String, dynamic> json) => _IntentTag(
  axis: $enumDecode(_$IntentAxisEnumMap, json['axis']),
  label: json['label'] as String,
);

Map<String, dynamic> _$IntentTagToJson(_IntentTag instance) =>
    <String, dynamic>{
      'axis': _$IntentAxisEnumMap[instance.axis]!,
      'label': instance.label,
    };

const _$IntentAxisEnumMap = {
  IntentAxis.month: 'month',
  IntentAxis.preset: 'preset',
  IntentAxis.terrain: 'terrain',
  IntentAxis.stay: 'stay',
  IntentAxis.peer: 'peer',
};

_SearchIntent _$SearchIntentFromJson(Map<String, dynamic> json) =>
    _SearchIntent(
      month: json['month'] as String?,
      monthRange: (json['monthRange'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      preset: $enumDecodeNullable(_$PresetKeyEnumMap, json['preset']),
      terrain: (json['terrain'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TerrainEnumMap, e))
          .toList(),
      stay: $enumDecodeNullable(_$StayLengthEnumMap, json['stay']),
      peer: json['peer'] as bool?,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => IntentTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <IntentTag>[],
    );

Map<String, dynamic> _$SearchIntentToJson(_SearchIntent instance) =>
    <String, dynamic>{
      'month': instance.month,
      'monthRange': instance.monthRange,
      'preset': _$PresetKeyEnumMap[instance.preset],
      'terrain': instance.terrain?.map((e) => _$TerrainEnumMap[e]!).toList(),
      'stay': _$StayLengthEnumMap[instance.stay],
      'peer': instance.peer,
      'tags': instance.tags,
    };

const _$PresetKeyEnumMap = {
  PresetKey.quiet: 'quiet',
  PresetKey.lively: 'lively',
  PresetKey.custom: 'custom',
};

const _$TerrainEnumMap = {
  Terrain.coast: 'coast',
  Terrain.mountain: 'mountain',
  Terrain.city: 'city',
};

const _$StayLengthEnumMap = {
  StayLength.week: 'week',
  StayLength.twoWeeks: 'two_weeks',
  StayLength.month: 'month',
};
