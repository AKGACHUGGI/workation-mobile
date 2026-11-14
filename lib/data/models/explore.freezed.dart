// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeoPoint {

 double get lat; double get lng;
/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPointCopyWith<GeoPoint> get copyWith => _$GeoPointCopyWithImpl<GeoPoint>(this as GeoPoint, _$identity);

  /// Serializes this GeoPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GeoPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPoint&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GeoPoint;
  return Object.hash(runtimeType,_this.lat,_this.lng);
}

@override
String toString() {
  final _this = this as GeoPoint;
  return 'GeoPoint(lat: ${_this.lat}, lng: ${_this.lng})';
}


}

/// @nodoc
abstract mixin class $GeoPointCopyWith<$Res>  {
  factory $GeoPointCopyWith(GeoPoint value, $Res Function(GeoPoint) _then) = _$GeoPointCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$GeoPointCopyWithImpl<$Res>
    implements $GeoPointCopyWith<$Res> {
  _$GeoPointCopyWithImpl(this._self, this._then);

  final GeoPoint _self;
  final $Res Function(GeoPoint) _then;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(GeoPoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GeoPoint].
extension GeoPointPatterns on GeoPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoPoint value)  $default,){
final _that = this;
switch (_that) {
case _GeoPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoPoint value)?  $default,){
final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _GeoPoint():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeoPoint implements GeoPoint {
  const _GeoPoint({required this.lat, required this.lng});
  factory _GeoPoint.fromJson(Map<String, dynamic> json) => _$GeoPointFromJson(json);

@override final  double lat;
@override final  double lng;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPointCopyWith<_GeoPoint> get copyWith => __$GeoPointCopyWithImpl<_GeoPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeoPointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,lat,lng);
}

