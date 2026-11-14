// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MetricScores _$MetricScoresFromJson(Map<String, dynamic> json) =>
    _MetricScores(
      quiet: (json['quiet'] as num).toDouble(),
      crowd: (json['crowd'] as num).toDouble(),
      peer: (json['peer'] as num).toDouble(),
      overnight: (json['overnight'] as num).toDouble(),
      vibe: (json['vibe'] as num).toDouble(),
    );

Map<String, dynamic> _$MetricScoresToJson(_MetricScores instance) =>
    <String, dynamic>{
      'quiet': instance.quiet,
      'crowd': instance.crowd,
      'peer': instance.peer,
      'overnight': instance.overnight,
      'vibe': instance.vibe,
    };

_PopularRegion _$PopularRegionFromJson(Map<String, dynamic> json) =>
    _PopularRegion(
      id: json['id'] as String,
      name: json['name'] as String,
      province: json['province'] as String,
      photoUrl: json['photoUrl'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      terrain:
          (json['terrain'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$TerrainEnumMap, e))
              .toList() ??
          const <Terrain>[],
      scores: MetricScores.fromJson(json['scores'] as Map<String, dynamic>),
      favoriteCount: (json['favoriteCount'] as num).toInt(),
      viewCount: (json['viewCount'] as num).toInt(),
    );

Map<String, dynamic> _$PopularRegionToJson(_PopularRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province': instance.province,
      'photoUrl': instance.photoUrl,
      'tags': instance.tags,
      'terrain': instance.terrain.map((e) => _$TerrainEnumMap[e]!).toList(),
      'scores': instance.scores,
      'favoriteCount': instance.favoriteCount,
      'viewCount': instance.viewCount,
    };

const _$TerrainEnumMap = {
  Terrain.coast: 'coast',
  Terrain.mountain: 'mountain',
  Terrain.city: 'city',
};

_PopularResponse _$PopularResponseFromJson(Map<String, dynamic> json) =>
    _PopularResponse(
      month: json['month'] as String,
      asOf: json['asOf'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => PopularRegion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PopularResponseToJson(_PopularResponse instance) =>
    <String, dynamic>{
      'month': instance.month,
      'asOf': instance.asOf,
      'items': instance.items,
    };
