// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionPhoto {

 String get url; String? get credit;
/// Create a copy of RegionPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionPhotoCopyWith<RegionPhoto> get copyWith => _$RegionPhotoCopyWithImpl<RegionPhoto>(this as RegionPhoto, _$identity);

  /// Serializes this RegionPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegionPhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionPhoto&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.credit, _this.credit) || other.credit == _this.credit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegionPhoto;
  return Object.hash(runtimeType,_this.url,_this.credit);
}

@override
String toString() {
  final _this = this as RegionPhoto;
  return 'RegionPhoto(url: ${_this.url}, credit: ${_this.credit})';
}


}

/// @nodoc
abstract mixin class $RegionPhotoCopyWith<$Res>  {
  factory $RegionPhotoCopyWith(RegionPhoto value, $Res Function(RegionPhoto) _then) = _$RegionPhotoCopyWithImpl;
@useResult
$Res call({
 String url, String? credit
});




}
/// @nodoc
class _$RegionPhotoCopyWithImpl<$Res>
    implements $RegionPhotoCopyWith<$Res> {
  _$RegionPhotoCopyWithImpl(this._self, this._then);

  final RegionPhoto _self;
  final $Res Function(RegionPhoto) _then;

/// Create a copy of RegionPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? credit = freezed,}) {
  return _then(RegionPhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionPhoto].
extension RegionPhotoPatterns on RegionPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionPhoto value)  $default,){
final _that = this;
switch (_that) {
case _RegionPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _RegionPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? credit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionPhoto() when $default != null:
return $default(_that.url,_that.credit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? credit)  $default,) {final _that = this;
switch (_that) {
case _RegionPhoto():
return $default(_that.url,_that.credit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? credit)?  $default,) {final _that = this;
switch (_that) {
case _RegionPhoto() when $default != null:
return $default(_that.url,_that.credit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionPhoto implements RegionPhoto {
  const _RegionPhoto({required this.url, this.credit});
  factory _RegionPhoto.fromJson(Map<String, dynamic> json) => _$RegionPhotoFromJson(json);

@override final  String url;
@override final  String? credit;

/// Create a copy of RegionPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionPhotoCopyWith<_RegionPhoto> get copyWith => __$RegionPhotoCopyWithImpl<_RegionPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionPhoto&&(identical(other.url, url) || other.url == url)&&(identical(other.credit, credit) || other.credit == credit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,credit);
}

@override
String toString() {
    return 'RegionPhoto(url: $url, credit: $credit)';
}


}

/// @nodoc
abstract mixin class _$RegionPhotoCopyWith<$Res> implements $RegionPhotoCopyWith<$Res> {
  factory _$RegionPhotoCopyWith(_RegionPhoto value, $Res Function(_RegionPhoto) _then) = __$RegionPhotoCopyWithImpl;
@override @useResult
$Res call({
 String url, String? credit
});




}
/// @nodoc
class __$RegionPhotoCopyWithImpl<$Res>
    implements _$RegionPhotoCopyWith<$Res> {
  __$RegionPhotoCopyWithImpl(this._self, this._then);

  final _RegionPhoto _self;
  final $Res Function(_RegionPhoto) _then;

/// Create a copy of RegionPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? credit = freezed,}) {
  return _then(_RegionPhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RegionStats {

/// 해당 월 방문 ÷ 연중 최대 × 100 (연간이면 평균)
 int get crowdIndex;/// 평일 낮 체류 ÷ 새벽 체류
 double get dayInflow;/// 낮 유입 지수 오름차순 순위(시군구 중)
 int get quietRank;/// 20~40대 방문 비율 %
 int get peerShare;/// 숙박 계수
 double get overnightCoef;/// 주말 낮 체류 ÷ 주중 낮 체류
 double get weekendRatio;
/// Create a copy of RegionStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionStatsCopyWith<RegionStats> get copyWith => _$RegionStatsCopyWithImpl<RegionStats>(this as RegionStats, _$identity);

  /// Serializes this RegionStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegionStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionStats&&(identical(other.crowdIndex, _this.crowdIndex) || other.crowdIndex == _this.crowdIndex)&&(identical(other.dayInflow, _this.dayInflow) || other.dayInflow == _this.dayInflow)&&(identical(other.quietRank, _this.quietRank) || other.quietRank == _this.quietRank)&&(identical(other.peerShare, _this.peerShare) || other.peerShare == _this.peerShare)&&(identical(other.overnightCoef, _this.overnightCoef) || other.overnightCoef == _this.overnightCoef)&&(identical(other.weekendRatio, _this.weekendRatio) || other.weekendRatio == _this.weekendRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegionStats;
  return Object.hash(runtimeType,_this.crowdIndex,_this.dayInflow,_this.quietRank,_this.peerShare,_this.overnightCoef,_this.weekendRatio);
}

@override
String toString() {
  final _this = this as RegionStats;
  return 'RegionStats(crowdIndex: ${_this.crowdIndex}, dayInflow: ${_this.dayInflow}, quietRank: ${_this.quietRank}, peerShare: ${_this.peerShare}, overnightCoef: ${_this.overnightCoef}, weekendRatio: ${_this.weekendRatio})';
}


}

/// @nodoc
abstract mixin class $RegionStatsCopyWith<$Res>  {
  factory $RegionStatsCopyWith(RegionStats value, $Res Function(RegionStats) _then) = _$RegionStatsCopyWithImpl;
@useResult
$Res call({
 int crowdIndex, double dayInflow, int quietRank, int peerShare, double overnightCoef, double weekendRatio
});




}
/// @nodoc
class _$RegionStatsCopyWithImpl<$Res>
    implements $RegionStatsCopyWith<$Res> {
  _$RegionStatsCopyWithImpl(this._self, this._then);

  final RegionStats _self;
  final $Res Function(RegionStats) _then;

/// Create a copy of RegionStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? crowdIndex = null,Object? dayInflow = null,Object? quietRank = null,Object? peerShare = null,Object? overnightCoef = null,Object? weekendRatio = null,}) {
  return _then(RegionStats(
crowdIndex: null == crowdIndex ? _self.crowdIndex : crowdIndex // ignore: cast_nullable_to_non_nullable
as int,dayInflow: null == dayInflow ? _self.dayInflow : dayInflow // ignore: cast_nullable_to_non_nullable
as double,quietRank: null == quietRank ? _self.quietRank : quietRank // ignore: cast_nullable_to_non_nullable
as int,peerShare: null == peerShare ? _self.peerShare : peerShare // ignore: cast_nullable_to_non_nullable
as int,overnightCoef: null == overnightCoef ? _self.overnightCoef : overnightCoef // ignore: cast_nullable_to_non_nullable
as double,weekendRatio: null == weekendRatio ? _self.weekendRatio : weekendRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionStats].
extension RegionStatsPatterns on RegionStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionStats value)  $default,){
final _that = this;
switch (_that) {
case _RegionStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionStats value)?  $default,){
final _that = this;
switch (_that) {
case _RegionStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int crowdIndex,  double dayInflow,  int quietRank,  int peerShare,  double overnightCoef,  double weekendRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionStats() when $default != null:
return $default(_that.crowdIndex,_that.dayInflow,_that.quietRank,_that.peerShare,_that.overnightCoef,_that.weekendRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int crowdIndex,  double dayInflow,  int quietRank,  int peerShare,  double overnightCoef,  double weekendRatio)  $default,) {final _that = this;
switch (_that) {
case _RegionStats():
return $default(_that.crowdIndex,_that.dayInflow,_that.quietRank,_that.peerShare,_that.overnightCoef,_that.weekendRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int crowdIndex,  double dayInflow,  int quietRank,  int peerShare,  double overnightCoef,  double weekendRatio)?  $default,) {final _that = this;
switch (_that) {
case _RegionStats() when $default != null:
return $default(_that.crowdIndex,_that.dayInflow,_that.quietRank,_that.peerShare,_that.overnightCoef,_that.weekendRatio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionStats implements RegionStats {
  const _RegionStats({required this.crowdIndex, required this.dayInflow, required this.quietRank, required this.peerShare, required this.overnightCoef, required this.weekendRatio});
  factory _RegionStats.fromJson(Map<String, dynamic> json) => _$RegionStatsFromJson(json);

/// 해당 월 방문 ÷ 연중 최대 × 100 (연간이면 평균)
@override final  int crowdIndex;
/// 평일 낮 체류 ÷ 새벽 체류
@override final  double dayInflow;
/// 낮 유입 지수 오름차순 순위(시군구 중)
@override final  int quietRank;
/// 20~40대 방문 비율 %
@override final  int peerShare;
/// 숙박 계수
@override final  double overnightCoef;
/// 주말 낮 체류 ÷ 주중 낮 체류
@override final  double weekendRatio;

/// Create a copy of RegionStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionStatsCopyWith<_RegionStats> get copyWith => __$RegionStatsCopyWithImpl<_RegionStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionStats&&(identical(other.crowdIndex, crowdIndex) || other.crowdIndex == crowdIndex)&&(identical(other.dayInflow, dayInflow) || other.dayInflow == dayInflow)&&(identical(other.quietRank, quietRank) || other.quietRank == quietRank)&&(identical(other.peerShare, peerShare) || other.peerShare == peerShare)&&(identical(other.overnightCoef, overnightCoef) || other.overnightCoef == overnightCoef)&&(identical(other.weekendRatio, weekendRatio) || other.weekendRatio == weekendRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,crowdIndex,dayInflow,quietRank,peerShare,overnightCoef,weekendRatio);
}

@override
String toString() {
    return 'RegionStats(crowdIndex: $crowdIndex, dayInflow: $dayInflow, quietRank: $quietRank, peerShare: $peerShare, overnightCoef: $overnightCoef, weekendRatio: $weekendRatio)';
}


}

/// @nodoc
abstract mixin class _$RegionStatsCopyWith<$Res> implements $RegionStatsCopyWith<$Res> {
  factory _$RegionStatsCopyWith(_RegionStats value, $Res Function(_RegionStats) _then) = __$RegionStatsCopyWithImpl;
@override @useResult
$Res call({
 int crowdIndex, double dayInflow, int quietRank, int peerShare, double overnightCoef, double weekendRatio
});




}
/// @nodoc
class __$RegionStatsCopyWithImpl<$Res>
    implements _$RegionStatsCopyWith<$Res> {
  __$RegionStatsCopyWithImpl(this._self, this._then);

  final _RegionStats _self;
  final $Res Function(_RegionStats) _then;

/// Create a copy of RegionStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? crowdIndex = null,Object? dayInflow = null,Object? quietRank = null,Object? peerShare = null,Object? overnightCoef = null,Object? weekendRatio = null,}) {
  return _then(_RegionStats(
crowdIndex: null == crowdIndex ? _self.crowdIndex : crowdIndex // ignore: cast_nullable_to_non_nullable
as int,dayInflow: null == dayInflow ? _self.dayInflow : dayInflow // ignore: cast_nullable_to_non_nullable
as double,quietRank: null == quietRank ? _self.quietRank : quietRank // ignore: cast_nullable_to_non_nullable
as int,peerShare: null == peerShare ? _self.peerShare : peerShare // ignore: cast_nullable_to_non_nullable
as int,overnightCoef: null == overnightCoef ? _self.overnightCoef : overnightCoef // ignore: cast_nullable_to_non_nullable
as double,weekendRatio: null == weekendRatio ? _self.weekendRatio : weekendRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MonthCrowd {

 int get month; int get crowd;
/// Create a copy of MonthCrowd
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthCrowdCopyWith<MonthCrowd> get copyWith => _$MonthCrowdCopyWithImpl<MonthCrowd>(this as MonthCrowd, _$identity);

  /// Serializes this MonthCrowd to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthCrowd;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthCrowd&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.crowd, _this.crowd) || other.crowd == _this.crowd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthCrowd;
  return Object.hash(runtimeType,_this.month,_this.crowd);
}

@override
String toString() {
  final _this = this as MonthCrowd;
  return 'MonthCrowd(month: ${_this.month}, crowd: ${_this.crowd})';
}


}

/// @nodoc
abstract mixin class $MonthCrowdCopyWith<$Res>  {
  factory $MonthCrowdCopyWith(MonthCrowd value, $Res Function(MonthCrowd) _then) = _$MonthCrowdCopyWithImpl;
@useResult
$Res call({
 int month, int crowd
});




}
/// @nodoc
class _$MonthCrowdCopyWithImpl<$Res>
    implements $MonthCrowdCopyWith<$Res> {
  _$MonthCrowdCopyWithImpl(this._self, this._then);

  final MonthCrowd _self;
  final $Res Function(MonthCrowd) _then;

/// Create a copy of MonthCrowd
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? crowd = null,}) {
  return _then(MonthCrowd(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,crowd: null == crowd ? _self.crowd : crowd // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthCrowd].
extension MonthCrowdPatterns on MonthCrowd {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthCrowd value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthCrowd() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthCrowd value)  $default,){
final _that = this;
switch (_that) {
case _MonthCrowd():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthCrowd value)?  $default,){
final _that = this;
switch (_that) {
case _MonthCrowd() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int month,  int crowd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthCrowd() when $default != null:
return $default(_that.month,_that.crowd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int month,  int crowd)  $default,) {final _that = this;
switch (_that) {
case _MonthCrowd():
return $default(_that.month,_that.crowd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int month,  int crowd)?  $default,) {final _that = this;
switch (_that) {
case _MonthCrowd() when $default != null:
return $default(_that.month,_that.crowd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthCrowd implements MonthCrowd {
  const _MonthCrowd({required this.month, required this.crowd});
  factory _MonthCrowd.fromJson(Map<String, dynamic> json) => _$MonthCrowdFromJson(json);

@override final  int month;
@override final  int crowd;

/// Create a copy of MonthCrowd
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthCrowdCopyWith<_MonthCrowd> get copyWith => __$MonthCrowdCopyWithImpl<_MonthCrowd>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthCrowdToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthCrowd&&(identical(other.month, month) || other.month == month)&&(identical(other.crowd, crowd) || other.crowd == crowd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,crowd);
}

@override
String toString() {
    return 'MonthCrowd(month: $month, crowd: $crowd)';
}


}

/// @nodoc
abstract mixin class _$MonthCrowdCopyWith<$Res> implements $MonthCrowdCopyWith<$Res> {
  factory _$MonthCrowdCopyWith(_MonthCrowd value, $Res Function(_MonthCrowd) _then) = __$MonthCrowdCopyWithImpl;
@override @useResult
$Res call({
 int month, int crowd
});




}
/// @nodoc
class __$MonthCrowdCopyWithImpl<$Res>
    implements _$MonthCrowdCopyWith<$Res> {
  __$MonthCrowdCopyWithImpl(this._self, this._then);

  final _MonthCrowd _self;
  final $Res Function(_MonthCrowd) _then;

/// Create a copy of MonthCrowd
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? crowd = null,}) {
  return _then(_MonthCrowd(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,crowd: null == crowd ? _self.crowd : crowd // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RegionDong {

/// 행정동 코드 10자리
 String get id; String get name; DongKind get kind;/// 예: `거진항`
 String get landmark;/// 전체 행정동 중 낮 유입 지수 백분위 0~100
 double get quietScore;/// 동 자체 혼잡이 가장 높은 달
 int get peakMonth;/// 고른 달 혼잡 ÷ 자체 최대 × 100
 int get crowdOfPeak;
/// Create a copy of RegionDong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionDongCopyWith<RegionDong> get copyWith => _$RegionDongCopyWithImpl<RegionDong>(this as RegionDong, _$identity);

  /// Serializes this RegionDong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegionDong;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionDong&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.landmark, _this.landmark) || other.landmark == _this.landmark)&&(identical(other.quietScore, _this.quietScore) || other.quietScore == _this.quietScore)&&(identical(other.peakMonth, _this.peakMonth) || other.peakMonth == _this.peakMonth)&&(identical(other.crowdOfPeak, _this.crowdOfPeak) || other.crowdOfPeak == _this.crowdOfPeak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegionDong;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.landmark,_this.quietScore,_this.peakMonth,_this.crowdOfPeak);
}

@override
String toString() {
  final _this = this as RegionDong;
  return 'RegionDong(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, landmark: ${_this.landmark}, quietScore: ${_this.quietScore}, peakMonth: ${_this.peakMonth}, crowdOfPeak: ${_this.crowdOfPeak})';
}


}

/// @nodoc
abstract mixin class $RegionDongCopyWith<$Res>  {
  factory $RegionDongCopyWith(RegionDong value, $Res Function(RegionDong) _then) = _$RegionDongCopyWithImpl;
@useResult
$Res call({
 String id, String name, DongKind kind, String landmark, double quietScore, int peakMonth, int crowdOfPeak
});




}
/// @nodoc
class _$RegionDongCopyWithImpl<$Res>
    implements $RegionDongCopyWith<$Res> {
  _$RegionDongCopyWithImpl(this._self, this._then);

  final RegionDong _self;
  final $Res Function(RegionDong) _then;

/// Create a copy of RegionDong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? landmark = null,Object? quietScore = null,Object? peakMonth = null,Object? crowdOfPeak = null,}) {
  return _then(RegionDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,quietScore: null == quietScore ? _self.quietScore : quietScore // ignore: cast_nullable_to_non_nullable
as double,peakMonth: null == peakMonth ? _self.peakMonth : peakMonth // ignore: cast_nullable_to_non_nullable
as int,crowdOfPeak: null == crowdOfPeak ? _self.crowdOfPeak : crowdOfPeak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionDong].
extension RegionDongPatterns on RegionDong {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionDong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionDong() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionDong value)  $default,){
final _that = this;
switch (_that) {
case _RegionDong():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionDong value)?  $default,){
final _that = this;
switch (_that) {
case _RegionDong() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DongKind kind,  String landmark,  double quietScore,  int peakMonth,  int crowdOfPeak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionDong() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.landmark,_that.quietScore,_that.peakMonth,_that.crowdOfPeak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DongKind kind,  String landmark,  double quietScore,  int peakMonth,  int crowdOfPeak)  $default,) {final _that = this;
switch (_that) {
case _RegionDong():
return $default(_that.id,_that.name,_that.kind,_that.landmark,_that.quietScore,_that.peakMonth,_that.crowdOfPeak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DongKind kind,  String landmark,  double quietScore,  int peakMonth,  int crowdOfPeak)?  $default,) {final _that = this;
switch (_that) {
case _RegionDong() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.landmark,_that.quietScore,_that.peakMonth,_that.crowdOfPeak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionDong implements RegionDong {
  const _RegionDong({required this.id, required this.name, required this.kind, required this.landmark, required this.quietScore, required this.peakMonth, required this.crowdOfPeak});
  factory _RegionDong.fromJson(Map<String, dynamic> json) => _$RegionDongFromJson(json);

/// 행정동 코드 10자리
@override final  String id;
@override final  String name;
@override final  DongKind kind;
/// 예: `거진항`
@override final  String landmark;
/// 전체 행정동 중 낮 유입 지수 백분위 0~100
@override final  double quietScore;
/// 동 자체 혼잡이 가장 높은 달
@override final  int peakMonth;
/// 고른 달 혼잡 ÷ 자체 최대 × 100
@override final  int crowdOfPeak;

/// Create a copy of RegionDong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionDongCopyWith<_RegionDong> get copyWith => __$RegionDongCopyWithImpl<_RegionDong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionDongToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionDong&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.quietScore, quietScore) || other.quietScore == quietScore)&&(identical(other.peakMonth, peakMonth) || other.peakMonth == peakMonth)&&(identical(other.crowdOfPeak, crowdOfPeak) || other.crowdOfPeak == crowdOfPeak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,landmark,quietScore,peakMonth,crowdOfPeak);
}

@override
String toString() {
    return 'RegionDong(id: $id, name: $name, kind: $kind, landmark: $landmark, quietScore: $quietScore, peakMonth: $peakMonth, crowdOfPeak: $crowdOfPeak)';
}


}

/// @nodoc
abstract mixin class _$RegionDongCopyWith<$Res> implements $RegionDongCopyWith<$Res> {
  factory _$RegionDongCopyWith(_RegionDong value, $Res Function(_RegionDong) _then) = __$RegionDongCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DongKind kind, String landmark, double quietScore, int peakMonth, int crowdOfPeak
});




}
/// @nodoc
class __$RegionDongCopyWithImpl<$Res>
    implements _$RegionDongCopyWith<$Res> {
  __$RegionDongCopyWithImpl(this._self, this._then);

  final _RegionDong _self;
  final $Res Function(_RegionDong) _then;

/// Create a copy of RegionDong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? landmark = null,Object? quietScore = null,Object? peakMonth = null,Object? crowdOfPeak = null,}) {
  return _then(_RegionDong(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,quietScore: null == quietScore ? _self.quietScore : quietScore // ignore: cast_nullable_to_non_nullable
as double,peakMonth: null == peakMonth ? _self.peakMonth : peakMonth // ignore: cast_nullable_to_non_nullable
as int,crowdOfPeak: null == crowdOfPeak ? _self.crowdOfPeak : crowdOfPeak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExcludedDong {

 String get name; String get reason;
/// Create a copy of ExcludedDong
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExcludedDongCopyWith<ExcludedDong> get copyWith => _$ExcludedDongCopyWithImpl<ExcludedDong>(this as ExcludedDong, _$identity);

  /// Serializes this ExcludedDong to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExcludedDong;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExcludedDong&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExcludedDong;
  return Object.hash(runtimeType,_this.name,_this.reason);
}

@override
String toString() {
  final _this = this as ExcludedDong;
  return 'ExcludedDong(name: ${_this.name}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $ExcludedDongCopyWith<$Res>  {
  factory $ExcludedDongCopyWith(ExcludedDong value, $Res Function(ExcludedDong) _then) = _$ExcludedDongCopyWithImpl;
@useResult
$Res call({
 String name, String reason
});




}
/// @nodoc
class _$ExcludedDongCopyWithImpl<$Res>
    implements $ExcludedDongCopyWith<$Res> {
  _$ExcludedDongCopyWithImpl(this._self, this._then);

  final ExcludedDong _self;
  final $Res Function(ExcludedDong) _then;

/// Create a copy of ExcludedDong
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? reason = null,}) {
  return _then(ExcludedDong(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExcludedDong].
extension ExcludedDongPatterns on ExcludedDong {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExcludedDong value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExcludedDong() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExcludedDong value)  $default,){
final _that = this;
switch (_that) {
case _ExcludedDong():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExcludedDong value)?  $default,){
final _that = this;
switch (_that) {
case _ExcludedDong() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExcludedDong() when $default != null:
return $default(_that.name,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String reason)  $default,) {final _that = this;
switch (_that) {
case _ExcludedDong():
return $default(_that.name,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _ExcludedDong() when $default != null:
return $default(_that.name,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExcludedDong implements ExcludedDong {
  const _ExcludedDong({required this.name, required this.reason});
  factory _ExcludedDong.fromJson(Map<String, dynamic> json) => _$ExcludedDongFromJson(json);

@override final  String name;
@override final  String reason;

/// Create a copy of ExcludedDong
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExcludedDongCopyWith<_ExcludedDong> get copyWith => __$ExcludedDongCopyWithImpl<_ExcludedDong>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExcludedDongToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExcludedDong&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,reason);
}

@override
String toString() {
    return 'ExcludedDong(name: $name, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ExcludedDongCopyWith<$Res> implements $ExcludedDongCopyWith<$Res> {
  factory _$ExcludedDongCopyWith(_ExcludedDong value, $Res Function(_ExcludedDong) _then) = __$ExcludedDongCopyWithImpl;
@override @useResult
$Res call({
 String name, String reason
});




}
/// @nodoc
class __$ExcludedDongCopyWithImpl<$Res>
    implements _$ExcludedDongCopyWith<$Res> {
  __$ExcludedDongCopyWithImpl(this._self, this._then);

  final _ExcludedDong _self;
  final $Res Function(_ExcludedDong) _then;

/// Create a copy of ExcludedDong
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? reason = null,}) {
  return _then(_ExcludedDong(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegionLink {

 String get kind; String get title; String get url;
/// Create a copy of RegionLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionLinkCopyWith<RegionLink> get copyWith => _$RegionLinkCopyWithImpl<RegionLink>(this as RegionLink, _$identity);

  /// Serializes this RegionLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegionLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionLink&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegionLink;
  return Object.hash(runtimeType,_this.kind,_this.title,_this.url);
}

@override
String toString() {
  final _this = this as RegionLink;
  return 'RegionLink(kind: ${_this.kind}, title: ${_this.title}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $RegionLinkCopyWith<$Res>  {
  factory $RegionLinkCopyWith(RegionLink value, $Res Function(RegionLink) _then) = _$RegionLinkCopyWithImpl;
@useResult
$Res call({
 String kind, String title, String url
});




}
/// @nodoc
class _$RegionLinkCopyWithImpl<$Res>
    implements $RegionLinkCopyWith<$Res> {
  _$RegionLinkCopyWithImpl(this._self, this._then);

  final RegionLink _self;
  final $Res Function(RegionLink) _then;

/// Create a copy of RegionLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? url = null,}) {
  return _then(RegionLink(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionLink].
extension RegionLinkPatterns on RegionLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionLink value)  $default,){
final _that = this;
switch (_that) {
case _RegionLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionLink value)?  $default,){
final _that = this;
switch (_that) {
case _RegionLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  String title,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionLink() when $default != null:
return $default(_that.kind,_that.title,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  String title,  String url)  $default,) {final _that = this;
switch (_that) {
case _RegionLink():
return $default(_that.kind,_that.title,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  String title,  String url)?  $default,) {final _that = this;
switch (_that) {
case _RegionLink() when $default != null:
return $default(_that.kind,_that.title,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionLink implements RegionLink {
  const _RegionLink({required this.kind, required this.title, required this.url});
  factory _RegionLink.fromJson(Map<String, dynamic> json) => _$RegionLinkFromJson(json);

@override final  String kind;
@override final  String title;
@override final  String url;

/// Create a copy of RegionLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionLinkCopyWith<_RegionLink> get copyWith => __$RegionLinkCopyWithImpl<_RegionLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionLinkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionLink&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,title,url);
}

@override
String toString() {
    return 'RegionLink(kind: $kind, title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class _$RegionLinkCopyWith<$Res> implements $RegionLinkCopyWith<$Res> {
  factory _$RegionLinkCopyWith(_RegionLink value, $Res Function(_RegionLink) _then) = __$RegionLinkCopyWithImpl;
@override @useResult
$Res call({
 String kind, String title, String url
});




}
/// @nodoc
class __$RegionLinkCopyWithImpl<$Res>
    implements _$RegionLinkCopyWith<$Res> {
  __$RegionLinkCopyWithImpl(this._self, this._then);

  final _RegionLink _self;
  final $Res Function(_RegionLink) _then;

/// Create a copy of RegionLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? url = null,}) {
  return _then(_RegionLink(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegionDetail {

 String get id; String get name; String get province; List<String> get tags; SeasonType get seasonType; List<RegionPhoto> get photos; String get month; RegionStats get stats;/// 1~12월
 List<MonthCrowd> get months;/// 혼잡이 가장 낮은 두 달
 List<int> get bestMonths;/// 혼잡이 가장 높은 두 달
 List<int> get avoidMonths;/// 또래 비중은 높고 혼잡은 낮은 두 달
 List<int> get peerOffpeakMonths; List<RegionDong> get dongs; List<ExcludedDong> get excludedDongs; List<RegionLink> get links;
/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionDetailCopyWith<RegionDetail> get copyWith => _$RegionDetailCopyWithImpl<RegionDetail>(this as RegionDetail, _$identity);

  /// Serializes this RegionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegionDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.province, _this.province) || other.province == _this.province)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.seasonType, _this.seasonType) || other.seasonType == _this.seasonType)&&const DeepCollectionEquality().equals(other.photos, _this.photos)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.stats, _this.stats) || other.stats == _this.stats)&&const DeepCollectionEquality().equals(other.months, _this.months)&&const DeepCollectionEquality().equals(other.bestMonths, _this.bestMonths)&&const DeepCollectionEquality().equals(other.avoidMonths, _this.avoidMonths)&&const DeepCollectionEquality().equals(other.peerOffpeakMonths, _this.peerOffpeakMonths)&&const DeepCollectionEquality().equals(other.dongs, _this.dongs)&&const DeepCollectionEquality().equals(other.excludedDongs, _this.excludedDongs)&&const DeepCollectionEquality().equals(other.links, _this.links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegionDetail;
  return Object.hash(runtimeType,_this.id,_this.name,_this.province,const DeepCollectionEquality().hash(_this.tags),_this.seasonType,const DeepCollectionEquality().hash(_this.photos),_this.month,_this.stats,const DeepCollectionEquality().hash(_this.months),const DeepCollectionEquality().hash(_this.bestMonths),const DeepCollectionEquality().hash(_this.avoidMonths),const DeepCollectionEquality().hash(_this.peerOffpeakMonths),const DeepCollectionEquality().hash(_this.dongs),const DeepCollectionEquality().hash(_this.excludedDongs),const DeepCollectionEquality().hash(_this.links));
}

@override
String toString() {
  final _this = this as RegionDetail;
  return 'RegionDetail(id: ${_this.id}, name: ${_this.name}, province: ${_this.province}, tags: ${_this.tags}, seasonType: ${_this.seasonType}, photos: ${_this.photos}, month: ${_this.month}, stats: ${_this.stats}, months: ${_this.months}, bestMonths: ${_this.bestMonths}, avoidMonths: ${_this.avoidMonths}, peerOffpeakMonths: ${_this.peerOffpeakMonths}, dongs: ${_this.dongs}, excludedDongs: ${_this.excludedDongs}, links: ${_this.links})';
}


}

/// @nodoc
abstract mixin class $RegionDetailCopyWith<$Res>  {
  factory $RegionDetailCopyWith(RegionDetail value, $Res Function(RegionDetail) _then) = _$RegionDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String province, List<String> tags, SeasonType seasonType, List<RegionPhoto> photos, String month, RegionStats stats, List<MonthCrowd> months, List<int> bestMonths, List<int> avoidMonths, List<int> peerOffpeakMonths, List<RegionDong> dongs, List<ExcludedDong> excludedDongs, List<RegionLink> links
});


$RegionStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$RegionDetailCopyWithImpl<$Res>
    implements $RegionDetailCopyWith<$Res> {
  _$RegionDetailCopyWithImpl(this._self, this._then);

  final RegionDetail _self;
  final $Res Function(RegionDetail) _then;

/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? province = null,Object? tags = null,Object? seasonType = null,Object? photos = null,Object? month = null,Object? stats = null,Object? months = null,Object? bestMonths = null,Object? avoidMonths = null,Object? peerOffpeakMonths = null,Object? dongs = null,Object? excludedDongs = null,Object? links = null,}) {
  return _then(RegionDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,seasonType: null == seasonType ? _self.seasonType : seasonType // ignore: cast_nullable_to_non_nullable
as SeasonType,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<RegionPhoto>,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as RegionStats,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<MonthCrowd>,bestMonths: null == bestMonths ? _self.bestMonths : bestMonths // ignore: cast_nullable_to_non_nullable
as List<int>,avoidMonths: null == avoidMonths ? _self.avoidMonths : avoidMonths // ignore: cast_nullable_to_non_nullable
as List<int>,peerOffpeakMonths: null == peerOffpeakMonths ? _self.peerOffpeakMonths : peerOffpeakMonths // ignore: cast_nullable_to_non_nullable
as List<int>,dongs: null == dongs ? _self.dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<RegionDong>,excludedDongs: null == excludedDongs ? _self.excludedDongs : excludedDongs // ignore: cast_nullable_to_non_nullable
as List<ExcludedDong>,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<RegionLink>,
  ));
}
/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionStatsCopyWith<$Res> get stats {
  
  return $RegionStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegionDetail].
extension RegionDetailPatterns on RegionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionDetail value)  $default,){
final _that = this;
switch (_that) {
case _RegionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String province,  List<String> tags,  SeasonType seasonType,  List<RegionPhoto> photos,  String month,  RegionStats stats,  List<MonthCrowd> months,  List<int> bestMonths,  List<int> avoidMonths,  List<int> peerOffpeakMonths,  List<RegionDong> dongs,  List<ExcludedDong> excludedDongs,  List<RegionLink> links)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.tags,_that.seasonType,_that.photos,_that.month,_that.stats,_that.months,_that.bestMonths,_that.avoidMonths,_that.peerOffpeakMonths,_that.dongs,_that.excludedDongs,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String province,  List<String> tags,  SeasonType seasonType,  List<RegionPhoto> photos,  String month,  RegionStats stats,  List<MonthCrowd> months,  List<int> bestMonths,  List<int> avoidMonths,  List<int> peerOffpeakMonths,  List<RegionDong> dongs,  List<ExcludedDong> excludedDongs,  List<RegionLink> links)  $default,) {final _that = this;
switch (_that) {
case _RegionDetail():
return $default(_that.id,_that.name,_that.province,_that.tags,_that.seasonType,_that.photos,_that.month,_that.stats,_that.months,_that.bestMonths,_that.avoidMonths,_that.peerOffpeakMonths,_that.dongs,_that.excludedDongs,_that.links);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String province,  List<String> tags,  SeasonType seasonType,  List<RegionPhoto> photos,  String month,  RegionStats stats,  List<MonthCrowd> months,  List<int> bestMonths,  List<int> avoidMonths,  List<int> peerOffpeakMonths,  List<RegionDong> dongs,  List<ExcludedDong> excludedDongs,  List<RegionLink> links)?  $default,) {final _that = this;
switch (_that) {
case _RegionDetail() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.tags,_that.seasonType,_that.photos,_that.month,_that.stats,_that.months,_that.bestMonths,_that.avoidMonths,_that.peerOffpeakMonths,_that.dongs,_that.excludedDongs,_that.links);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionDetail implements RegionDetail {
  const _RegionDetail({required this.id, required this.name, required this.province,  List<String> tags = const <String>[], required this.seasonType,  List<RegionPhoto> photos = const <RegionPhoto>[], required this.month, required this.stats, required  List<MonthCrowd> months,  List<int> bestMonths = const <int>[],  List<int> avoidMonths = const <int>[],  List<int> peerOffpeakMonths = const <int>[],  List<RegionDong> dongs = const <RegionDong>[],  List<ExcludedDong> excludedDongs = const <ExcludedDong>[],  List<RegionLink> links = const <RegionLink>[]}): _tags = tags,_photos = photos,_months = months,_bestMonths = bestMonths,_avoidMonths = avoidMonths,_peerOffpeakMonths = peerOffpeakMonths,_dongs = dongs,_excludedDongs = excludedDongs,_links = links;
  factory _RegionDetail.fromJson(Map<String, dynamic> json) => _$RegionDetailFromJson(json);

@override final  String id;
@override final  String name;
@override final  String province;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  SeasonType seasonType;
 final  List<RegionPhoto> _photos;
@override@JsonKey() List<RegionPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  String month;
@override final  RegionStats stats;
/// 1~12월
 final  List<MonthCrowd> _months;
/// 1~12월
@override List<MonthCrowd> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}

/// 혼잡이 가장 낮은 두 달
 final  List<int> _bestMonths;
/// 혼잡이 가장 낮은 두 달
@override@JsonKey() List<int> get bestMonths {
  if (_bestMonths is EqualUnmodifiableListView) return _bestMonths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bestMonths);
}

/// 혼잡이 가장 높은 두 달
 final  List<int> _avoidMonths;
/// 혼잡이 가장 높은 두 달
@override@JsonKey() List<int> get avoidMonths {
  if (_avoidMonths is EqualUnmodifiableListView) return _avoidMonths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_avoidMonths);
}

/// 또래 비중은 높고 혼잡은 낮은 두 달
 final  List<int> _peerOffpeakMonths;
/// 또래 비중은 높고 혼잡은 낮은 두 달
@override@JsonKey() List<int> get peerOffpeakMonths {
  if (_peerOffpeakMonths is EqualUnmodifiableListView) return _peerOffpeakMonths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_peerOffpeakMonths);
}

 final  List<RegionDong> _dongs;
@override@JsonKey() List<RegionDong> get dongs {
  if (_dongs is EqualUnmodifiableListView) return _dongs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dongs);
}

 final  List<ExcludedDong> _excludedDongs;
@override@JsonKey() List<ExcludedDong> get excludedDongs {
  if (_excludedDongs is EqualUnmodifiableListView) return _excludedDongs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_excludedDongs);
}

 final  List<RegionLink> _links;
@override@JsonKey() List<RegionLink> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}


/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionDetailCopyWith<_RegionDetail> get copyWith => __$RegionDetailCopyWithImpl<_RegionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.province, province) || other.province == province)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.seasonType, seasonType) || other.seasonType == seasonType)&&const DeepCollectionEquality().equals(other.photos, _photos)&&(identical(other.month, month) || other.month == month)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.months, _months)&&const DeepCollectionEquality().equals(other.bestMonths, _bestMonths)&&const DeepCollectionEquality().equals(other.avoidMonths, _avoidMonths)&&const DeepCollectionEquality().equals(other.peerOffpeakMonths, _peerOffpeakMonths)&&const DeepCollectionEquality().equals(other.dongs, _dongs)&&const DeepCollectionEquality().equals(other.excludedDongs, _excludedDongs)&&const DeepCollectionEquality().equals(other.links, _links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,province,const DeepCollectionEquality().hash(_tags),seasonType,const DeepCollectionEquality().hash(_photos),month,stats,const DeepCollectionEquality().hash(_months),const DeepCollectionEquality().hash(_bestMonths),const DeepCollectionEquality().hash(_avoidMonths),const DeepCollectionEquality().hash(_peerOffpeakMonths),const DeepCollectionEquality().hash(_dongs),const DeepCollectionEquality().hash(_excludedDongs),const DeepCollectionEquality().hash(_links));
}

@override
String toString() {
    return 'RegionDetail(id: $id, name: $name, province: $province, tags: $tags, seasonType: $seasonType, photos: $photos, month: $month, stats: $stats, months: $months, bestMonths: $bestMonths, avoidMonths: $avoidMonths, peerOffpeakMonths: $peerOffpeakMonths, dongs: $dongs, excludedDongs: $excludedDongs, links: $links)';
}


}

/// @nodoc
abstract mixin class _$RegionDetailCopyWith<$Res> implements $RegionDetailCopyWith<$Res> {
  factory _$RegionDetailCopyWith(_RegionDetail value, $Res Function(_RegionDetail) _then) = __$RegionDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String province, List<String> tags, SeasonType seasonType, List<RegionPhoto> photos, String month, RegionStats stats, List<MonthCrowd> months, List<int> bestMonths, List<int> avoidMonths, List<int> peerOffpeakMonths, List<RegionDong> dongs, List<ExcludedDong> excludedDongs, List<RegionLink> links
});


@override $RegionStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$RegionDetailCopyWithImpl<$Res>
    implements _$RegionDetailCopyWith<$Res> {
  __$RegionDetailCopyWithImpl(this._self, this._then);

  final _RegionDetail _self;
  final $Res Function(_RegionDetail) _then;

/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? province = null,Object? tags = null,Object? seasonType = null,Object? photos = null,Object? month = null,Object? stats = null,Object? months = null,Object? bestMonths = null,Object? avoidMonths = null,Object? peerOffpeakMonths = null,Object? dongs = null,Object? excludedDongs = null,Object? links = null,}) {
  return _then(_RegionDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,seasonType: null == seasonType ? _self.seasonType : seasonType // ignore: cast_nullable_to_non_nullable
as SeasonType,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<RegionPhoto>,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as RegionStats,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<MonthCrowd>,bestMonths: null == bestMonths ? _self._bestMonths : bestMonths // ignore: cast_nullable_to_non_nullable
as List<int>,avoidMonths: null == avoidMonths ? _self._avoidMonths : avoidMonths // ignore: cast_nullable_to_non_nullable
as List<int>,peerOffpeakMonths: null == peerOffpeakMonths ? _self._peerOffpeakMonths : peerOffpeakMonths // ignore: cast_nullable_to_non_nullable
as List<int>,dongs: null == dongs ? _self._dongs : dongs // ignore: cast_nullable_to_non_nullable
as List<RegionDong>,excludedDongs: null == excludedDongs ? _self._excludedDongs : excludedDongs // ignore: cast_nullable_to_non_nullable
as List<ExcludedDong>,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<RegionLink>,
  ));
}

/// Create a copy of RegionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionStatsCopyWith<$Res> get stats {
  
  return $RegionStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

// dart format on