@override
String toString() {
    return 'GeoPoint(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$GeoPointCopyWith<$Res> implements $GeoPointCopyWith<$Res> {
  factory _$GeoPointCopyWith(_GeoPoint value, $Res Function(_GeoPoint) _then) = __$GeoPointCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$GeoPointCopyWithImpl<$Res>
    implements _$GeoPointCopyWith<$Res> {
  __$GeoPointCopyWithImpl(this._self, this._then);

  final _GeoPoint _self;
  final $Res Function(_GeoPoint) _then;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_GeoPoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TypeScore {

 String get name; double get score; String? get reason;
/// Create a copy of TypeScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypeScoreCopyWith<TypeScore> get copyWith => _$TypeScoreCopyWithImpl<TypeScore>(this as TypeScore, _$identity);

  /// Serializes this TypeScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TypeScore;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypeScore&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TypeScore;
  return Object.hash(runtimeType,_this.name,_this.score,_this.reason);
}

@override
String toString() {
  final _this = this as TypeScore;
  return 'TypeScore(name: ${_this.name}, score: ${_this.score}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $TypeScoreCopyWith<$Res>  {
  factory $TypeScoreCopyWith(TypeScore value, $Res Function(TypeScore) _then) = _$TypeScoreCopyWithImpl;
@useResult
$Res call({
 String name, double score, String? reason
});




}
/// @nodoc
class _$TypeScoreCopyWithImpl<$Res>
    implements $TypeScoreCopyWith<$Res> {
  _$TypeScoreCopyWithImpl(this._self, this._then);

  final TypeScore _self;
  final $Res Function(TypeScore) _then;

/// Create a copy of TypeScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? score = null,Object? reason = freezed,}) {
  return _then(TypeScore(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TypeScore].
extension TypeScorePatterns on TypeScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypeScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypeScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypeScore value)  $default,){
final _that = this;
switch (_that) {
case _TypeScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypeScore value)?  $default,){
final _that = this;
switch (_that) {
case _TypeScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double score,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypeScore() when $default != null:
return $default(_that.name,_that.score,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double score,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _TypeScore():
return $default(_that.name,_that.score,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double score,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _TypeScore() when $default != null:
return $default(_that.name,_that.score,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TypeScore implements TypeScore {
  const _TypeScore({required this.name, required this.score, this.reason});
  factory _TypeScore.fromJson(Map<String, dynamic> json) => _$TypeScoreFromJson(json);

@override final  String name;
@override final  double score;
@override final  String? reason;

/// Create a copy of TypeScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypeScoreCopyWith<_TypeScore> get copyWith => __$TypeScoreCopyWithImpl<_TypeScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TypeScoreToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypeScore&&(identical(other.name, name) || other.name == name)&&(identical(other.score, score) || other.score == score)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,score,reason);
}

@override
String toString() {
    return 'TypeScore(name: $name, score: $score, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$TypeScoreCopyWith<$Res> implements $TypeScoreCopyWith<$Res> {
  factory _$TypeScoreCopyWith(_TypeScore value, $Res Function(_TypeScore) _then) = __$TypeScoreCopyWithImpl;
@override @useResult
$Res call({
 String name, double score, String? reason
});




}
/// @nodoc
class __$TypeScoreCopyWithImpl<$Res>
    implements _$TypeScoreCopyWith<$Res> {
  __$TypeScoreCopyWithImpl(this._self, this._then);

  final _TypeScore _self;
  final $Res Function(_TypeScore) _then;

/// Create a copy of TypeScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? score = null,Object? reason = freezed,}) {
  return _then(_TypeScore(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PinGrades {

 Grade? get quiet; Grade? get evening;
/// Create a copy of PinGrades
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinGradesCopyWith<PinGrades> get copyWith => _$PinGradesCopyWithImpl<PinGrades>(this as PinGrades, _$identity);

  /// Serializes this PinGrades to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PinGrades;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinGrades&&(identical(other.quiet, _this.quiet) || other.quiet == _this.quiet)&&(identical(other.evening, _this.evening) || other.evening == _this.evening));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PinGrades;
  return Object.hash(runtimeType,_this.quiet,_this.evening);
}

@override
String toString() {
  final _this = this as PinGrades;
  return 'PinGrades(quiet: ${_this.quiet}, evening: ${_this.evening})';
}


}

/// @nodoc
abstract mixin class $PinGradesCopyWith<$Res>  {
  factory $PinGradesCopyWith(PinGrades value, $Res Function(PinGrades) _then) = _$PinGradesCopyWithImpl;
@useResult
$Res call({
 Grade? quiet, Grade? evening
});




}
/// @nodoc
class _$PinGradesCopyWithImpl<$Res>
    implements $PinGradesCopyWith<$Res> {
  _$PinGradesCopyWithImpl(this._self, this._then);

  final PinGrades _self;
  final $Res Function(PinGrades) _then;

/// Create a copy of PinGrades
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quiet = freezed,Object? evening = freezed,}) {
  return _then(PinGrades(
quiet: freezed == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as Grade?,evening: freezed == evening ? _self.evening : evening // ignore: cast_nullable_to_non_nullable
as Grade?,
  ));
}

}


/// Adds pattern-matching-related methods to [PinGrades].
extension PinGradesPatterns on PinGrades {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinGrades value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinGrades() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinGrades value)  $default,){
final _that = this;
switch (_that) {
case _PinGrades():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinGrades value)?  $default,){
final _that = this;
switch (_that) {
case _PinGrades() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Grade? quiet,  Grade? evening)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinGrades() when $default != null:
return $default(_that.quiet,_that.evening);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Grade? quiet,  Grade? evening)  $default,) {final _that = this;
switch (_that) {
case _PinGrades():
return $default(_that.quiet,_that.evening);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Grade? quiet,  Grade? evening)?  $default,) {final _that = this;
switch (_that) {
case _PinGrades() when $default != null:
return $default(_that.quiet,_that.evening);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinGrades implements PinGrades {
  const _PinGrades({this.quiet, this.evening});
  factory _PinGrades.fromJson(Map<String, dynamic> json) => _$PinGradesFromJson(json);

@override final  Grade? quiet;
@override final  Grade? evening;

/// Create a copy of PinGrades
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinGradesCopyWith<_PinGrades> get copyWith => __$PinGradesCopyWithImpl<_PinGrades>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinGradesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinGrades&&(identical(other.quiet, quiet) || other.quiet == quiet)&&(identical(other.evening, evening) || other.evening == evening));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quiet,evening);
}

@override
String toString() {
    return 'PinGrades(quiet: $quiet, evening: $evening)';
}


}

/// @nodoc
abstract mixin class _$PinGradesCopyWith<$Res> implements $PinGradesCopyWith<$Res> {
  factory _$PinGradesCopyWith(_PinGrades value, $Res Function(_PinGrades) _then) = __$PinGradesCopyWithImpl;
@override @useResult
$Res call({
 Grade? quiet, Grade? evening
});




}
/// @nodoc
class __$PinGradesCopyWithImpl<$Res>
    implements _$PinGradesCopyWith<$Res> {
  __$PinGradesCopyWithImpl(this._self, this._then);

  final _PinGrades _self;
  final $Res Function(_PinGrades) _then;

/// Create a copy of PinGrades
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quiet = freezed,Object? evening = freezed,}) {
  return _then(_PinGrades(
quiet: freezed == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as Grade?,evening: freezed == evening ? _self.evening : evening // ignore: cast_nullable_to_non_nullable
as Grade?,
  ));
}


}


/// @nodoc
mixin _$PinDong {

 String get id; String get name; GeoPoint? get center;/// 관광공사 동 태그 id, 백엔드 순서. 핀 아이콘은 맨 앞 것을 씁니다.
 List<String> get tags; String? get topType; double? get topScore; bool get coastal;/// `생활권` 또는 `관광지`
 String? get life; PinGrades get grades;/// 유형 4종 점수(점수 높은 순). 백엔드 요청 중(workation-backend #16)이라 없을 수 있습니다.
 List<TypeScore>? get types;
/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinDongCopyWith<PinDong> get copyWith => _$PinDongCopyWithImpl<PinDong>(this as PinDong, _$identity);

  /// Serializes this PinDong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PinDong;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinDong&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.center, _this.center) || other.center == _this.center)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.topType, _this.topType) || other.topType == _this.topType)&&(identical(other.topScore, _this.topScore) || other.topScore == _this.topScore)&&(identical(other.coastal, _this.coastal) || other.coastal == _this.coastal)&&(identical(other.life, _this.life) || other.life == _this.life)&&(identical(other.grades, _this.grades) || other.grades == _this.grades)&&const DeepCollectionEquality().equals(other.types, _this.types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PinDong;
  return Object.hash(runtimeType,_this.id,_this.name,_this.center,const DeepCollectionEquality().hash(_this.tags),_this.topType,_this.topScore,_this.coastal,_this.life,_this.grades,const DeepCollectionEquality().hash(_this.types));
}

@override
String toString() {
  final _this = this as PinDong;
  return 'PinDong(id: ${_this.id}, name: ${_this.name}, center: ${_this.center}, tags: ${_this.tags}, topType: ${_this.topType}, topScore: ${_this.topScore}, coastal: ${_this.coastal}, life: ${_this.life}, grades: ${_this.grades}, types: ${_this.types})';
}


}

/// @nodoc
abstract mixin class $PinDongCopyWith<$Res>  {
  factory $PinDongCopyWith(PinDong value, $Res Function(PinDong) _then) = _$PinDongCopyWithImpl;
@useResult
$Res call({
 String id, String name, GeoPoint? center, List<String> tags, String? topType, double? topScore, bool coastal, String? life, PinGrades grades, List<TypeScore>? types
});


$GeoPointCopyWith<$Res>? get center;$PinGradesCopyWith<$Res> get grades;

}
/// @nodoc
class _$PinDongCopyWithImpl<$Res>
    implements $PinDongCopyWith<$Res> {
  _$PinDongCopyWithImpl(this._self, this._then);

  final PinDong _self;
  final $Res Function(PinDong) _then;

/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? center = freezed,Object? tags = null,Object? topType = freezed,Object? topScore = freezed,Object? coastal = null,Object? life = freezed,Object? grades = null,Object? types = freezed,}) {
  return _then(PinDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,center: freezed == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GeoPoint?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,topType: freezed == topType ? _self.topType : topType // ignore: cast_nullable_to_non_nullable
as String?,topScore: freezed == topScore ? _self.topScore : topScore // ignore: cast_nullable_to_non_nullable
as double?,coastal: null == coastal ? _self.coastal : coastal // ignore: cast_nullable_to_non_nullable
as bool,life: freezed == life ? _self.life : life // ignore: cast_nullable_to_non_nullable
as String?,grades: null == grades ? _self.grades : grades // ignore: cast_nullable_to_non_nullable
as PinGrades,types: freezed == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<TypeScore>?,
  ));
}
/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get center {
    if (_self.center == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.center!, (value) {
    return _then(_self.copyWith(center: value));
  });
}/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PinGradesCopyWith<$Res> get grades {
  
  return $PinGradesCopyWith<$Res>(_self.grades, (value) {
    return _then(_self.copyWith(grades: value));
  });
}
}


