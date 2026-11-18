// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TipAuthor _$TipAuthorFromJson(Map<String, dynamic> json) => _TipAuthor(
  nickname: json['nickname'] as String,
  initial: json['initial'] as String,
);

Map<String, dynamic> _$TipAuthorToJson(_TipAuthor instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'initial': instance.initial,
    };

_Tip _$TipFromJson(Map<String, dynamic> json) => _Tip(
  id: json['id'] as String,
  author: TipAuthor.fromJson(json['author'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
  dongName: json['dongName'] as String?,
  stayLabel: json['stayLabel'] as String?,
  visitMonth: json['visitMonth'] as String?,
  body: json['body'] as String,
  helpful: (json['helpful'] as num?)?.toInt() ?? 0,
  replies: (json['replies'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TipToJson(_Tip instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'createdAt': instance.createdAt,
  'dongName': instance.dongName,
  'stayLabel': instance.stayLabel,
  'visitMonth': instance.visitMonth,
  'body': instance.body,
  'helpful': instance.helpful,
  'replies': instance.replies,
};

_TipsResponse _$TipsResponseFromJson(Map<String, dynamic> json) =>
    _TipsResponse(
      total: (json['total'] as num).toInt(),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Tip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Tip>[],
      nextCursor: json['nextCursor'] as String?,
    );

Map<String, dynamic> _$TipsResponseToJson(_TipsResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
      'nextCursor': instance.nextCursor,
    };

_UserPhoto _$UserPhotoFromJson(Map<String, dynamic> json) =>
    _UserPhoto(url: json['url'] as String, author: json['author'] as String);

Map<String, dynamic> _$UserPhotoToJson(_UserPhoto instance) =>
    <String, dynamic>{'url': instance.url, 'author': instance.author};

_PollResponse _$PollResponseFromJson(Map<String, dynamic> json) =>
    _PollResponse(
      question: json['question'] as String? ?? '',
      yes: (json['yes'] as num).toInt(),
      no: (json['no'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => UserPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserPhoto>[],
      myVote: $enumDecodeNullable(_$PollChoiceEnumMap, json['myVote']),
    );

Map<String, dynamic> _$PollResponseToJson(_PollResponse instance) =>
    <String, dynamic>{
      'question': instance.question,
      'yes': instance.yes,
      'no': instance.no,
      'total': instance.total,
      'photos': instance.photos,
      'myVote': _$PollChoiceEnumMap[instance.myVote],
    };

const _$PollChoiceEnumMap = {PollChoice.yes: 'yes', PollChoice.no: 'no'};
