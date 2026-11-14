// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dong_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DongRef _$DongRefFromJson(Map<String, dynamic> json) =>
    _DongRef(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$DongRefToJson(_DongRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_DongStats _$DongStatsFromJson(Map<String, dynamic> json) => _DongStats(
  dayInflow: (json['dayInflow'] as num).toDouble(),
  localLife: (json['localLife'] as num).toInt(),
  peerShare: (json['peerShare'] as num).toInt(),
  eveningVibe: (json['eveningVibe'] as num).toDouble(),
  eveningSurplus: (json['eveningSurplus'] as num).toDouble(),
);

Map<String, dynamic> _$DongStatsToJson(_DongStats instance) =>
    <String, dynamic>{
      'dayInflow': instance.dayInflow,
      'localLife': instance.localLife,
      'peerShare': instance.peerShare,
      'eveningVibe': instance.eveningVibe,
      'eveningSurplus': instance.eveningSurplus,
    };

_DongScores _$DongScoresFromJson(Map<String, dynamic> json) => _DongScores(
  quiet: (json['quiet'] as num).toDouble(),
  vibe: (json['vibe'] as num).toDouble(),
  peer: (json['peer'] as num).toDouble(),
);

Map<String, dynamic> _$DongScoresToJson(_DongScores instance) =>
    <String, dynamic>{
      'quiet': instance.quiet,
      'vibe': instance.vibe,
      'peer': instance.peer,
    };

_Hourly _$HourlyFromJson(Map<String, dynamic> json) => _Hourly(
  weekday: (json['weekday'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  weekend: (json['weekend'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$HourlyToJson(_Hourly instance) => <String, dynamic>{
  'weekday': instance.weekday,
  'weekend': instance.weekend,
};

_Peak _$PeakFromJson(Map<String, dynamic> json) => _Peak(
  peakHour: (json['peakHour'] as num).toInt(),
  lowHour: (json['lowHour'] as num).toInt(),
  lowValue: (json['lowValue'] as num).toInt(),
);

Map<String, dynamic> _$PeakToJson(_Peak instance) => <String, dynamic>{
  'peakHour': instance.peakHour,
  'lowHour': instance.lowHour,
  'lowValue': instance.lowValue,
};

_Peaks _$PeaksFromJson(Map<String, dynamic> json) => _Peaks(
  weekday: Peak.fromJson(json['weekday'] as Map<String, dynamic>),
  weekend: Peak.fromJson(json['weekend'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PeaksToJson(_Peaks instance) => <String, dynamic>{
  'weekday': instance.weekday,
  'weekend': instance.weekend,
};

_DongDetail _$DongDetailFromJson(Map<String, dynamic> json) => _DongDetail(
  id: json['id'] as String,
  name: json['name'] as String,
  sigungu: DongRef.fromJson(json['sigungu'] as Map<String, dynamic>),
  province: json['province'] as String,
  kind: $enumDecode(_$DongKindEnumMap, json['kind']),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  photos:
      (json['photos'] as List<dynamic>?)
          ?.map((e) => RegionPhoto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RegionPhoto>[],
  landmarks:
      (json['landmarks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  accessNote: json['accessNote'] as String? ?? '',
  month: json['month'] as String,
  stats: DongStats.fromJson(json['stats'] as Map<String, dynamic>),
  scores: json['scores'] == null
      ? null
      : DongScores.fromJson(json['scores'] as Map<String, dynamic>),
  dongCount: (json['dongCount'] as num?)?.toInt() ?? 0,
  hourly: Hourly.fromJson(json['hourly'] as Map<String, dynamic>),
  peaks: Peaks.fromJson(json['peaks'] as Map<String, dynamic>),
  activityMix:
      (json['activityMix'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  seasonType: $enumDecode(_$SeasonTypeEnumMap, json['seasonType']),
);

Map<String, dynamic> _$DongDetailToJson(_DongDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sigungu': instance.sigungu,
      'province': instance.province,
      'kind': _$DongKindEnumMap[instance.kind]!,
      'tags': instance.tags,
      'photos': instance.photos,
      'landmarks': instance.landmarks,
      'accessNote': instance.accessNote,
      'month': instance.month,
      'stats': instance.stats,
      'scores': instance.scores,
      'dongCount': instance.dongCount,
      'hourly': instance.hourly,
      'peaks': instance.peaks,
      'activityMix': instance.activityMix,
      'seasonType': _$SeasonTypeEnumMap[instance.seasonType]!,
    };

const _$DongKindEnumMap = {
  DongKind.living: 'living',
  DongKind.tourist: 'tourist',
};

const _$SeasonTypeEnumMap = {
  SeasonType.summerBeach: 'summer_beach',
  SeasonType.springAutumn: 'spring_autumn',
  SeasonType.secondHalfRise: 'second_half_rise',
  SeasonType.flat: 'flat',
};
