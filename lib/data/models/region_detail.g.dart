// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionPhoto _$RegionPhotoFromJson(Map<String, dynamic> json) =>
    _RegionPhoto(url: json['url'] as String, credit: json['credit'] as String?);

Map<String, dynamic> _$RegionPhotoToJson(_RegionPhoto instance) =>
    <String, dynamic>{'url': instance.url, 'credit': instance.credit};

_RegionStats _$RegionStatsFromJson(Map<String, dynamic> json) => _RegionStats(
  crowdIndex: (json['crowdIndex'] as num).toInt(),
  dayInflow: (json['dayInflow'] as num).toDouble(),
  quietRank: (json['quietRank'] as num).toInt(),
  peerShare: (json['peerShare'] as num).toInt(),
  overnightCoef: (json['overnightCoef'] as num).toDouble(),
  weekendRatio: (json['weekendRatio'] as num).toDouble(),
);

Map<String, dynamic> _$RegionStatsToJson(_RegionStats instance) =>
    <String, dynamic>{
      'crowdIndex': instance.crowdIndex,
      'dayInflow': instance.dayInflow,
      'quietRank': instance.quietRank,
      'peerShare': instance.peerShare,
      'overnightCoef': instance.overnightCoef,
      'weekendRatio': instance.weekendRatio,
    };

_MonthCrowd _$MonthCrowdFromJson(Map<String, dynamic> json) => _MonthCrowd(
  month: (json['month'] as num).toInt(),
  crowd: (json['crowd'] as num).toInt(),
);

Map<String, dynamic> _$MonthCrowdToJson(_MonthCrowd instance) =>
    <String, dynamic>{'month': instance.month, 'crowd': instance.crowd};

_RegionDong _$RegionDongFromJson(Map<String, dynamic> json) => _RegionDong(
  id: json['id'] as String,
  name: json['name'] as String,
  kind: $enumDecode(_$DongKindEnumMap, json['kind']),
  landmark: json['landmark'] as String,
  quietScore: (json['quietScore'] as num).toDouble(),
  peakMonth: (json['peakMonth'] as num).toInt(),
  crowdOfPeak: (json['crowdOfPeak'] as num).toInt(),
);

Map<String, dynamic> _$RegionDongToJson(_RegionDong instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$DongKindEnumMap[instance.kind]!,
      'landmark': instance.landmark,
      'quietScore': instance.quietScore,
      'peakMonth': instance.peakMonth,
      'crowdOfPeak': instance.crowdOfPeak,
    };

const _$DongKindEnumMap = {
  DongKind.living: 'living',
  DongKind.tourist: 'tourist',
};

_ExcludedDong _$ExcludedDongFromJson(Map<String, dynamic> json) =>
    _ExcludedDong(
      name: json['name'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$ExcludedDongToJson(_ExcludedDong instance) =>
    <String, dynamic>{'name': instance.name, 'reason': instance.reason};

_RegionLink _$RegionLinkFromJson(Map<String, dynamic> json) => _RegionLink(
  kind: json['kind'] as String,
  title: json['title'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$RegionLinkToJson(_RegionLink instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'title': instance.title,
      'url': instance.url,
    };

_RegionDetail _$RegionDetailFromJson(Map<String, dynamic> json) =>
    _RegionDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      province: json['province'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      seasonType: $enumDecode(_$SeasonTypeEnumMap, json['seasonType']),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => RegionPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RegionPhoto>[],
      month: json['month'] as String,
      stats: RegionStats.fromJson(json['stats'] as Map<String, dynamic>),
      months: (json['months'] as List<dynamic>)
          .map((e) => MonthCrowd.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestMonths:
          (json['bestMonths'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      avoidMonths:
          (json['avoidMonths'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      peerOffpeakMonths:
          (json['peerOffpeakMonths'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      dongs:
          (json['dongs'] as List<dynamic>?)
              ?.map((e) => RegionDong.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RegionDong>[],
      excludedDongs:
          (json['excludedDongs'] as List<dynamic>?)
              ?.map((e) => ExcludedDong.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExcludedDong>[],
      links:
          (json['links'] as List<dynamic>?)
              ?.map((e) => RegionLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RegionLink>[],
    );

Map<String, dynamic> _$RegionDetailToJson(_RegionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province': instance.province,
      'tags': instance.tags,
      'seasonType': _$SeasonTypeEnumMap[instance.seasonType]!,
      'photos': instance.photos,
      'month': instance.month,
      'stats': instance.stats,
      'months': instance.months,
      'bestMonths': instance.bestMonths,
      'avoidMonths': instance.avoidMonths,
      'peerOffpeakMonths': instance.peerOffpeakMonths,
      'dongs': instance.dongs,
      'excludedDongs': instance.excludedDongs,
      'links': instance.links,
    };

const _$SeasonTypeEnumMap = {
  SeasonType.summerBeach: 'summer_beach',
  SeasonType.springAutumn: 'spring_autumn',
  SeasonType.secondHalfRise: 'second_half_rise',
  SeasonType.flat: 'flat',
};
