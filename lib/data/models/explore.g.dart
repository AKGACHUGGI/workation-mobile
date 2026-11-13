// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeoPoint _$GeoPointFromJson(Map<String, dynamic> json) => _GeoPoint(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$GeoPointToJson(_GeoPoint instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};

_TypeScore _$TypeScoreFromJson(Map<String, dynamic> json) => _TypeScore(
  name: json['name'] as String,
  score: (json['score'] as num).toDouble(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$TypeScoreToJson(_TypeScore instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
      'reason': instance.reason,
    };

_PinGrades _$PinGradesFromJson(Map<String, dynamic> json) => _PinGrades(
  quiet: $enumDecodeNullable(_$GradeEnumMap, json['quiet']),
  evening: $enumDecodeNullable(_$GradeEnumMap, json['evening']),
);

Map<String, dynamic> _$PinGradesToJson(_PinGrades instance) =>
    <String, dynamic>{
      'quiet': _$GradeEnumMap[instance.quiet],
      'evening': _$GradeEnumMap[instance.evening],
    };

const _$GradeEnumMap = {Grade.s: 'S', Grade.a: 'A', Grade.b: 'B', Grade.c: 'C'};

_PinDong _$PinDongFromJson(Map<String, dynamic> json) => _PinDong(
  id: json['id'] as String,
  name: json['name'] as String,
  center: json['center'] == null
      ? null
      : GeoPoint.fromJson(json['center'] as Map<String, dynamic>),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  topType: json['topType'] as String?,
  topScore: (json['topScore'] as num?)?.toDouble(),
  coastal: json['coastal'] as bool? ?? false,
  life: json['life'] as String?,
  grades: json['grades'] == null
      ? const PinGrades()
      : PinGrades.fromJson(json['grades'] as Map<String, dynamic>),
  types: (json['types'] as List<dynamic>?)
      ?.map((e) => TypeScore.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PinDongToJson(_PinDong instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'center': instance.center,
  'tags': instance.tags,
  'topType': instance.topType,
  'topScore': instance.topScore,
  'coastal': instance.coastal,
  'life': instance.life,
  'grades': instance.grades,
  'types': instance.types,
};

_PinsResponse _$PinsResponseFromJson(Map<String, dynamic> json) =>
    _PinsResponse(
      sigunguId: json['sigunguId'] as String,
      dongs: (json['dongs'] as List<dynamic>)
          .map((e) => PinDong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PinsResponseToJson(_PinsResponse instance) =>
    <String, dynamic>{'sigunguId': instance.sigunguId, 'dongs': instance.dongs};

_SigunguRef _$SigunguRefFromJson(Map<String, dynamic> json) =>
    _SigunguRef(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$SigunguRefToJson(_SigunguRef instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_ExploreDong _$ExploreDongFromJson(Map<String, dynamic> json) => _ExploreDong(
  id: json['id'] as String,
  name: json['name'] as String,
  sigungu: SigunguRef.fromJson(json['sigungu'] as Map<String, dynamic>),
  sido: json['sido'] as String,
  coastKm: (json['coastKm'] as num?)?.toDouble(),
  types:
      (json['types'] as List<dynamic>?)
          ?.map((e) => TypeScore.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TypeScore>[],
  briefing:
      (json['briefing'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$ExploreDongToJson(_ExploreDong instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sigungu': instance.sigungu,
      'sido': instance.sido,
      'coastKm': instance.coastKm,
      'types': instance.types,
      'briefing': instance.briefing,
    };
