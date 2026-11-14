// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'me.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteRegion {

 String get id; String get name; String get province; String? get photoUrl;/// 고른 달 기준(백엔드가 넣음)
 MetricScores get scores; List<String> get tags;/// 메모. 예: `11월 2주 체류 예정`
 String? get note;/// 방문 예정 월. 예: `2025-11`
 String? get visitMonth; String get addedAt;
/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteRegionCopyWith<FavoriteRegion> get copyWith => _$FavoriteRegionCopyWithImpl<FavoriteRegion>(this as FavoriteRegion, _$identity);

  /// Serializes this FavoriteRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FavoriteRegion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteRegion&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.scores, _this.scores) || other.scores == _this.scores)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.visitMonth, _this.visitMonth) || other.visitMonth == _this.visitMonth)&&(identical(other.addedAt, _this.addedAt) || other.addedAt == _this.addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoriteRegion;
  return Object.hash(runtimeType,_this.id,_this.name,_this.province,_this.photoUrl,_this.scores,const DeepCollectionEquality().hash(_this.tags),_this.note,_this.visitMonth,_this.addedAt);
}

@override
String toString() {
  final _this = this as FavoriteRegion;
  return 'FavoriteRegion(id: ${_this.id}, name: ${_this.name}, province: ${_this.province}, photoUrl: ${_this.photoUrl}, scores: ${_this.scores}, tags: ${_this.tags}, note: ${_this.note}, visitMonth: ${_this.visitMonth}, addedAt: ${_this.addedAt})';
}


}

/// @nodoc
abstract mixin class $FavoriteRegionCopyWith<$Res>  {
  factory $FavoriteRegionCopyWith(FavoriteRegion value, $Res Function(FavoriteRegion) _then) = _$FavoriteRegionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String province, String? photoUrl, MetricScores scores, List<String> tags, String? note, String? visitMonth, String addedAt
});


$MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class _$FavoriteRegionCopyWithImpl<$Res>
    implements $FavoriteRegionCopyWith<$Res> {
  _$FavoriteRegionCopyWithImpl(this._self, this._then);

  final FavoriteRegion _self;
  final $Res Function(FavoriteRegion) _then;

/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? province = null,Object? photoUrl = freezed,Object? scores = null,Object? tags = null,Object? note = freezed,Object? visitMonth = freezed,Object? addedAt = null,}) {
  return _then(FavoriteRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<$Res> get scores {
  
  return $MetricScoresCopyWith<$Res>(_self.scores, (value) {
    return _then(_self.copyWith(scores: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavoriteRegion].
extension FavoriteRegionPatterns on FavoriteRegion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteRegion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteRegion value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteRegion():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteRegion value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteRegion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String province,  String? photoUrl,  MetricScores scores,  List<String> tags,  String? note,  String? visitMonth,  String addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteRegion() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.scores,_that.tags,_that.note,_that.visitMonth,_that.addedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String province,  String? photoUrl,  MetricScores scores,  List<String> tags,  String? note,  String? visitMonth,  String addedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteRegion():
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.scores,_that.tags,_that.note,_that.visitMonth,_that.addedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String province,  String? photoUrl,  MetricScores scores,  List<String> tags,  String? note,  String? visitMonth,  String addedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteRegion() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.scores,_that.tags,_that.note,_that.visitMonth,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteRegion implements FavoriteRegion {
  const _FavoriteRegion({required this.id, required this.name, required this.province, this.photoUrl, required this.scores,  List<String> tags = const <String>[], this.note, this.visitMonth, required this.addedAt}): _tags = tags;
  factory _FavoriteRegion.fromJson(Map<String, dynamic> json) => _$FavoriteRegionFromJson(json);

@override final  String id;
@override final  String name;
@override final  String province;
@override final  String? photoUrl;
/// 고른 달 기준(백엔드가 넣음)
@override final  MetricScores scores;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// 메모. 예: `11월 2주 체류 예정`
@override final  String? note;
/// 방문 예정 월. 예: `2025-11`
@override final  String? visitMonth;
@override final  String addedAt;

/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteRegionCopyWith<_FavoriteRegion> get copyWith => __$FavoriteRegionCopyWithImpl<_FavoriteRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteRegionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteRegion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.province, province) || other.province == province)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.scores, scores) || other.scores == scores)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.note, note) || other.note == note)&&(identical(other.visitMonth, visitMonth) || other.visitMonth == visitMonth)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,province,photoUrl,scores,const DeepCollectionEquality().hash(_tags),note,visitMonth,addedAt);
}

@override
String toString() {
    return 'FavoriteRegion(id: $id, name: $name, province: $province, photoUrl: $photoUrl, scores: $scores, tags: $tags, note: $note, visitMonth: $visitMonth, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteRegionCopyWith<$Res> implements $FavoriteRegionCopyWith<$Res> {
  factory _$FavoriteRegionCopyWith(_FavoriteRegion value, $Res Function(_FavoriteRegion) _then) = __$FavoriteRegionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String province, String? photoUrl, MetricScores scores, List<String> tags, String? note, String? visitMonth, String addedAt
});