/// Adds pattern-matching-related methods to [PinDong].
extension PinDongPatterns on PinDong {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinDong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinDong() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinDong value)  $default,){
final _that = this;
switch (_that) {
case _PinDong():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinDong value)?  $default,){
final _that = this;
switch (_that) {
case _PinDong() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint? center,  List<String> tags,  String? topType,  double? topScore,  bool coastal,  String? life,  PinGrades grades,  List<TypeScore>? types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinDong() when $default != null:
return $default(_that.id,_that.name,_that.center,_that.tags,_that.topType,_that.topScore,_that.coastal,_that.life,_that.grades,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  GeoPoint? center,  List<String> tags,  String? topType,  double? topScore,  bool coastal,  String? life,  PinGrades grades,  List<TypeScore>? types)  $default,) {final _that = this;
switch (_that) {
case _PinDong():
return $default(_that.id,_that.name,_that.center,_that.tags,_that.topType,_that.topScore,_that.coastal,_that.life,_that.grades,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  GeoPoint? center,  List<String> tags,  String? topType,  double? topScore,  bool coastal,  String? life,  PinGrades grades,  List<TypeScore>? types)?  $default,) {final _that = this;
switch (_that) {
case _PinDong() when $default != null:
return $default(_that.id,_that.name,_that.center,_that.tags,_that.topType,_that.topScore,_that.coastal,_that.life,_that.grades,_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinDong extends PinDong {
  const _PinDong({required this.id, required this.name, this.center,  List<String> tags = const <String>[], this.topType, this.topScore, this.coastal = false, this.life, this.grades = const PinGrades(),  List<TypeScore>? types}): _tags = tags,_types = types,super._();
  factory _PinDong.fromJson(Map<String, dynamic> json) => _$PinDongFromJson(json);

@override final  String id;
@override final  String name;
@override final  GeoPoint? center;
/// 관광공사 동 태그 id, 백엔드 순서. 핀 아이콘은 맨 앞 것을 씁니다.
 final  List<String> _tags;
/// 관광공사 동 태그 id, 백엔드 순서. 핀 아이콘은 맨 앞 것을 씁니다.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? topType;
@override final  double? topScore;
@override@JsonKey() final  bool coastal;
/// `생활권` 또는 `관광지`
@override final  String? life;
@override@JsonKey() final  PinGrades grades;
/// 유형 4종 점수(점수 높은 순). 백엔드 요청 중(workation-backend #16)이라 없을 수 있습니다.
 final  List<TypeScore>? _types;
/// 유형 4종 점수(점수 높은 순). 백엔드 요청 중(workation-backend #16)이라 없을 수 있습니다.
@override List<TypeScore>? get types {
  final value = _types;
  if (value == null) return null;
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinDongCopyWith<_PinDong> get copyWith => __$PinDongCopyWithImpl<_PinDong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinDongToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinDong&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.center, center) || other.center == center)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.topType, topType) || other.topType == topType)&&(identical(other.topScore, topScore) || other.topScore == topScore)&&(identical(other.coastal, coastal) || other.coastal == coastal)&&(identical(other.life, life) || other.life == life)&&(identical(other.grades, grades) || other.grades == grades)&&const DeepCollectionEquality().equals(other.types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,center,const DeepCollectionEquality().hash(_tags),topType,topScore,coastal,life,grades,const DeepCollectionEquality().hash(_types));
}

@override
String toString() {
    return 'PinDong(id: $id, name: $name, center: $center, tags: $tags, topType: $topType, topScore: $topScore, coastal: $coastal, life: $life, grades: $grades, types: $types)';
}


}

/// @nodoc
abstract mixin class _$PinDongCopyWith<$Res> implements $PinDongCopyWith<$Res> {
  factory _$PinDongCopyWith(_PinDong value, $Res Function(_PinDong) _then) = __$PinDongCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, GeoPoint? center, List<String> tags, String? topType, double? topScore, bool coastal, String? life, PinGrades grades, List<TypeScore>? types
});


