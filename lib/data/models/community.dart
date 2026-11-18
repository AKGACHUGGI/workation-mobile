import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

/// 커뮤니티(팁 · 체감 투표 · 사진)가 붙는 대상. 지역(시군구)이거나 동네(행정동)입니다.
@immutable
class CommunityTarget {
  const CommunityTarget.region(this.id) : isDong = false;
  const CommunityTarget.dong(this.id) : isDong = true;

  final String id;
  final bool isDong;

  /// API 경로 앞부분. 예: `/api/regions/51820`
  String get path => isDong ? '/api/dongs/$id' : '/api/regions/$id';

  @override
  bool operator ==(Object other) =>
      other is CommunityTarget && other.id == id && other.isDong == isDong;

  @override
  int get hashCode => Object.hash(id, isDong);

  @override
  String toString() => path;
}

@freezed
abstract class TipAuthor with _$TipAuthor {
  const factory TipAuthor({required String nickname, required String initial}) =
      _TipAuthor;

  factory TipAuthor.fromJson(Map<String, dynamic> json) =>
      _$TipAuthorFromJson(json);
}

/// 한 줄 팁(워케이션 노트). 웹 `region/types.ts` 의 `Note` 와 같은 모양입니다.
@freezed
abstract class Tip with _$Tip {
  const factory Tip({
    required String id,
    required TipAuthor author,

    /// ISO 8601
    required String createdAt,
    String? dongName,

    /// 예: `2주 체류`
    String? stayLabel,

    /// `2025-10`
    String? visitMonth,
    required String body,
    @Default(0) int helpful,
    @Default(0) int replies,
  }) = _Tip;

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
}

/// `GET /api/{regions|dongs}/{id}/notes?sort=helpful`
@freezed
abstract class TipsResponse with _$TipsResponse {
  const factory TipsResponse({
    required int total,
    @Default(<Tip>[]) List<Tip> items,
    String? nextCursor,
  }) = _TipsResponse;

  factory TipsResponse.fromJson(Map<String, dynamic> json) =>
      _$TipsResponseFromJson(json);
}

/// 체감 투표의 선택. 서버에는 `yes` · `no` 로 보냅니다.
enum PollChoice {
  @JsonValue('yes')
  yes,
  @JsonValue('no')
  no,
}

/// 사용자가 올린 사진 한 장.
@freezed
abstract class UserPhoto with _$UserPhoto {
  const factory UserPhoto({required String url, required String author}) =
      _UserPhoto;

  factory UserPhoto.fromJson(Map<String, dynamic> json) =>
      _$UserPhotoFromJson(json);
}

/// `GET /api/{regions|dongs}/{id}/poll?month=` — 체감 투표 결과와 이달의 사진.
/// [myVote] 는 로그인한 사용자가 이미 골랐을 때만 옵니다(웹 응답에는 없는 확장 필드).
@freezed
abstract class PollResponse with _$PollResponse {
  const PollResponse._();

  const factory PollResponse({
    @Default('') String question,
    required int yes,
    required int no,
    required int total,
    @Default(<UserPhoto>[]) List<UserPhoto> photos,
    PollChoice? myVote,
  }) = _PollResponse;

  factory PollResponse.fromJson(Map<String, dynamic> json) =>
      _$PollResponseFromJson(json);

  /// 그래요 비율(정수 %). 아무도 안 눌렀으면 0.
  int get yesPercent => total == 0 ? 0 : (yes / total * 100).round();

  /// 아니요 비율. 투표가 있으면 합이 100 이 되게 맞춥니다.
  int get noPercent => total == 0 ? 0 : 100 - yesPercent;
}