@override $MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class __$FavoriteRegionCopyWithImpl<$Res>
    implements _$FavoriteRegionCopyWith<$Res> {
  __$FavoriteRegionCopyWithImpl(this._self, this._then);

  final _FavoriteRegion _self;
  final $Res Function(_FavoriteRegion) _then;

/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? province = null,Object? photoUrl = freezed,Object? scores = null,Object? tags = null,Object? note = freezed,Object? visitMonth = freezed,Object? addedAt = null,}) {
  return _then(_FavoriteRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of FavoriteRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<$Res> get scores {
  
  return $MetricScoresCopyWith<$Res>(_self.scores, (value) {
    return _then(_self.copyWith(scores: value));
  });
}
}


/// @nodoc
mixin _$FavoriteSigungu {

 String get id; String get name;
/// Create a copy of FavoriteSigungu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteSigunguCopyWith<FavoriteSigungu> get copyWith => _$FavoriteSigunguCopyWithImpl<FavoriteSigungu>(this as FavoriteSigungu, _$identity);

  /// Serializes this FavoriteSigungu to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FavoriteSigungu;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteSigungu&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoriteSigungu;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as FavoriteSigungu;
  return 'FavoriteSigungu(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $FavoriteSigunguCopyWith<$Res>  {
  factory $FavoriteSigunguCopyWith(FavoriteSigungu value, $Res Function(FavoriteSigungu) _then) = _$FavoriteSigunguCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$FavoriteSigunguCopyWithImpl<$Res>
    implements $FavoriteSigunguCopyWith<$Res> {
  _$FavoriteSigunguCopyWithImpl(this._self, this._then);

  final FavoriteSigungu _self;
  final $Res Function(FavoriteSigungu) _then;

/// Create a copy of FavoriteSigungu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(FavoriteSigungu(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteSigungu].
extension FavoriteSigunguPatterns on FavoriteSigungu {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteSigungu value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteSigungu() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteSigungu value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteSigungu():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteSigungu value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteSigungu() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteSigungu() when $default != null:
return $default(_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _FavoriteSigungu():
return $default(_that.id,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteSigungu() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteSigungu implements FavoriteSigungu {
  const _FavoriteSigungu({required this.id, required this.name});
  factory _FavoriteSigungu.fromJson(Map<String, dynamic> json) => _$FavoriteSigunguFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of FavoriteSigungu
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteSigunguCopyWith<_FavoriteSigungu> get copyWith => __$FavoriteSigunguCopyWithImpl<_FavoriteSigungu>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteSigunguToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteSigungu&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'FavoriteSigungu(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$FavoriteSigunguCopyWith<$Res> implements $FavoriteSigunguCopyWith<$Res> {
  factory _$FavoriteSigunguCopyWith(_FavoriteSigungu value, $Res Function(_FavoriteSigungu) _then) = __$FavoriteSigunguCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$FavoriteSigunguCopyWithImpl<$Res>
    implements _$FavoriteSigunguCopyWith<$Res> {
  __$FavoriteSigunguCopyWithImpl(this._self, this._then);

  final _FavoriteSigungu _self;
  final $Res Function(_FavoriteSigungu) _then;

/// Create a copy of FavoriteSigungu
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_FavoriteSigungu(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FavoriteDong {

 String get id; String get name; DongKind get kind; FavoriteSigungu get sigungu; MetricScores get scores; String get addedAt;
/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteDongCopyWith<FavoriteDong> get copyWith => _$FavoriteDongCopyWithImpl<FavoriteDong>(this as FavoriteDong, _$identity);

  /// Serializes this FavoriteDong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FavoriteDong;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteDong&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.sigungu, _this.sigungu) || other.sigungu == _this.sigungu)&&(identical(other.scores, _this.scores) || other.scores == _this.scores)&&(identical(other.addedAt, _this.addedAt) || other.addedAt == _this.addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoriteDong;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.sigungu,_this.scores,_this.addedAt);
}

@override
String toString() {
  final _this = this as FavoriteDong;
  return 'FavoriteDong(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, sigungu: ${_this.sigungu}, scores: ${_this.scores}, addedAt: ${_this.addedAt})';
}


}

/// @nodoc
abstract mixin class $FavoriteDongCopyWith<$Res>  {
  factory $FavoriteDongCopyWith(FavoriteDong value, $Res Function(FavoriteDong) _then) = _$FavoriteDongCopyWithImpl;
@useResult
$Res call({
 String id, String name, DongKind kind, FavoriteSigungu sigungu, MetricScores scores, String addedAt
});


$FavoriteSigunguCopyWith<$Res> get sigungu;$MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class _$FavoriteDongCopyWithImpl<$Res>
    implements $FavoriteDongCopyWith<$Res> {
  _$FavoriteDongCopyWithImpl(this._self, this._then);

  final FavoriteDong _self;
  final $Res Function(FavoriteDong) _then;

/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? sigungu = null,Object? scores = null,Object? addedAt = null,}) {
  return _then(FavoriteDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as FavoriteSigungu,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoriteSigunguCopyWith<$Res> get sigungu {
  
  return $FavoriteSigunguCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<$Res> get scores {
  
  return $MetricScoresCopyWith<$Res>(_self.scores, (value) {
    return _then(_self.copyWith(scores: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavoriteDong].
extension FavoriteDongPatterns on FavoriteDong {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteDong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteDong() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteDong value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteDong():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteDong value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteDong() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DongKind kind,  FavoriteSigungu sigungu,  MetricScores scores,  String addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteDong() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.sigungu,_that.scores,_that.addedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DongKind kind,  FavoriteSigungu sigungu,  MetricScores scores,  String addedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteDong():
return $default(_that.id,_that.name,_that.kind,_that.sigungu,_that.scores,_that.addedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DongKind kind,  FavoriteSigungu sigungu,  MetricScores scores,  String addedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteDong() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.sigungu,_that.scores,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteDong implements FavoriteDong {
  const _FavoriteDong({required this.id, required this.name, required this.kind, required this.sigungu, required this.scores, required this.addedAt});
  factory _FavoriteDong.fromJson(Map<String, dynamic> json) => _$FavoriteDongFromJson(json);

@override final  String id;
@override final  String name;
@override final  DongKind kind;
@override final  FavoriteSigungu sigungu;
@override final  MetricScores scores;
@override final  String addedAt;

/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteDongCopyWith<_FavoriteDong> get copyWith => __$FavoriteDongCopyWithImpl<_FavoriteDong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteDongToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteDong&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.sigungu, sigungu) || other.sigungu == sigungu)&&(identical(other.scores, scores) || other.scores == scores)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,sigungu,scores,addedAt);
}

@override
String toString() {
    return 'FavoriteDong(id: $id, name: $name, kind: $kind, sigungu: $sigungu, scores: $scores, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteDongCopyWith<$Res> implements $FavoriteDongCopyWith<$Res> {
  factory _$FavoriteDongCopyWith(_FavoriteDong value, $Res Function(_FavoriteDong) _then) = __$FavoriteDongCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DongKind kind, FavoriteSigungu sigungu, MetricScores scores, String addedAt
});


@override $FavoriteSigunguCopyWith<$Res> get sigungu;@override $MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class __$FavoriteDongCopyWithImpl<$Res>
    implements _$FavoriteDongCopyWith<$Res> {
  __$FavoriteDongCopyWithImpl(this._self, this._then);

  final _FavoriteDong _self;
  final $Res Function(_FavoriteDong) _then;

/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? sigungu = null,Object? scores = null,Object? addedAt = null,}) {
  return _then(_FavoriteDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as FavoriteSigungu,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoriteSigunguCopyWith<$Res> get sigungu {
  
  return $FavoriteSigunguCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}/// Create a copy of FavoriteDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<$Res> get scores {
  
  return $MetricScoresCopyWith<$Res>(_self.scores, (value) {
    return _then(_self.copyWith(scores: value));
  });
}
}


/// @nodoc
mixin _$FavoritesResponse {

 String get month; List<FavoriteRegion> get regions; List<FavoriteDong> get dongs;
/// Create a copy of FavoritesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesResponseCopyWith<FavoritesResponse> get copyWith => _$FavoritesResponseCopyWithImpl<FavoritesResponse>(this as FavoritesResponse, _$identity);

  /// Serializes this FavoritesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FavoritesResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesResponse&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.regions, _this.regions)&&const DeepCollectionEquality().equals(other.dongs, _this.dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoritesResponse;
  return Object.hash(runtimeType,_this.month,const DeepCollectionEquality().hash(_this.regions),const DeepCollectionEquality().hash(_this.dongs));
}

@override
String toString() {
  final _this = this as FavoritesResponse;
  return 'FavoritesResponse(month: ${_this.month}, regions: ${_this.regions}, dongs: ${_this.dongs})';
}


}

/// @nodoc
abstract mixin class $FavoritesResponseCopyWith<$Res>  {
  factory $FavoritesResponseCopyWith(FavoritesResponse value, $Res Function(FavoritesResponse) _then) = _$FavoritesResponseCopyWithImpl;
@useResult
$Res call({
 String month, List<FavoriteRegion> regions, List<FavoriteDong> dongs
});




}
/// @nodoc
class _$FavoritesResponseCopyWithImpl<$Res>
    implements $FavoritesResponseCopyWith<$Res> {
  _$FavoritesResponseCopyWithImpl(this._self, this._then);

  final FavoritesResponse _self;
  final $Res Function(FavoritesResponse) _then;

/// Create a copy of FavoritesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? regions = null,Object? dongs = null,}) {
  return _then(FavoritesResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<FavoriteRegion>,dongs: null == dongs ? _self.dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<FavoriteDong>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesResponse].
extension FavoritesResponsePatterns on FavoritesResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesResponse value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  List<FavoriteRegion> regions,  List<FavoriteDong> dongs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesResponse() when $default != null:
return $default(_that.month,_that.regions,_that.dongs);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  List<FavoriteRegion> regions,  List<FavoriteDong> dongs)  $default,) {final _that = this;
switch (_that) {
case _FavoritesResponse():
return $default(_that.month,_that.regions,_that.dongs);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  List<FavoriteRegion> regions,  List<FavoriteDong> dongs)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesResponse() when $default != null:
return $default(_that.month,_that.regions,_that.dongs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoritesResponse implements FavoritesResponse {
  const _FavoritesResponse({required this.month,  List<FavoriteRegion> regions = const <FavoriteRegion>[],  List<FavoriteDong> dongs = const <FavoriteDong>[]}): _regions = regions,_dongs = dongs;
  factory _FavoritesResponse.fromJson(Map<String, dynamic> json) => _$FavoritesResponseFromJson(json);

@override final  String month;
 final  List<FavoriteRegion> _regions;
@override@JsonKey() List<FavoriteRegion> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<FavoriteDong> _dongs;
@override@JsonKey() List<FavoriteDong> get dongs {
  if (_dongs is EqualUnmodifiableListView) return _dongs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dongs);
}


/// Create a copy of FavoritesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesResponseCopyWith<_FavoritesResponse> get copyWith => __$FavoritesResponseCopyWithImpl<_FavoritesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoritesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesResponse&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.regions, _regions)&&const DeepCollectionEquality().equals(other.dongs, _dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_dongs));
}

@override
String toString() {
    return 'FavoritesResponse(month: $month, regions: $regions, dongs: $dongs)';
}


}

/// @nodoc
abstract mixin class _$FavoritesResponseCopyWith<$Res> implements $FavoritesResponseCopyWith<$Res> {
  factory _$FavoritesResponseCopyWith(_FavoritesResponse value, $Res Function(_FavoritesResponse) _then) = __$FavoritesResponseCopyWithImpl;
@override @useResult
$Res call({
 String month, List<FavoriteRegion> regions, List<FavoriteDong> dongs
});




}
/// @nodoc
class __$FavoritesResponseCopyWithImpl<$Res>
    implements _$FavoritesResponseCopyWith<$Res> {
  __$FavoritesResponseCopyWithImpl(this._self, this._then);

  final _FavoritesResponse _self;
  final $Res Function(_FavoritesResponse) _then;

/// Create a copy of FavoritesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? regions = null,Object? dongs = null,}) {
  return _then(_FavoritesResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<FavoriteRegion>,dongs: null == dongs ? _self._dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<FavoriteDong>,
  ));
}


}


/// @nodoc
mixin _$FavoriteIds {

 List<String> get regions; List<String> get dongs;
/// Create a copy of FavoriteIds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteIdsCopyWith<FavoriteIds> get copyWith => _$FavoriteIdsCopyWithImpl<FavoriteIds>(this as FavoriteIds, _$identity);

  /// Serializes this FavoriteIds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FavoriteIds;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteIds&&const DeepCollectionEquality().equals(other.regions, _this.regions)&&const DeepCollectionEquality().equals(other.dongs, _this.dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FavoriteIds;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.regions),const DeepCollectionEquality().hash(_this.dongs));
}

@override
String toString() {
  final _this = this as FavoriteIds;
  return 'FavoriteIds(regions: ${_this.regions}, dongs: ${_this.dongs})';
}


}

/// @nodoc
abstract mixin class $FavoriteIdsCopyWith<$Res>  {
  factory $FavoriteIdsCopyWith(FavoriteIds value, $Res Function(FavoriteIds) _then) = _$FavoriteIdsCopyWithImpl;
@useResult
$Res call({
 List<String> regions, List<String> dongs
});




}
/// @nodoc
class _$FavoriteIdsCopyWithImpl<$Res>
    implements $FavoriteIdsCopyWith<$Res> {
  _$FavoriteIdsCopyWithImpl(this._self, this._then);

  final FavoriteIds _self;
  final $Res Function(FavoriteIds) _then;

/// Create a copy of FavoriteIds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regions = null,Object? dongs = null,}) {
  return _then(FavoriteIds(
regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<String>,dongs: null == dongs ? _self.dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteIds].
extension FavoriteIdsPatterns on FavoriteIds {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteIds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteIds() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteIds value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteIds():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteIds value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteIds() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> regions,  List<String> dongs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteIds() when $default != null:
return $default(_that.regions,_that.dongs);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> regions,  List<String> dongs)  $default,) {final _that = this;
switch (_that) {
case _FavoriteIds():
return $default(_that.regions,_that.dongs);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> regions,  List<String> dongs)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteIds() when $default != null:
return $default(_that.regions,_that.dongs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteIds extends FavoriteIds {
  const _FavoriteIds({ List<String> regions = const <String>[],  List<String> dongs = const <String>[]}): _regions = regions,_dongs = dongs,super._();
  factory _FavoriteIds.fromJson(Map<String, dynamic> json) => _$FavoriteIdsFromJson(json);

 final  List<String> _regions;
@override@JsonKey() List<String> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

 final  List<String> _dongs;
@override@JsonKey() List<String> get dongs {
  if (_dongs is EqualUnmodifiableListView) return _dongs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dongs);
}


/// Create a copy of FavoriteIds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteIdsCopyWith<_FavoriteIds> get copyWith => __$FavoriteIdsCopyWithImpl<_FavoriteIds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteIdsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteIds&&const DeepCollectionEquality().equals(other.regions, _regions)&&const DeepCollectionEquality().equals(other.dongs, _dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_dongs));
}

@override
String toString() {
    return 'FavoriteIds(regions: $regions, dongs: $dongs)';
}


}

/// @nodoc
abstract mixin class _$FavoriteIdsCopyWith<$Res> implements $FavoriteIdsCopyWith<$Res> {
  factory _$FavoriteIdsCopyWith(_FavoriteIds value, $Res Function(_FavoriteIds) _then) = __$FavoriteIdsCopyWithImpl;
@override @useResult
$Res call({
 List<String> regions, List<String> dongs
});




}
/// @nodoc
class __$FavoriteIdsCopyWithImpl<$Res>
    implements _$FavoriteIdsCopyWith<$Res> {
  __$FavoriteIdsCopyWithImpl(this._self, this._then);

  final _FavoriteIds _self;
  final $Res Function(_FavoriteIds) _then;

/// Create a copy of FavoriteIds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regions = null,Object? dongs = null,}) {
  return _then(_FavoriteIds(
regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<String>,dongs: null == dongs ? _self._dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$StayCount {

 String get regionName; int get count;
/// Create a copy of StayCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StayCountCopyWith<StayCount> get copyWith => _$StayCountCopyWithImpl<StayCount>(this as StayCount, _$identity);

  /// Serializes this StayCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StayCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StayCount&&(identical(other.regionName, _this.regionName) || other.regionName == _this.regionName)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StayCount;
  return Object.hash(runtimeType,_this.regionName,_this.count);
}

@override
String toString() {
  final _this = this as StayCount;
  return 'StayCount(regionName: ${_this.regionName}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $StayCountCopyWith<$Res>  {
  factory $StayCountCopyWith(StayCount value, $Res Function(StayCount) _then) = _$StayCountCopyWithImpl;
@useResult
$Res call({
 String regionName, int count
});




}
/// @nodoc
class _$StayCountCopyWithImpl<$Res>
    implements $StayCountCopyWith<$Res> {
  _$StayCountCopyWithImpl(this._self, this._then);

  final StayCount _self;
  final $Res Function(StayCount) _then;

/// Create a copy of StayCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regionName = null,Object? count = null,}) {
  return _then(StayCount(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StayCount].
extension StayCountPatterns on StayCount {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StayCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StayCount() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StayCount value)  $default,){
final _that = this;
switch (_that) {
case _StayCount():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StayCount value)?  $default,){
final _that = this;
switch (_that) {
case _StayCount() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String regionName,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StayCount() when $default != null:
return $default(_that.regionName,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String regionName,  int count)  $default,) {final _that = this;
switch (_that) {
case _StayCount():
return $default(_that.regionName,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String regionName,  int count)?  $default,) {final _that = this;
switch (_that) {
case _StayCount() when $default != null:
return $default(_that.regionName,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StayCount implements StayCount {
  const _StayCount({required this.regionName, required this.count});
  factory _StayCount.fromJson(Map<String, dynamic> json) => _$StayCountFromJson(json);

@override final  String regionName;
@override final  int count;

/// Create a copy of StayCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StayCountCopyWith<_StayCount> get copyWith => __$StayCountCopyWithImpl<_StayCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StayCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StayCount&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,regionName,count);
}

@override
String toString() {
    return 'StayCount(regionName: $regionName, count: $count)';
}


}

/// @nodoc
abstract mixin class _$StayCountCopyWith<$Res> implements $StayCountCopyWith<$Res> {
  factory _$StayCountCopyWith(_StayCount value, $Res Function(_StayCount) _then) = __$StayCountCopyWithImpl;
@override @useResult
$Res call({
 String regionName, int count
});




}
/// @nodoc
class __$StayCountCopyWithImpl<$Res>
    implements _$StayCountCopyWith<$Res> {
  __$StayCountCopyWithImpl(this._self, this._then);

  final _StayCount _self;
  final $Res Function(_StayCount) _then;

/// Create a copy of StayCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regionName = null,Object? count = null,}) {
  return _then(_StayCount(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MeSummary {

 List<StayCount> get stays; int get tipCount; int get photoCount; int get favoriteCount; int get voteCount; String get createdAt;
/// Create a copy of MeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeSummaryCopyWith<MeSummary> get copyWith => _$MeSummaryCopyWithImpl<MeSummary>(this as MeSummary, _$identity);

  /// Serializes this MeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeSummary&&const DeepCollectionEquality().equals(other.stays, _this.stays)&&(identical(other.tipCount, _this.tipCount) || other.tipCount == _this.tipCount)&&(identical(other.photoCount, _this.photoCount) || other.photoCount == _this.photoCount)&&(identical(other.favoriteCount, _this.favoriteCount) || other.favoriteCount == _this.favoriteCount)&&(identical(other.voteCount, _this.voteCount) || other.voteCount == _this.voteCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeSummary;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.stays),_this.tipCount,_this.photoCount,_this.favoriteCount,_this.voteCount,_this.createdAt);
}

@override
String toString() {
  final _this = this as MeSummary;
  return 'MeSummary(stays: ${_this.stays}, tipCount: ${_this.tipCount}, photoCount: ${_this.photoCount}, favoriteCount: ${_this.favoriteCount}, voteCount: ${_this.voteCount}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MeSummaryCopyWith<$Res>  {
  factory $MeSummaryCopyWith(MeSummary value, $Res Function(MeSummary) _then) = _$MeSummaryCopyWithImpl;
@useResult
$Res call({
 List<StayCount> stays, int tipCount, int photoCount, int favoriteCount, int voteCount, String createdAt
});




}
/// @nodoc
class _$MeSummaryCopyWithImpl<$Res>
    implements $MeSummaryCopyWith<$Res> {
  _$MeSummaryCopyWithImpl(this._self, this._then);

  final MeSummary _self;
  final $Res Function(MeSummary) _then;

/// Create a copy of MeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stays = null,Object? tipCount = null,Object? photoCount = null,Object? favoriteCount = null,Object? voteCount = null,Object? createdAt = null,}) {
  return _then(MeSummary(
stays: null == stays ? _self.stays : stays // ignore: cast_nullable_to_non_nullable
as List<StayCount>,tipCount: null == tipCount ? _self.tipCount : tipCount // ignore: cast_nullable_to_non_nullable
as int,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MeSummary].
extension MeSummaryPatterns on MeSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeSummary value)  $default,){
final _that = this;
switch (_that) {
case _MeSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MeSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StayCount> stays,  int tipCount,  int photoCount,  int favoriteCount,  int voteCount,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeSummary() when $default != null:
return $default(_that.stays,_that.tipCount,_that.photoCount,_that.favoriteCount,_that.voteCount,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StayCount> stays,  int tipCount,  int photoCount,  int favoriteCount,  int voteCount,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _MeSummary():
return $default(_that.stays,_that.tipCount,_that.photoCount,_that.favoriteCount,_that.voteCount,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StayCount> stays,  int tipCount,  int photoCount,  int favoriteCount,  int voteCount,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MeSummary() when $default != null:
return $default(_that.stays,_that.tipCount,_that.photoCount,_that.favoriteCount,_that.voteCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeSummary implements MeSummary {
  const _MeSummary({ List<StayCount> stays = const <StayCount>[], required this.tipCount, required this.photoCount, required this.favoriteCount, required this.voteCount, required this.createdAt}): _stays = stays;
  factory _MeSummary.fromJson(Map<String, dynamic> json) => _$MeSummaryFromJson(json);

 final  List<StayCount> _stays;
@override@JsonKey() List<StayCount> get stays {
  if (_stays is EqualUnmodifiableListView) return _stays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stays);
}

@override final  int tipCount;
@override final  int photoCount;
@override final  int favoriteCount;
@override final  int voteCount;
@override final  String createdAt;

/// Create a copy of MeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeSummaryCopyWith<_MeSummary> get copyWith => __$MeSummaryCopyWithImpl<_MeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeSummary&&const DeepCollectionEquality().equals(other.stays, _stays)&&(identical(other.tipCount, tipCount) || other.tipCount == tipCount)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_stays),tipCount,photoCount,favoriteCount,voteCount,createdAt);
}

@override
String toString() {
    return 'MeSummary(stays: $stays, tipCount: $tipCount, photoCount: $photoCount, favoriteCount: $favoriteCount, voteCount: $voteCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MeSummaryCopyWith<$Res> implements $MeSummaryCopyWith<$Res> {
  factory _$MeSummaryCopyWith(_MeSummary value, $Res Function(_MeSummary) _then) = __$MeSummaryCopyWithImpl;
@override @useResult
$Res call({
 List<StayCount> stays, int tipCount, int photoCount, int favoriteCount, int voteCount, String createdAt
});




}
/// @nodoc
class __$MeSummaryCopyWithImpl<$Res>
    implements _$MeSummaryCopyWith<$Res> {
  __$MeSummaryCopyWithImpl(this._self, this._then);

  final _MeSummary _self;
  final $Res Function(_MeSummary) _then;

/// Create a copy of MeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stays = null,Object? tipCount = null,Object? photoCount = null,Object? favoriteCount = null,Object? voteCount = null,Object? createdAt = null,}) {
  return _then(_MeSummary(
stays: null == stays ? _self._stays : stays // ignore: cast_nullable_to_non_nullable
as List<StayCount>,tipCount: null == tipCount ? _self.tipCount : tipCount // ignore: cast_nullable_to_non_nullable
as int,photoCount: null == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MyTipTarget {

 TipTargetKind get kind; String get id; String get name;
/// Create a copy of MyTipTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTipTargetCopyWith<MyTipTarget> get copyWith => _$MyTipTargetCopyWithImpl<MyTipTarget>(this as MyTipTarget, _$identity);

  /// Serializes this MyTipTarget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyTipTarget;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTipTarget&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyTipTarget;
  return Object.hash(runtimeType,_this.kind,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as MyTipTarget;
  return 'MyTipTarget(kind: ${_this.kind}, id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $MyTipTargetCopyWith<$Res>  {
  factory $MyTipTargetCopyWith(MyTipTarget value, $Res Function(MyTipTarget) _then) = _$MyTipTargetCopyWithImpl;
@useResult
$Res call({
 TipTargetKind kind, String id, String name
});




}
/// @nodoc
class _$MyTipTargetCopyWithImpl<$Res>
    implements $MyTipTargetCopyWith<$Res> {
  _$MyTipTargetCopyWithImpl(this._self, this._then);

  final MyTipTarget _self;
  final $Res Function(MyTipTarget) _then;

/// Create a copy of MyTipTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? id = null,Object? name = null,}) {
  return _then(MyTipTarget(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TipTargetKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MyTipTarget].
extension MyTipTargetPatterns on MyTipTarget {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyTipTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyTipTarget() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyTipTarget value)  $default,){
final _that = this;
switch (_that) {
case _MyTipTarget():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyTipTarget value)?  $default,){
final _that = this;
switch (_that) {
case _MyTipTarget() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TipTargetKind kind,  String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyTipTarget() when $default != null:
return $default(_that.kind,_that.id,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TipTargetKind kind,  String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _MyTipTarget():
return $default(_that.kind,_that.id,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TipTargetKind kind,  String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _MyTipTarget() when $default != null:
return $default(_that.kind,_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyTipTarget implements MyTipTarget {
  const _MyTipTarget({required this.kind, required this.id, required this.name});
  factory _MyTipTarget.fromJson(Map<String, dynamic> json) => _$MyTipTargetFromJson(json);

@override final  TipTargetKind kind;
@override final  String id;
@override final  String name;

/// Create a copy of MyTipTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyTipTargetCopyWith<_MyTipTarget> get copyWith => __$MyTipTargetCopyWithImpl<_MyTipTarget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyTipTargetToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyTipTarget&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,id,name);
}

@override
String toString() {
    return 'MyTipTarget(kind: $kind, id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$MyTipTargetCopyWith<$Res> implements $MyTipTargetCopyWith<$Res> {
  factory _$MyTipTargetCopyWith(_MyTipTarget value, $Res Function(_MyTipTarget) _then) = __$MyTipTargetCopyWithImpl;
@override @useResult
$Res call({
 TipTargetKind kind, String id, String name
});




}
/// @nodoc
class __$MyTipTargetCopyWithImpl<$Res>
    implements _$MyTipTargetCopyWith<$Res> {
  __$MyTipTargetCopyWithImpl(this._self, this._then);

  final _MyTipTarget _self;
  final $Res Function(_MyTipTarget) _then;

/// Create a copy of MyTipTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? id = null,Object? name = null,}) {
  return _then(_MyTipTarget(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TipTargetKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TipAuthor {

 String get nickname; String get initial;
/// Create a copy of TipAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipAuthorCopyWith<TipAuthor> get copyWith => _$TipAuthorCopyWithImpl<TipAuthor>(this as TipAuthor, _$identity);

  /// Serializes this TipAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TipAuthor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipAuthor&&(identical(other.nickname, _this.nickname) || other.nickname == _this.nickname)&&(identical(other.initial, _this.initial) || other.initial == _this.initial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TipAuthor;
  return Object.hash(runtimeType,_this.nickname,_this.initial);
}

@override
String toString() {
  final _this = this as TipAuthor;
  return 'TipAuthor(nickname: ${_this.nickname}, initial: ${_this.initial})';
}


}

/// @nodoc
abstract mixin class $TipAuthorCopyWith<$Res>  {
  factory $TipAuthorCopyWith(TipAuthor value, $Res Function(TipAuthor) _then) = _$TipAuthorCopyWithImpl;
@useResult
$Res call({
 String nickname, String initial
});




}
/// @nodoc
class _$TipAuthorCopyWithImpl<$Res>
    implements $TipAuthorCopyWith<$Res> {
  _$TipAuthorCopyWithImpl(this._self, this._then);

  final TipAuthor _self;
  final $Res Function(TipAuthor) _then;

/// Create a copy of TipAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nickname = null,Object? initial = null,}) {
  return _then(TipAuthor(
nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TipAuthor].
extension TipAuthorPatterns on TipAuthor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipAuthor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipAuthor value)  $default,){
final _that = this;
switch (_that) {
case _TipAuthor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _TipAuthor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nickname,  String initial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipAuthor() when $default != null:
return $default(_that.nickname,_that.initial);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nickname,  String initial)  $default,) {final _that = this;
switch (_that) {
case _TipAuthor():
return $default(_that.nickname,_that.initial);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nickname,  String initial)?  $default,) {final _that = this;
switch (_that) {
case _TipAuthor() when $default != null:
return $default(_that.nickname,_that.initial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipAuthor implements TipAuthor {
  const _TipAuthor({required this.nickname, required this.initial});
  factory _TipAuthor.fromJson(Map<String, dynamic> json) => _$TipAuthorFromJson(json);

@override final  String nickname;
@override final  String initial;

/// Create a copy of TipAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipAuthorCopyWith<_TipAuthor> get copyWith => __$TipAuthorCopyWithImpl<_TipAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipAuthor&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.initial, initial) || other.initial == initial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nickname,initial);
}

@override
String toString() {
    return 'TipAuthor(nickname: $nickname, initial: $initial)';
}


}

/// @nodoc
abstract mixin class _$TipAuthorCopyWith<$Res> implements $TipAuthorCopyWith<$Res> {
  factory _$TipAuthorCopyWith(_TipAuthor value, $Res Function(_TipAuthor) _then) = __$TipAuthorCopyWithImpl;
@override @useResult
$Res call({
 String nickname, String initial
});




}
/// @nodoc
class __$TipAuthorCopyWithImpl<$Res>
    implements _$TipAuthorCopyWith<$Res> {
  __$TipAuthorCopyWithImpl(this._self, this._then);

  final _TipAuthor _self;
  final $Res Function(_TipAuthor) _then;

/// Create a copy of TipAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nickname = null,Object? initial = null,}) {
  return _then(_TipAuthor(
nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MyTip {

 String get id; TipAuthor get author; String get createdAt; String? get dongName;/// 예: `2주 체류`
 String? get stayLabel; String? get visitMonth; String get body; int get helpful; int get replies; MyTipTarget get target;
/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTipCopyWith<MyTip> get copyWith => _$MyTipCopyWithImpl<MyTip>(this as MyTip, _$identity);

  /// Serializes this MyTip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyTip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.dongName, _this.dongName) || other.dongName == _this.dongName)&&(identical(other.stayLabel, _this.stayLabel) || other.stayLabel == _this.stayLabel)&&(identical(other.visitMonth, _this.visitMonth) || other.visitMonth == _this.visitMonth)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.helpful, _this.helpful) || other.helpful == _this.helpful)&&(identical(other.replies, _this.replies) || other.replies == _this.replies)&&(identical(other.target, _this.target) || other.target == _this.target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyTip;
  return Object.hash(runtimeType,_this.id,_this.author,_this.createdAt,_this.dongName,_this.stayLabel,_this.visitMonth,_this.body,_this.helpful,_this.replies,_this.target);
}

@override
String toString() {
  final _this = this as MyTip;
  return 'MyTip(id: ${_this.id}, author: ${_this.author}, createdAt: ${_this.createdAt}, dongName: ${_this.dongName}, stayLabel: ${_this.stayLabel}, visitMonth: ${_this.visitMonth}, body: ${_this.body}, helpful: ${_this.helpful}, replies: ${_this.replies}, target: ${_this.target})';
}


}

/// @nodoc
abstract mixin class $MyTipCopyWith<$Res>  {
  factory $MyTipCopyWith(MyTip value, $Res Function(MyTip) _then) = _$MyTipCopyWithImpl;
@useResult
$Res call({
 String id, TipAuthor author, String createdAt, String? dongName, String? stayLabel, String? visitMonth, String body, int helpful, int replies, MyTipTarget target
});


$TipAuthorCopyWith<$Res> get author;$MyTipTargetCopyWith<$Res> get target;

}
/// @nodoc
class _$MyTipCopyWithImpl<$Res>
    implements $MyTipCopyWith<$Res> {
  _$MyTipCopyWithImpl(this._self, this._then);

  final MyTip _self;
  final $Res Function(MyTip) _then;

/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? dongName = freezed,Object? stayLabel = freezed,Object? visitMonth = freezed,Object? body = null,Object? helpful = null,Object? replies = null,Object? target = null,}) {
  return _then(MyTip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as TipAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,dongName: freezed == dongName ? _self.dongName : dongName // ignore: cast_nullable_to_non_nullable
as String?,stayLabel: freezed == stayLabel ? _self.stayLabel : stayLabel // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,helpful: null == helpful ? _self.helpful : helpful // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MyTipTarget,
  ));
}
/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipAuthorCopyWith<$Res> get author {
  
  return $TipAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyTipTargetCopyWith<$Res> get target {
  
  return $MyTipTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyTip].
extension MyTipPatterns on MyTip {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyTip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyTip() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyTip value)  $default,){
final _that = this;
switch (_that) {
case _MyTip():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyTip value)?  $default,){
final _that = this;
switch (_that) {
case _MyTip() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies,  MyTipTarget target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyTip() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies,_that.target);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies,  MyTipTarget target)  $default,) {final _that = this;
switch (_that) {
case _MyTip():
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies,_that.target);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies,  MyTipTarget target)?  $default,) {final _that = this;
switch (_that) {
case _MyTip() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyTip implements MyTip {
  const _MyTip({required this.id, required this.author, required this.createdAt, this.dongName, this.stayLabel, this.visitMonth, required this.body, required this.helpful, required this.replies, required this.target});
  factory _MyTip.fromJson(Map<String, dynamic> json) => _$MyTipFromJson(json);

@override final  String id;
@override final  TipAuthor author;
@override final  String createdAt;
@override final  String? dongName;
/// 예: `2주 체류`
@override final  String? stayLabel;
@override final  String? visitMonth;
@override final  String body;
@override final  int helpful;
@override final  int replies;
@override final  MyTipTarget target;

/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyTipCopyWith<_MyTip> get copyWith => __$MyTipCopyWithImpl<_MyTip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyTipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyTip&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dongName, dongName) || other.dongName == dongName)&&(identical(other.stayLabel, stayLabel) || other.stayLabel == stayLabel)&&(identical(other.visitMonth, visitMonth) || other.visitMonth == visitMonth)&&(identical(other.body, body) || other.body == body)&&(identical(other.helpful, helpful) || other.helpful == helpful)&&(identical(other.replies, replies) || other.replies == replies)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,author,createdAt,dongName,stayLabel,visitMonth,body,helpful,replies,target);
}

@override
String toString() {
    return 'MyTip(id: $id, author: $author, createdAt: $createdAt, dongName: $dongName, stayLabel: $stayLabel, visitMonth: $visitMonth, body: $body, helpful: $helpful, replies: $replies, target: $target)';
}


}

/// @nodoc
abstract mixin class _$MyTipCopyWith<$Res> implements $MyTipCopyWith<$Res> {
  factory _$MyTipCopyWith(_MyTip value, $Res Function(_MyTip) _then) = __$MyTipCopyWithImpl;
@override @useResult
$Res call({
 String id, TipAuthor author, String createdAt, String? dongName, String? stayLabel, String? visitMonth, String body, int helpful, int replies, MyTipTarget target
});


@override $TipAuthorCopyWith<$Res> get author;@override $MyTipTargetCopyWith<$Res> get target;

}
/// @nodoc
class __$MyTipCopyWithImpl<$Res>
    implements _$MyTipCopyWith<$Res> {
  __$MyTipCopyWithImpl(this._self, this._then);

  final _MyTip _self;
  final $Res Function(_MyTip) _then;

/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? dongName = freezed,Object? stayLabel = freezed,Object? visitMonth = freezed,Object? body = null,Object? helpful = null,Object? replies = null,Object? target = null,}) {
  return _then(_MyTip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as TipAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,dongName: freezed == dongName ? _self.dongName : dongName // ignore: cast_nullable_to_non_nullable
as String?,stayLabel: freezed == stayLabel ? _self.stayLabel : stayLabel // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,helpful: null == helpful ? _self.helpful : helpful // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MyTipTarget,
  ));
}

/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipAuthorCopyWith<$Res> get author {
  
  return $TipAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of MyTip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyTipTargetCopyWith<$Res> get target {
  
  return $MyTipTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// @nodoc
mixin _$MyTipsResponse {

 List<MyTip> get items; String? get nextCursor; int get helpfulSum;
/// Create a copy of MyTipsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTipsResponseCopyWith<MyTipsResponse> get copyWith => _$MyTipsResponseCopyWithImpl<MyTipsResponse>(this as MyTipsResponse, _$identity);

  /// Serializes this MyTipsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyTipsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTipsResponse&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.helpfulSum, _this.helpfulSum) || other.helpfulSum == _this.helpfulSum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyTipsResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor,_this.helpfulSum);
}

@override
String toString() {
  final _this = this as MyTipsResponse;
  return 'MyTipsResponse(items: ${_this.items}, nextCursor: ${_this.nextCursor}, helpfulSum: ${_this.helpfulSum})';
}


}

/// @nodoc
abstract mixin class $MyTipsResponseCopyWith<$Res>  {
  factory $MyTipsResponseCopyWith(MyTipsResponse value, $Res Function(MyTipsResponse) _then) = _$MyTipsResponseCopyWithImpl;
@useResult
$Res call({
 List<MyTip> items, String? nextCursor, int helpfulSum
});




}
/// @nodoc
class _$MyTipsResponseCopyWithImpl<$Res>
    implements $MyTipsResponseCopyWith<$Res> {
  _$MyTipsResponseCopyWithImpl(this._self, this._then);

  final MyTipsResponse _self;
  final $Res Function(MyTipsResponse) _then;

/// Create a copy of MyTipsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,Object? helpfulSum = null,}) {
  return _then(MyTipsResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MyTip>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,helpfulSum: null == helpfulSum ? _self.helpfulSum : helpfulSum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MyTipsResponse].
extension MyTipsResponsePatterns on MyTipsResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyTipsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyTipsResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyTipsResponse value)  $default,){
final _that = this;
switch (_that) {
case _MyTipsResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyTipsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MyTipsResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MyTip> items,  String? nextCursor,  int helpfulSum)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyTipsResponse() when $default != null:
return $default(_that.items,_that.nextCursor,_that.helpfulSum);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MyTip> items,  String? nextCursor,  int helpfulSum)  $default,) {final _that = this;
switch (_that) {
case _MyTipsResponse():
return $default(_that.items,_that.nextCursor,_that.helpfulSum);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MyTip> items,  String? nextCursor,  int helpfulSum)?  $default,) {final _that = this;
switch (_that) {
case _MyTipsResponse() when $default != null:
return $default(_that.items,_that.nextCursor,_that.helpfulSum);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyTipsResponse implements MyTipsResponse {
  const _MyTipsResponse({ List<MyTip> items = const <MyTip>[], this.nextCursor, this.helpfulSum = 0}): _items = items;
  factory _MyTipsResponse.fromJson(Map<String, dynamic> json) => _$MyTipsResponseFromJson(json);

 final  List<MyTip> _items;
@override@JsonKey() List<MyTip> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;
@override@JsonKey() final  int helpfulSum;

/// Create a copy of MyTipsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyTipsResponseCopyWith<_MyTipsResponse> get copyWith => __$MyTipsResponseCopyWithImpl<_MyTipsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyTipsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyTipsResponse&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.helpfulSum, helpfulSum) || other.helpfulSum == helpfulSum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor,helpfulSum);
}

@override
String toString() {
    return 'MyTipsResponse(items: $items, nextCursor: $nextCursor, helpfulSum: $helpfulSum)';
}


}

/// @nodoc
abstract mixin class _$MyTipsResponseCopyWith<$Res> implements $MyTipsResponseCopyWith<$Res> {
  factory _$MyTipsResponseCopyWith(_MyTipsResponse value, $Res Function(_MyTipsResponse) _then) = __$MyTipsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MyTip> items, String? nextCursor, int helpfulSum
});




}
/// @nodoc
class __$MyTipsResponseCopyWithImpl<$Res>
    implements _$MyTipsResponseCopyWith<$Res> {
  __$MyTipsResponseCopyWithImpl(this._self, this._then);

  final _MyTipsResponse _self;
  final $Res Function(_MyTipsResponse) _then;

/// Create a copy of MyTipsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,Object? helpfulSum = null,}) {
  return _then(_MyTipsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MyTip>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,helpfulSum: null == helpfulSum ? _self.helpfulSum : helpfulSum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MyPhoto {

 String get id; String get url;/// 예: `2025-10`
 String get month; String get regionName; PhotoStatus get status;
/// Create a copy of MyPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPhotoCopyWith<MyPhoto> get copyWith => _$MyPhotoCopyWithImpl<MyPhoto>(this as MyPhoto, _$identity);

  /// Serializes this MyPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyPhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPhoto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.regionName, _this.regionName) || other.regionName == _this.regionName)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyPhoto;
  return Object.hash(runtimeType,_this.id,_this.url,_this.month,_this.regionName,_this.status);
}

@override
String toString() {
  final _this = this as MyPhoto;
  return 'MyPhoto(id: ${_this.id}, url: ${_this.url}, month: ${_this.month}, regionName: ${_this.regionName}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $MyPhotoCopyWith<$Res>  {
  factory $MyPhotoCopyWith(MyPhoto value, $Res Function(MyPhoto) _then) = _$MyPhotoCopyWithImpl;
@useResult
$Res call({
 String id, String url, String month, String regionName, PhotoStatus status
});




}
/// @nodoc
class _$MyPhotoCopyWithImpl<$Res>
    implements $MyPhotoCopyWith<$Res> {
  _$MyPhotoCopyWithImpl(this._self, this._then);

  final MyPhoto _self;
  final $Res Function(MyPhoto) _then;

/// Create a copy of MyPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? month = null,Object? regionName = null,Object? status = null,}) {
  return _then(MyPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PhotoStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [MyPhoto].
extension MyPhotoPatterns on MyPhoto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyPhoto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyPhoto value)  $default,){
final _that = this;
switch (_that) {
case _MyPhoto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _MyPhoto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  String month,  String regionName,  PhotoStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPhoto() when $default != null:
return $default(_that.id,_that.url,_that.month,_that.regionName,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  String month,  String regionName,  PhotoStatus status)  $default,) {final _that = this;
switch (_that) {
case _MyPhoto():
return $default(_that.id,_that.url,_that.month,_that.regionName,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  String month,  String regionName,  PhotoStatus status)?  $default,) {final _that = this;
switch (_that) {
case _MyPhoto() when $default != null:
return $default(_that.id,_that.url,_that.month,_that.regionName,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyPhoto implements MyPhoto {
  const _MyPhoto({required this.id, required this.url, required this.month, required this.regionName, required this.status});
  factory _MyPhoto.fromJson(Map<String, dynamic> json) => _$MyPhotoFromJson(json);

@override final  String id;
@override final  String url;
/// 예: `2025-10`
@override final  String month;
@override final  String regionName;
@override final  PhotoStatus status;

/// Create a copy of MyPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPhotoCopyWith<_MyPhoto> get copyWith => __$MyPhotoCopyWithImpl<_MyPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.month, month) || other.month == month)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,url,month,regionName,status);
}

@override
String toString() {
    return 'MyPhoto(id: $id, url: $url, month: $month, regionName: $regionName, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MyPhotoCopyWith<$Res> implements $MyPhotoCopyWith<$Res> {
  factory _$MyPhotoCopyWith(_MyPhoto value, $Res Function(_MyPhoto) _then) = __$MyPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, String month, String regionName, PhotoStatus status
});




}
/// @nodoc
class __$MyPhotoCopyWithImpl<$Res>
    implements _$MyPhotoCopyWith<$Res> {
  __$MyPhotoCopyWithImpl(this._self, this._then);

  final _MyPhoto _self;
  final $Res Function(_MyPhoto) _then;

/// Create a copy of MyPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? month = null,Object? regionName = null,Object? status = null,}) {
  return _then(_MyPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PhotoStatus,
  ));
}


}


/// @nodoc
mixin _$MyPhotosResponse {

 List<MyPhoto> get items;
/// Create a copy of MyPhotosResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPhotosResponseCopyWith<MyPhotosResponse> get copyWith => _$MyPhotosResponseCopyWithImpl<MyPhotosResponse>(this as MyPhotosResponse, _$identity);

  /// Serializes this MyPhotosResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyPhotosResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPhotosResponse&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyPhotosResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as MyPhotosResponse;
  return 'MyPhotosResponse(items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $MyPhotosResponseCopyWith<$Res>  {
  factory $MyPhotosResponseCopyWith(MyPhotosResponse value, $Res Function(MyPhotosResponse) _then) = _$MyPhotosResponseCopyWithImpl;
@useResult
$Res call({
 List<MyPhoto> items
});




}
/// @nodoc
class _$MyPhotosResponseCopyWithImpl<$Res>
    implements $MyPhotosResponseCopyWith<$Res> {
  _$MyPhotosResponseCopyWithImpl(this._self, this._then);

  final MyPhotosResponse _self;
  final $Res Function(MyPhotosResponse) _then;

/// Create a copy of MyPhotosResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(MyPhotosResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MyPhoto>,
  ));
}

}


/// Adds pattern-matching-related methods to [MyPhotosResponse].
extension MyPhotosResponsePatterns on MyPhotosResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyPhotosResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyPhotosResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyPhotosResponse value)  $default,){
final _that = this;
switch (_that) {
case _MyPhotosResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyPhotosResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MyPhotosResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MyPhoto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPhotosResponse() when $default != null:
return $default(_that.items);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MyPhoto> items)  $default,) {final _that = this;
switch (_that) {
case _MyPhotosResponse():
return $default(_that.items);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MyPhoto> items)?  $default,) {final _that = this;
switch (_that) {
case _MyPhotosResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyPhotosResponse implements MyPhotosResponse {
  const _MyPhotosResponse({ List<MyPhoto> items = const <MyPhoto>[]}): _items = items;
  factory _MyPhotosResponse.fromJson(Map<String, dynamic> json) => _$MyPhotosResponseFromJson(json);

 final  List<MyPhoto> _items;
@override@JsonKey() List<MyPhoto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MyPhotosResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPhotosResponseCopyWith<_MyPhotosResponse> get copyWith => __$MyPhotosResponseCopyWithImpl<_MyPhotosResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyPhotosResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPhotosResponse&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'MyPhotosResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$MyPhotosResponseCopyWith<$Res> implements $MyPhotosResponseCopyWith<$Res> {
  factory _$MyPhotosResponseCopyWith(_MyPhotosResponse value, $Res Function(_MyPhotosResponse) _then) = __$MyPhotosResponseCopyWithImpl;
@override @useResult
$Res call({
 List<MyPhoto> items
});




}
/// @nodoc
class __$MyPhotosResponseCopyWithImpl<$Res>
    implements _$MyPhotosResponseCopyWith<$Res> {
  __$MyPhotosResponseCopyWithImpl(this._self, this._then);

  final _MyPhotosResponse _self;
  final $Res Function(_MyPhotosResponse) _then;

/// Create a copy of MyPhotosResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_MyPhotosResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MyPhoto>,
  ));
}


}


/// @nodoc
mixin _$MeSettings {

 bool get notifyBestMonth; bool get notifyTipReaction; bool get notifyPhotoSelected;
/// Create a copy of MeSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeSettingsCopyWith<MeSettings> get copyWith => _$MeSettingsCopyWithImpl<MeSettings>(this as MeSettings, _$identity);

  /// Serializes this MeSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeSettings&&(identical(other.notifyBestMonth, _this.notifyBestMonth) || other.notifyBestMonth == _this.notifyBestMonth)&&(identical(other.notifyTipReaction, _this.notifyTipReaction) || other.notifyTipReaction == _this.notifyTipReaction)&&(identical(other.notifyPhotoSelected, _this.notifyPhotoSelected) || other.notifyPhotoSelected == _this.notifyPhotoSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeSettings;
  return Object.hash(runtimeType,_this.notifyBestMonth,_this.notifyTipReaction,_this.notifyPhotoSelected);
}

@override
String toString() {
  final _this = this as MeSettings;
  return 'MeSettings(notifyBestMonth: ${_this.notifyBestMonth}, notifyTipReaction: ${_this.notifyTipReaction}, notifyPhotoSelected: ${_this.notifyPhotoSelected})';
}


}

/// @nodoc
abstract mixin class $MeSettingsCopyWith<$Res>  {
  factory $MeSettingsCopyWith(MeSettings value, $Res Function(MeSettings) _then) = _$MeSettingsCopyWithImpl;
@useResult
$Res call({
 bool notifyBestMonth, bool notifyTipReaction, bool notifyPhotoSelected
});




}
/// @nodoc
class _$MeSettingsCopyWithImpl<$Res>
    implements $MeSettingsCopyWith<$Res> {
  _$MeSettingsCopyWithImpl(this._self, this._then);

  final MeSettings _self;
  final $Res Function(MeSettings) _then;

/// Create a copy of MeSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notifyBestMonth = null,Object? notifyTipReaction = null,Object? notifyPhotoSelected = null,}) {
  return _then(MeSettings(
notifyBestMonth: null == notifyBestMonth ? _self.notifyBestMonth : notifyBestMonth // ignore: cast_nullable_to_non_nullable
as bool,notifyTipReaction: null == notifyTipReaction ? _self.notifyTipReaction : notifyTipReaction // ignore: cast_nullable_to_non_nullable
as bool,notifyPhotoSelected: null == notifyPhotoSelected ? _self.notifyPhotoSelected : notifyPhotoSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeSettings].
extension MeSettingsPatterns on MeSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeSettings value)  $default,){
final _that = this;
switch (_that) {
case _MeSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeSettings value)?  $default,){
final _that = this;
switch (_that) {
case _MeSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool notifyBestMonth,  bool notifyTipReaction,  bool notifyPhotoSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeSettings() when $default != null:
return $default(_that.notifyBestMonth,_that.notifyTipReaction,_that.notifyPhotoSelected);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool notifyBestMonth,  bool notifyTipReaction,  bool notifyPhotoSelected)  $default,) {final _that = this;
switch (_that) {
case _MeSettings():
return $default(_that.notifyBestMonth,_that.notifyTipReaction,_that.notifyPhotoSelected);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool notifyBestMonth,  bool notifyTipReaction,  bool notifyPhotoSelected)?  $default,) {final _that = this;
switch (_that) {
case _MeSettings() when $default != null:
return $default(_that.notifyBestMonth,_that.notifyTipReaction,_that.notifyPhotoSelected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeSettings implements MeSettings {
  const _MeSettings({required this.notifyBestMonth, required this.notifyTipReaction, required this.notifyPhotoSelected});
  factory _MeSettings.fromJson(Map<String, dynamic> json) => _$MeSettingsFromJson(json);

@override final  bool notifyBestMonth;
@override final  bool notifyTipReaction;
@override final  bool notifyPhotoSelected;

/// Create a copy of MeSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeSettingsCopyWith<_MeSettings> get copyWith => __$MeSettingsCopyWithImpl<_MeSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeSettings&&(identical(other.notifyBestMonth, notifyBestMonth) || other.notifyBestMonth == notifyBestMonth)&&(identical(other.notifyTipReaction, notifyTipReaction) || other.notifyTipReaction == notifyTipReaction)&&(identical(other.notifyPhotoSelected, notifyPhotoSelected) || other.notifyPhotoSelected == notifyPhotoSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,notifyBestMonth,notifyTipReaction,notifyPhotoSelected);
}

@override
String toString() {
    return 'MeSettings(notifyBestMonth: $notifyBestMonth, notifyTipReaction: $notifyTipReaction, notifyPhotoSelected: $notifyPhotoSelected)';
}


}

/// @nodoc
abstract mixin class _$MeSettingsCopyWith<$Res> implements $MeSettingsCopyWith<$Res> {
  factory _$MeSettingsCopyWith(_MeSettings value, $Res Function(_MeSettings) _then) = __$MeSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool notifyBestMonth, bool notifyTipReaction, bool notifyPhotoSelected
});




}
/// @nodoc
class __$MeSettingsCopyWithImpl<$Res>
    implements _$MeSettingsCopyWith<$Res> {
  __$MeSettingsCopyWithImpl(this._self, this._then);

  final _MeSettings _self;
  final $Res Function(_MeSettings) _then;

/// Create a copy of MeSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notifyBestMonth = null,Object? notifyTipReaction = null,Object? notifyPhotoSelected = null,}) {
  return _then(_MeSettings(
notifyBestMonth: null == notifyBestMonth ? _self.notifyBestMonth : notifyBestMonth // ignore: cast_nullable_to_non_nullable
as bool,notifyTipReaction: null == notifyTipReaction ? _self.notifyTipReaction : notifyTipReaction // ignore: cast_nullable_to_non_nullable
as bool,notifyPhotoSelected: null == notifyPhotoSelected ? _self.notifyPhotoSelected : notifyPhotoSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
