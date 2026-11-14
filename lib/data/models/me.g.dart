// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteRegion _$FavoriteRegionFromJson(Map<String, dynamic> json) =>
    _FavoriteRegion(
      id: json['id'] as String,
      name: json['name'] as String,
      province: json['province'] as String,
      photoUrl: json['photoUrl'] as String?,
      scores: MetricScores.fromJson(json['scores'] as Map<String, dynamic>),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      note: json['note'] as String?,
      visitMonth: json['visitMonth'] as String?,
      addedAt: json['addedAt'] as String,
    );

Map<String, dynamic> _$FavoriteRegionToJson(_FavoriteRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province': instance.province,
      'photoUrl': instance.photoUrl,
      'scores': instance.scores,
      'tags': instance.tags,
      'note': instance.note,
      'visitMonth': instance.visitMonth,
      'addedAt': instance.addedAt,
    };

_FavoriteSigungu _$FavoriteSigunguFromJson(Map<String, dynamic> json) =>
    _FavoriteSigungu(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$FavoriteSigunguToJson(_FavoriteSigungu instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_FavoriteDong _$FavoriteDongFromJson(Map<String, dynamic> json) =>
    _FavoriteDong(
      id: json['id'] as String,
      name: json['name'] as String,
      kind: $enumDecode(_$DongKindEnumMap, json['kind']),
      sigungu: FavoriteSigungu.fromJson(
        json['sigungu'] as Map<String, dynamic>,
      ),
      scores: MetricScores.fromJson(json['scores'] as Map<String, dynamic>),
      addedAt: json['addedAt'] as String,
    );

Map<String, dynamic> _$FavoriteDongToJson(_FavoriteDong instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$DongKindEnumMap[instance.kind]!,
      'sigungu': instance.sigungu,
      'scores': instance.scores,
      'addedAt': instance.addedAt,
    };

const _$DongKindEnumMap = {
  DongKind.living: 'living',
  DongKind.tourist: 'tourist',
};

_FavoritesResponse _$FavoritesResponseFromJson(Map<String, dynamic> json) =>
    _FavoritesResponse(
      month: json['month'] as String,
      regions:
          (json['regions'] as List<dynamic>?)
              ?.map((e) => FavoriteRegion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FavoriteRegion>[],
      dongs:
          (json['dongs'] as List<dynamic>?)
              ?.map((e) => FavoriteDong.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FavoriteDong>[],
    );

Map<String, dynamic> _$FavoritesResponseToJson(_FavoritesResponse instance) =>
    <String, dynamic>{
      'month': instance.month,
      'regions': instance.regions,
      'dongs': instance.dongs,
    };

_FavoriteIds _$FavoriteIdsFromJson(Map<String, dynamic> json) => _FavoriteIds(
  regions:
      (json['regions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  dongs:
      (json['dongs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$FavoriteIdsToJson(_FavoriteIds instance) =>
    <String, dynamic>{'regions': instance.regions, 'dongs': instance.dongs};

_StayCount _$StayCountFromJson(Map<String, dynamic> json) => _StayCount(
  regionName: json['regionName'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$StayCountToJson(_StayCount instance) =>
    <String, dynamic>{
      'regionName': instance.regionName,
      'count': instance.count,
    };

_MeSummary _$MeSummaryFromJson(Map<String, dynamic> json) => _MeSummary(
  stays:
      (json['stays'] as List<dynamic>?)
          ?.map((e) => StayCount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StayCount>[],
  tipCount: (json['tipCount'] as num).toInt(),
  photoCount: (json['photoCount'] as num).toInt(),
  favoriteCount: (json['favoriteCount'] as num).toInt(),
  voteCount: (json['voteCount'] as num).toInt(),
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$MeSummaryToJson(_MeSummary instance) =>
    <String, dynamic>{
      'stays': instance.stays,
      'tipCount': instance.tipCount,
      'photoCount': instance.photoCount,
      'favoriteCount': instance.favoriteCount,
      'voteCount': instance.voteCount,
      'createdAt': instance.createdAt,
    };

_MyTipTarget _$MyTipTargetFromJson(Map<String, dynamic> json) => _MyTipTarget(
  kind: $enumDecode(_$TipTargetKindEnumMap, json['kind']),
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$MyTipTargetToJson(_MyTipTarget instance) =>
    <String, dynamic>{
      'kind': _$TipTargetKindEnumMap[instance.kind]!,
      'id': instance.id,
      'name': instance.name,
    };

const _$TipTargetKindEnumMap = {
  TipTargetKind.region: 'region',
  TipTargetKind.dong: 'dong',
};

_TipAuthor _$TipAuthorFromJson(Map<String, dynamic> json) => _TipAuthor(
  nickname: json['nickname'] as String,
  initial: json['initial'] as String,
);

Map<String, dynamic> _$TipAuthorToJson(_TipAuthor instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'initial': instance.initial,
    };

_MyTip _$MyTipFromJson(Map<String, dynamic> json) => _MyTip(
  id: json['id'] as String,
  author: TipAuthor.fromJson(json['author'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
  dongName: json['dongName'] as String?,
  stayLabel: json['stayLabel'] as String?,
  visitMonth: json['visitMonth'] as String?,
  body: json['body'] as String,
  helpful: (json['helpful'] as num).toInt(),
  replies: (json['replies'] as num).toInt(),
  target: MyTipTarget.fromJson(json['target'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MyTipToJson(_MyTip instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'createdAt': instance.createdAt,
  'dongName': instance.dongName,
  'stayLabel': instance.stayLabel,
  'visitMonth': instance.visitMonth,
  'body': instance.body,
  'helpful': instance.helpful,
  'replies': instance.replies,
  'target': instance.target,
};

_MyTipsResponse _$MyTipsResponseFromJson(Map<String, dynamic> json) =>
    _MyTipsResponse(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MyTip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MyTip>[],
      nextCursor: json['nextCursor'] as String?,
      helpfulSum: (json['helpfulSum'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MyTipsResponseToJson(_MyTipsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextCursor': instance.nextCursor,
      'helpfulSum': instance.helpfulSum,
    };

_MyPhoto _$MyPhotoFromJson(Map<String, dynamic> json) => _MyPhoto(
  id: json['id'] as String,
  url: json['url'] as String,
  month: json['month'] as String,
  regionName: json['regionName'] as String,
  status: $enumDecode(_$PhotoStatusEnumMap, json['status']),
);

Map<String, dynamic> _$MyPhotoToJson(_MyPhoto instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'month': instance.month,
  'regionName': instance.regionName,
  'status': _$PhotoStatusEnumMap[instance.status]!,
};

const _$PhotoStatusEnumMap = {
  PhotoStatus.approved: 'approved',
  PhotoStatus.pending: 'pending',
};

_MyPhotosResponse _$MyPhotosResponseFromJson(Map<String, dynamic> json) =>
    _MyPhotosResponse(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MyPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MyPhoto>[],
    );

Map<String, dynamic> _$MyPhotosResponseToJson(_MyPhotosResponse instance) =>
    <String, dynamic>{'items': instance.items};

_MeSettings _$MeSettingsFromJson(Map<String, dynamic> json) => _MeSettings(
  notifyBestMonth: json['notifyBestMonth'] as bool,
  notifyTipReaction: json['notifyTipReaction'] as bool,
  notifyPhotoSelected: json['notifyPhotoSelected'] as bool,
);

Map<String, dynamic> _$MeSettingsToJson(_MeSettings instance) =>
    <String, dynamic>{
      'notifyBestMonth': instance.notifyBestMonth,
      'notifyTipReaction': instance.notifyTipReaction,
      'notifyPhotoSelected': instance.notifyPhotoSelected,
    };