@override $GeoPointCopyWith<$Res>? get center;@override $PinGradesCopyWith<$Res> get grades;

}
/// @nodoc
class __$PinDongCopyWithImpl<$Res>
    implements _$PinDongCopyWith<$Res> {
  __$PinDongCopyWithImpl(this._self, this._then);

  final _PinDong _self;
  final $Res Function(_PinDong) _then;

/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? center = freezed,Object? tags = null,Object? topType = freezed,Object? topScore = freezed,Object? coastal = null,Object? life = freezed,Object? grades = null,Object? types = freezed,}) {
  return _then(_PinDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,center: freezed == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GeoPoint?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,topType: freezed == topType ? _self.topType : topType // ignore: cast_nullable_to_non_nullable
as String?,topScore: freezed == topScore ? _self.topScore : topScore // ignore: cast_nullable_to_non_nullable
as double?,coastal: null == coastal ? _self.coastal : coastal // ignore: cast_nullable_to_non_nullable
as bool,life: freezed == life ? _self.life : life // ignore: cast_nullable_to_non_nullable
as String?,grades: null == grades ? _self.grades : grades // ignore: cast_nullable_to_non_nullable
as PinGrades,types: freezed == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<TypeScore>?,
  ));
}

/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res>? get center {
    if (_self.center == null) {
    return null;
  }

  return $GeoPointCopyWith<$Res>(_self.center!, (value) {
    return _then(_self.copyWith(center: value));
  });
}/// Create a copy of PinDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PinGradesCopyWith<$Res> get grades {
  
  return $PinGradesCopyWith<$Res>(_self.grades, (value) {
    return _then(_self.copyWith(grades: value));
  });
}
}


/// @nodoc
mixin _$PinsResponse {

 String get sigunguId; List<PinDong> get dongs;
/// Create a copy of PinsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinsResponseCopyWith<PinsResponse> get copyWith => _$PinsResponseCopyWithImpl<PinsResponse>(this as PinsResponse, _$identity);

  /// Serializes this PinsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PinsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinsResponse&&(identical(other.sigunguId, _this.sigunguId) || other.sigunguId == _this.sigunguId)&&const DeepCollectionEquality().equals(other.dongs, _this.dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PinsResponse;
  return Object.hash(runtimeType,_this.sigunguId,const DeepCollectionEquality().hash(_this.dongs));
}

@override
String toString() {
  final _this = this as PinsResponse;
  return 'PinsResponse(sigunguId: ${_this.sigunguId}, dongs: ${_this.dongs})';
}


}

/// @nodoc
abstract mixin class $PinsResponseCopyWith<$Res>  {
  factory $PinsResponseCopyWith(PinsResponse value, $Res Function(PinsResponse) _then) = _$PinsResponseCopyWithImpl;
@useResult
$Res call({
 String sigunguId, List<PinDong> dongs
});




}
/// @nodoc
class _$PinsResponseCopyWithImpl<$Res>
    implements $PinsResponseCopyWith<$Res> {
  _$PinsResponseCopyWithImpl(this._self, this._then);

  final PinsResponse _self;
  final $Res Function(PinsResponse) _then;

/// Create a copy of PinsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sigunguId = null,Object? dongs = null,}) {
  return _then(PinsResponse(
sigunguId: null == sigunguId ? _self.sigunguId : sigunguId // ignore: cast_nullable_to_non_nullable
as String,dongs: null == dongs ? _self.dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<PinDong>,
  ));
}

}


/// Adds pattern-matching-related methods to [PinsResponse].
extension PinsResponsePatterns on PinsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PinsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PinsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sigunguId,  List<PinDong> dongs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinsResponse() when $default != null:
return $default(_that.sigunguId,_that.dongs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sigunguId,  List<PinDong> dongs)  $default,) {final _that = this;
switch (_that) {
case _PinsResponse():
return $default(_that.sigunguId,_that.dongs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sigunguId,  List<PinDong> dongs)?  $default,) {final _that = this;
switch (_that) {
case _PinsResponse() when $default != null:
return $default(_that.sigunguId,_that.dongs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinsResponse implements PinsResponse {
  const _PinsResponse({required this.sigunguId, required  List<PinDong> dongs}): _dongs = dongs;
  factory _PinsResponse.fromJson(Map<String, dynamic> json) => _$PinsResponseFromJson(json);

@override final  String sigunguId;
 final  List<PinDong> _dongs;
@override List<PinDong> get dongs {
  if (_dongs is EqualUnmodifiableListView) return _dongs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dongs);
}


/// Create a copy of PinsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinsResponseCopyWith<_PinsResponse> get copyWith => __$PinsResponseCopyWithImpl<_PinsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinsResponse&&(identical(other.sigunguId, sigunguId) || other.sigunguId == sigunguId)&&const DeepCollectionEquality().equals(other.dongs, _dongs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sigunguId,const DeepCollectionEquality().hash(_dongs));
}

@override
String toString() {
    return 'PinsResponse(sigunguId: $sigunguId, dongs: $dongs)';
}


}

/// @nodoc
abstract mixin class _$PinsResponseCopyWith<$Res> implements $PinsResponseCopyWith<$Res> {
  factory _$PinsResponseCopyWith(_PinsResponse value, $Res Function(_PinsResponse) _then) = __$PinsResponseCopyWithImpl;
@override @useResult
$Res call({
 String sigunguId, List<PinDong> dongs
});




}
/// @nodoc
class __$PinsResponseCopyWithImpl<$Res>
    implements _$PinsResponseCopyWith<$Res> {
  __$PinsResponseCopyWithImpl(this._self, this._then);

  final _PinsResponse _self;
  final $Res Function(_PinsResponse) _then;

/// Create a copy of PinsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sigunguId = null,Object? dongs = null,}) {
  return _then(_PinsResponse(
sigunguId: null == sigunguId ? _self.sigunguId : sigunguId // ignore: cast_nullable_to_non_nullable
as String,dongs: null == dongs ? _self._dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<PinDong>,
  ));
}


}


/// @nodoc
mixin _$SigunguRef {

 String get id; String get name;
/// Create a copy of SigunguRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigunguRefCopyWith<SigunguRef> get copyWith => _$SigunguRefCopyWithImpl<SigunguRef>(this as SigunguRef, _$identity);

  /// Serializes this SigunguRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SigunguRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigunguRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SigunguRef;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as SigunguRef;
  return 'SigunguRef(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $SigunguRefCopyWith<$Res>  {
  factory $SigunguRefCopyWith(SigunguRef value, $Res Function(SigunguRef) _then) = _$SigunguRefCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$SigunguRefCopyWithImpl<$Res>
    implements $SigunguRefCopyWith<$Res> {
  _$SigunguRefCopyWithImpl(this._self, this._then);

  final SigunguRef _self;
  final $Res Function(SigunguRef) _then;

/// Create a copy of SigunguRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(SigunguRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SigunguRef].
extension SigunguRefPatterns on SigunguRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SigunguRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SigunguRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SigunguRef value)  $default,){
final _that = this;
switch (_that) {
case _SigunguRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SigunguRef value)?  $default,){
final _that = this;
switch (_that) {
case _SigunguRef() when $default != null:
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
case _SigunguRef() when $default != null:
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
case _SigunguRef():
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
case _SigunguRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SigunguRef implements SigunguRef {
  const _SigunguRef({required this.id, required this.name});
  factory _SigunguRef.fromJson(Map<String, dynamic> json) => _$SigunguRefFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of SigunguRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SigunguRefCopyWith<_SigunguRef> get copyWith => __$SigunguRefCopyWithImpl<_SigunguRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SigunguRefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SigunguRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'SigunguRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SigunguRefCopyWith<$Res> implements $SigunguRefCopyWith<$Res> {
  factory _$SigunguRefCopyWith(_SigunguRef value, $Res Function(_SigunguRef) _then) = __$SigunguRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$SigunguRefCopyWithImpl<$Res>
    implements _$SigunguRefCopyWith<$Res> {
  __$SigunguRefCopyWithImpl(this._self, this._then);

  final _SigunguRef _self;
  final $Res Function(_SigunguRef) _then;

/// Create a copy of SigunguRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_SigunguRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExploreDong {

 String get id; String get name; SigunguRef get sigungu; String get sido; double? get coastKm;/// 4개, 점수 높은 순
 List<TypeScore> get types;/// 0개 또는 3개
 List<String> get briefing;
/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreDongCopyWith<ExploreDong> get copyWith => _$ExploreDongCopyWithImpl<ExploreDong>(this as ExploreDong, _$identity);

  /// Serializes this ExploreDong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExploreDong;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreDong&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sigungu, _this.sigungu) || other.sigungu == _this.sigungu)&&(identical(other.sido, _this.sido) || other.sido == _this.sido)&&(identical(other.coastKm, _this.coastKm) || other.coastKm == _this.coastKm)&&const DeepCollectionEquality().equals(other.types, _this.types)&&const DeepCollectionEquality().equals(other.briefing, _this.briefing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExploreDong;
  return Object.hash(runtimeType,_this.id,_this.name,_this.sigungu,_this.sido,_this.coastKm,const DeepCollectionEquality().hash(_this.types),const DeepCollectionEquality().hash(_this.briefing));
}

@override
String toString() {
  final _this = this as ExploreDong;
  return 'ExploreDong(id: ${_this.id}, name: ${_this.name}, sigungu: ${_this.sigungu}, sido: ${_this.sido}, coastKm: ${_this.coastKm}, types: ${_this.types}, briefing: ${_this.briefing})';
}


}

/// @nodoc
abstract mixin class $ExploreDongCopyWith<$Res>  {
  factory $ExploreDongCopyWith(ExploreDong value, $Res Function(ExploreDong) _then) = _$ExploreDongCopyWithImpl;
@useResult
$Res call({
 String id, String name, SigunguRef sigungu, String sido, double? coastKm, List<TypeScore> types, List<String> briefing
});


$SigunguRefCopyWith<$Res> get sigungu;

}
/// @nodoc
class _$ExploreDongCopyWithImpl<$Res>
    implements $ExploreDongCopyWith<$Res> {
  _$ExploreDongCopyWithImpl(this._self, this._then);

  final ExploreDong _self;
  final $Res Function(ExploreDong) _then;

/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sigungu = null,Object? sido = null,Object? coastKm = freezed,Object? types = null,Object? briefing = null,}) {
  return _then(ExploreDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as SigunguRef,sido: null == sido ? _self.sido : sido // ignore: cast_nullable_to_non_nullable
as String,coastKm: freezed == coastKm ? _self.coastKm : coastKm // ignore: cast_nullable_to_non_nullable
as double?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<TypeScore>,briefing: null == briefing ? _self.briefing : briefing // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SigunguRefCopyWith<$Res> get sigungu {
  
  return $SigunguRefCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreDong].
extension ExploreDongPatterns on ExploreDong {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreDong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreDong() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreDong value)  $default,){
final _that = this;
switch (_that) {
case _ExploreDong():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreDong value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreDong() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SigunguRef sigungu,  String sido,  double? coastKm,  List<TypeScore> types,  List<String> briefing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreDong() when $default != null:
return $default(_that.id,_that.name,_that.sigungu,_that.sido,_that.coastKm,_that.types,_that.briefing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SigunguRef sigungu,  String sido,  double? coastKm,  List<TypeScore> types,  List<String> briefing)  $default,) {final _that = this;
switch (_that) {
case _ExploreDong():
return $default(_that.id,_that.name,_that.sigungu,_that.sido,_that.coastKm,_that.types,_that.briefing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SigunguRef sigungu,  String sido,  double? coastKm,  List<TypeScore> types,  List<String> briefing)?  $default,) {final _that = this;
switch (_that) {
case _ExploreDong() when $default != null:
return $default(_that.id,_that.name,_that.sigungu,_that.sido,_that.coastKm,_that.types,_that.briefing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreDong implements ExploreDong {
  const _ExploreDong({required this.id, required this.name, required this.sigungu, required this.sido, this.coastKm,  List<TypeScore> types = const <TypeScore>[],  List<String> briefing = const <String>[]}): _types = types,_briefing = briefing;
  factory _ExploreDong.fromJson(Map<String, dynamic> json) => _$ExploreDongFromJson(json);

@override final  String id;
@override final  String name;
@override final  SigunguRef sigungu;
@override final  String sido;
@override final  double? coastKm;
/// 4개, 점수 높은 순
 final  List<TypeScore> _types;
/// 4개, 점수 높은 순
@override@JsonKey() List<TypeScore> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

/// 0개 또는 3개
 final  List<String> _briefing;
/// 0개 또는 3개
@override@JsonKey() List<String> get briefing {
  if (_briefing is EqualUnmodifiableListView) return _briefing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_briefing);
}


/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreDongCopyWith<_ExploreDong> get copyWith => __$ExploreDongCopyWithImpl<_ExploreDong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreDongToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreDong&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sigungu, sigungu) || other.sigungu == sigungu)&&(identical(other.sido, sido) || other.sido == sido)&&(identical(other.coastKm, coastKm) || other.coastKm == coastKm)&&const DeepCollectionEquality().equals(other.types, _types)&&const DeepCollectionEquality().equals(other.briefing, _briefing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,sigungu,sido,coastKm,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_briefing));
}

@override
String toString() {
    return 'ExploreDong(id: $id, name: $name, sigungu: $sigungu, sido: $sido, coastKm: $coastKm, types: $types, briefing: $briefing)';
}


}

/// @nodoc
abstract mixin class _$ExploreDongCopyWith<$Res> implements $ExploreDongCopyWith<$Res> {
  factory _$ExploreDongCopyWith(_ExploreDong value, $Res Function(_ExploreDong) _then) = __$ExploreDongCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SigunguRef sigungu, String sido, double? coastKm, List<TypeScore> types, List<String> briefing
});


@override $SigunguRefCopyWith<$Res> get sigungu;

}
/// @nodoc
class __$ExploreDongCopyWithImpl<$Res>
    implements _$ExploreDongCopyWith<$Res> {
  __$ExploreDongCopyWithImpl(this._self, this._then);

  final _ExploreDong _self;
  final $Res Function(_ExploreDong) _then;

/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sigungu = null,Object? sido = null,Object? coastKm = freezed,Object? types = null,Object? briefing = null,}) {
  return _then(_ExploreDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as SigunguRef,sido: null == sido ? _self.sido : sido // ignore: cast_nullable_to_non_nullable
as String,coastKm: freezed == coastKm ? _self.coastKm : coastKm // ignore: cast_nullable_to_non_nullable
as double?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<TypeScore>,briefing: null == briefing ? _self._briefing : briefing // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ExploreDong
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SigunguRefCopyWith<$Res> get sigungu {
  
  return $SigunguRefCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}
}

// dart format on
