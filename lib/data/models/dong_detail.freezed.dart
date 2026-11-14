// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dong_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DongRef {

 String get id; String get name;
/// Create a copy of DongRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DongRefCopyWith<DongRef> get copyWith => _$DongRefCopyWithImpl<DongRef>(this as DongRef, _$identity);

  /// Serializes this DongRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DongRef;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DongRef&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DongRef;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as DongRef;
  return 'DongRef(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $DongRefCopyWith<$Res>  {
  factory $DongRefCopyWith(DongRef value, $Res Function(DongRef) _then) = _$DongRefCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$DongRefCopyWithImpl<$Res>
    implements $DongRefCopyWith<$Res> {
  _$DongRefCopyWithImpl(this._self, this._then);

  final DongRef _self;
  final $Res Function(DongRef) _then;

/// Create a copy of DongRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(DongRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DongRef].
extension DongRefPatterns on DongRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DongRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DongRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DongRef value)  $default,){
final _that = this;
switch (_that) {
case _DongRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DongRef value)?  $default,){
final _that = this;
switch (_that) {
case _DongRef() when $default != null:
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
case _DongRef() when $default != null:
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
case _DongRef():
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
case _DongRef() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DongRef implements DongRef {
  const _DongRef({required this.id, required this.name});
  factory _DongRef.fromJson(Map<String, dynamic> json) => _$DongRefFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of DongRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DongRefCopyWith<_DongRef> get copyWith => __$DongRefCopyWithImpl<_DongRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DongRefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DongRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'DongRef(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$DongRefCopyWith<$Res> implements $DongRefCopyWith<$Res> {
  factory _$DongRefCopyWith(_DongRef value, $Res Function(_DongRef) _then) = __$DongRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$DongRefCopyWithImpl<$Res>
    implements _$DongRefCopyWith<$Res> {
  __$DongRefCopyWithImpl(this._self, this._then);

  final _DongRef _self;
  final $Res Function(_DongRef) _then;

/// Create a copy of DongRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_DongRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DongStats {

/// 평일 낮 체류 ÷ 새벽 체류
 double get dayInflow;/// (거주+근무) ÷ 전체 × 100, 정수
 int get localLife;/// 20~40대 방문 비율 %
 int get peerShare;/// 평일 저녁 보행 ÷ 평일 저녁 체류
 double get eveningVibe;/// 실제 ÷ 예측 저녁 보행
 double get eveningSurplus;
/// Create a copy of DongStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DongStatsCopyWith<DongStats> get copyWith => _$DongStatsCopyWithImpl<DongStats>(this as DongStats, _$identity);

  /// Serializes this DongStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DongStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DongStats&&(identical(other.dayInflow, _this.dayInflow) || other.dayInflow == _this.dayInflow)&&(identical(other.localLife, _this.localLife) || other.localLife == _this.localLife)&&(identical(other.peerShare, _this.peerShare) || other.peerShare == _this.peerShare)&&(identical(other.eveningVibe, _this.eveningVibe) || other.eveningVibe == _this.eveningVibe)&&(identical(other.eveningSurplus, _this.eveningSurplus) || other.eveningSurplus == _this.eveningSurplus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DongStats;
  return Object.hash(runtimeType,_this.dayInflow,_this.localLife,_this.peerShare,_this.eveningVibe,_this.eveningSurplus);
}

@override
String toString() {
  final _this = this as DongStats;
  return 'DongStats(dayInflow: ${_this.dayInflow}, localLife: ${_this.localLife}, peerShare: ${_this.peerShare}, eveningVibe: ${_this.eveningVibe}, eveningSurplus: ${_this.eveningSurplus})';
}


}

/// @nodoc
abstract mixin class $DongStatsCopyWith<$Res>  {
  factory $DongStatsCopyWith(DongStats value, $Res Function(DongStats) _then) = _$DongStatsCopyWithImpl;
@useResult
$Res call({
 double dayInflow, int localLife, int peerShare, double eveningVibe, double eveningSurplus
});




}
/// @nodoc
class _$DongStatsCopyWithImpl<$Res>
    implements $DongStatsCopyWith<$Res> {
  _$DongStatsCopyWithImpl(this._self, this._then);

  final DongStats _self;
  final $Res Function(DongStats) _then;

/// Create a copy of DongStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayInflow = null,Object? localLife = null,Object? peerShare = null,Object? eveningVibe = null,Object? eveningSurplus = null,}) {
  return _then(DongStats(
dayInflow: null == dayInflow ? _self.dayInflow : dayInflow // ignore: cast_nullable_to_non_nullable
as double,localLife: null == localLife ? _self.localLife : localLife // ignore: cast_nullable_to_non_nullable
as int,peerShare: null == peerShare ? _self.peerShare : peerShare // ignore: cast_nullable_to_non_nullable
as int,eveningVibe: null == eveningVibe ? _self.eveningVibe : eveningVibe // ignore: cast_nullable_to_non_nullable
as double,eveningSurplus: null == eveningSurplus ? _self.eveningSurplus : eveningSurplus // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DongStats].
extension DongStatsPatterns on DongStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DongStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DongStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DongStats value)  $default,){
final _that = this;
switch (_that) {
case _DongStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DongStats value)?  $default,){
final _that = this;
switch (_that) {
case _DongStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double dayInflow,  int localLife,  int peerShare,  double eveningVibe,  double eveningSurplus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DongStats() when $default != null:
return $default(_that.dayInflow,_that.localLife,_that.peerShare,_that.eveningVibe,_that.eveningSurplus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double dayInflow,  int localLife,  int peerShare,  double eveningVibe,  double eveningSurplus)  $default,) {final _that = this;
switch (_that) {
case _DongStats():
return $default(_that.dayInflow,_that.localLife,_that.peerShare,_that.eveningVibe,_that.eveningSurplus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double dayInflow,  int localLife,  int peerShare,  double eveningVibe,  double eveningSurplus)?  $default,) {final _that = this;
switch (_that) {
case _DongStats() when $default != null:
return $default(_that.dayInflow,_that.localLife,_that.peerShare,_that.eveningVibe,_that.eveningSurplus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DongStats implements DongStats {
  const _DongStats({required this.dayInflow, required this.localLife, required this.peerShare, required this.eveningVibe, required this.eveningSurplus});
  factory _DongStats.fromJson(Map<String, dynamic> json) => _$DongStatsFromJson(json);

/// 평일 낮 체류 ÷ 새벽 체류
@override final  double dayInflow;
/// (거주+근무) ÷ 전체 × 100, 정수
@override final  int localLife;
/// 20~40대 방문 비율 %
@override final  int peerShare;
/// 평일 저녁 보행 ÷ 평일 저녁 체류
@override final  double eveningVibe;
/// 실제 ÷ 예측 저녁 보행
@override final  double eveningSurplus;

/// Create a copy of DongStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DongStatsCopyWith<_DongStats> get copyWith => __$DongStatsCopyWithImpl<_DongStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DongStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DongStats&&(identical(other.dayInflow, dayInflow) || other.dayInflow == dayInflow)&&(identical(other.localLife, localLife) || other.localLife == localLife)&&(identical(other.peerShare, peerShare) || other.peerShare == peerShare)&&(identical(other.eveningVibe, eveningVibe) || other.eveningVibe == eveningVibe)&&(identical(other.eveningSurplus, eveningSurplus) || other.eveningSurplus == eveningSurplus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dayInflow,localLife,peerShare,eveningVibe,eveningSurplus);
}

@override
String toString() {
    return 'DongStats(dayInflow: $dayInflow, localLife: $localLife, peerShare: $peerShare, eveningVibe: $eveningVibe, eveningSurplus: $eveningSurplus)';
}


}

/// @nodoc
abstract mixin class _$DongStatsCopyWith<$Res> implements $DongStatsCopyWith<$Res> {
  factory _$DongStatsCopyWith(_DongStats value, $Res Function(_DongStats) _then) = __$DongStatsCopyWithImpl;
@override @useResult
$Res call({
 double dayInflow, int localLife, int peerShare, double eveningVibe, double eveningSurplus
});




}
/// @nodoc
class __$DongStatsCopyWithImpl<$Res>
    implements _$DongStatsCopyWith<$Res> {
  __$DongStatsCopyWithImpl(this._self, this._then);

  final _DongStats _self;
  final $Res Function(_DongStats) _then;

/// Create a copy of DongStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayInflow = null,Object? localLife = null,Object? peerShare = null,Object? eveningVibe = null,Object? eveningSurplus = null,}) {
  return _then(_DongStats(
dayInflow: null == dayInflow ? _self.dayInflow : dayInflow // ignore: cast_nullable_to_non_nullable
as double,localLife: null == localLife ? _self.localLife : localLife // ignore: cast_nullable_to_non_nullable
as int,peerShare: null == peerShare ? _self.peerShare : peerShare // ignore: cast_nullable_to_non_nullable
as int,eveningVibe: null == eveningVibe ? _self.eveningVibe : eveningVibe // ignore: cast_nullable_to_non_nullable
as double,eveningSurplus: null == eveningSurplus ? _self.eveningSurplus : eveningSurplus // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$DongScores {

 double get quiet; double get vibe; double get peer;
/// Create a copy of DongScores
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DongScoresCopyWith<DongScores> get copyWith => _$DongScoresCopyWithImpl<DongScores>(this as DongScores, _$identity);

  /// Serializes this DongScores to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DongScores;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DongScores&&(identical(other.quiet, _this.quiet) || other.quiet == _this.quiet)&&(identical(other.vibe, _this.vibe) || other.vibe == _this.vibe)&&(identical(other.peer, _this.peer) || other.peer == _this.peer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DongScores;
  return Object.hash(runtimeType,_this.quiet,_this.vibe,_this.peer);
}

@override
String toString() {
  final _this = this as DongScores;
  return 'DongScores(quiet: ${_this.quiet}, vibe: ${_this.vibe}, peer: ${_this.peer})';
}


}

/// @nodoc
abstract mixin class $DongScoresCopyWith<$Res>  {
  factory $DongScoresCopyWith(DongScores value, $Res Function(DongScores) _then) = _$DongScoresCopyWithImpl;
@useResult
$Res call({
 double quiet, double vibe, double peer
});




}
/// @nodoc
class _$DongScoresCopyWithImpl<$Res>
    implements $DongScoresCopyWith<$Res> {
  _$DongScoresCopyWithImpl(this._self, this._then);

  final DongScores _self;
  final $Res Function(DongScores) _then;

/// Create a copy of DongScores
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quiet = null,Object? vibe = null,Object? peer = null,}) {
  return _then(DongScores(
quiet: null == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as double,vibe: null == vibe ? _self.vibe : vibe // ignore: cast_nullable_to_non_nullable
as double,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DongScores].
extension DongScoresPatterns on DongScores {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DongScores value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DongScores() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DongScores value)  $default,){
final _that = this;
switch (_that) {
case _DongScores():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DongScores value)?  $default,){
final _that = this;
switch (_that) {
case _DongScores() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double quiet,  double vibe,  double peer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DongScores() when $default != null:
return $default(_that.quiet,_that.vibe,_that.peer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double quiet,  double vibe,  double peer)  $default,) {final _that = this;
switch (_that) {
case _DongScores():
return $default(_that.quiet,_that.vibe,_that.peer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double quiet,  double vibe,  double peer)?  $default,) {final _that = this;
switch (_that) {
case _DongScores() when $default != null:
return $default(_that.quiet,_that.vibe,_that.peer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DongScores implements DongScores {
  const _DongScores({required this.quiet, required this.vibe, required this.peer});
  factory _DongScores.fromJson(Map<String, dynamic> json) => _$DongScoresFromJson(json);

@override final  double quiet;
@override final  double vibe;
@override final  double peer;

/// Create a copy of DongScores
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DongScoresCopyWith<_DongScores> get copyWith => __$DongScoresCopyWithImpl<_DongScores>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DongScoresToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DongScores&&(identical(other.quiet, quiet) || other.quiet == quiet)&&(identical(other.vibe, vibe) || other.vibe == vibe)&&(identical(other.peer, peer) || other.peer == peer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quiet,vibe,peer);
}

@override
String toString() {
    return 'DongScores(quiet: $quiet, vibe: $vibe, peer: $peer)';
}


}

/// @nodoc
abstract mixin class _$DongScoresCopyWith<$Res> implements $DongScoresCopyWith<$Res> {
  factory _$DongScoresCopyWith(_DongScores value, $Res Function(_DongScores) _then) = __$DongScoresCopyWithImpl;
@override @useResult
$Res call({
 double quiet, double vibe, double peer
});




}
/// @nodoc
class __$DongScoresCopyWithImpl<$Res>
    implements _$DongScoresCopyWith<$Res> {
  __$DongScoresCopyWithImpl(this._self, this._then);

  final _DongScores _self;
  final $Res Function(_DongScores) _then;

/// Create a copy of DongScores
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quiet = null,Object? vibe = null,Object? peer = null,}) {
  return _then(_DongScores(
quiet: null == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as double,vibe: null == vibe ? _self.vibe : vibe // ignore: cast_nullable_to_non_nullable
as double,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Hourly {

 List<int> get weekday; List<int> get weekend;
/// Create a copy of Hourly
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyCopyWith<Hourly> get copyWith => _$HourlyCopyWithImpl<Hourly>(this as Hourly, _$identity);

  /// Serializes this Hourly to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Hourly;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hourly&&const DeepCollectionEquality().equals(other.weekday, _this.weekday)&&const DeepCollectionEquality().equals(other.weekend, _this.weekend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Hourly;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.weekday),const DeepCollectionEquality().hash(_this.weekend));
}

@override
String toString() {
  final _this = this as Hourly;
  return 'Hourly(weekday: ${_this.weekday}, weekend: ${_this.weekend})';
}


}

/// @nodoc
abstract mixin class $HourlyCopyWith<$Res>  {
  factory $HourlyCopyWith(Hourly value, $Res Function(Hourly) _then) = _$HourlyCopyWithImpl;
@useResult
$Res call({
 List<int> weekday, List<int> weekend
});




}
/// @nodoc
class _$HourlyCopyWithImpl<$Res>
    implements $HourlyCopyWith<$Res> {
  _$HourlyCopyWithImpl(this._self, this._then);

  final Hourly _self;
  final $Res Function(Hourly) _then;

/// Create a copy of Hourly
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? weekend = null,}) {
  return _then(Hourly(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as List<int>,weekend: null == weekend ? _self.weekend : weekend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [Hourly].
extension HourlyPatterns on Hourly {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hourly value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hourly() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hourly value)  $default,){
final _that = this;
switch (_that) {
case _Hourly():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hourly value)?  $default,){
final _that = this;
switch (_that) {
case _Hourly() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> weekday,  List<int> weekend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hourly() when $default != null:
return $default(_that.weekday,_that.weekend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> weekday,  List<int> weekend)  $default,) {final _that = this;
switch (_that) {
case _Hourly():
return $default(_that.weekday,_that.weekend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> weekday,  List<int> weekend)?  $default,) {final _that = this;
switch (_that) {
case _Hourly() when $default != null:
return $default(_that.weekday,_that.weekend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hourly implements Hourly {
  const _Hourly({required  List<int> weekday, required  List<int> weekend}): _weekday = weekday,_weekend = weekend;
  factory _Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

 final  List<int> _weekday;
@override List<int> get weekday {
  if (_weekday is EqualUnmodifiableListView) return _weekday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekday);
}

 final  List<int> _weekend;
@override List<int> get weekend {
  if (_weekend is EqualUnmodifiableListView) return _weekend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekend);
}


/// Create a copy of Hourly
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyCopyWith<_Hourly> get copyWith => __$HourlyCopyWithImpl<_Hourly>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourlyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hourly&&const DeepCollectionEquality().equals(other.weekday, _weekday)&&const DeepCollectionEquality().equals(other.weekend, _weekend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_weekday),const DeepCollectionEquality().hash(_weekend));
}

@override
String toString() {
    return 'Hourly(weekday: $weekday, weekend: $weekend)';
}


}

/// @nodoc
abstract mixin class _$HourlyCopyWith<$Res> implements $HourlyCopyWith<$Res> {
  factory _$HourlyCopyWith(_Hourly value, $Res Function(_Hourly) _then) = __$HourlyCopyWithImpl;
@override @useResult
$Res call({
 List<int> weekday, List<int> weekend
});




}
/// @nodoc
class __$HourlyCopyWithImpl<$Res>
    implements _$HourlyCopyWith<$Res> {
  __$HourlyCopyWithImpl(this._self, this._then);

  final _Hourly _self;
  final $Res Function(_Hourly) _then;

/// Create a copy of Hourly
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? weekend = null,}) {
  return _then(_Hourly(
weekday: null == weekday ? _self._weekday : weekday // ignore: cast_nullable_to_non_nullable
as List<int>,weekend: null == weekend ? _self._weekend : weekend // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$Peak {

 int get peakHour; int get lowHour; int get lowValue;
/// Create a copy of Peak
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeakCopyWith<Peak> get copyWith => _$PeakCopyWithImpl<Peak>(this as Peak, _$identity);

  /// Serializes this Peak to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Peak;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Peak&&(identical(other.peakHour, _this.peakHour) || other.peakHour == _this.peakHour)&&(identical(other.lowHour, _this.lowHour) || other.lowHour == _this.lowHour)&&(identical(other.lowValue, _this.lowValue) || other.lowValue == _this.lowValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Peak;
  return Object.hash(runtimeType,_this.peakHour,_this.lowHour,_this.lowValue);
}

@override
String toString() {
  final _this = this as Peak;
  return 'Peak(peakHour: ${_this.peakHour}, lowHour: ${_this.lowHour}, lowValue: ${_this.lowValue})';
}


}

/// @nodoc
abstract mixin class $PeakCopyWith<$Res>  {
  factory $PeakCopyWith(Peak value, $Res Function(Peak) _then) = _$PeakCopyWithImpl;
@useResult
$Res call({
 int peakHour, int lowHour, int lowValue
});




}
/// @nodoc
class _$PeakCopyWithImpl<$Res>
    implements $PeakCopyWith<$Res> {
  _$PeakCopyWithImpl(this._self, this._then);

  final Peak _self;
  final $Res Function(Peak) _then;

/// Create a copy of Peak
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? peakHour = null,Object? lowHour = null,Object? lowValue = null,}) {
  return _then(Peak(
peakHour: null == peakHour ? _self.peakHour : peakHour // ignore: cast_nullable_to_non_nullable
as int,lowHour: null == lowHour ? _self.lowHour : lowHour // ignore: cast_nullable_to_non_nullable
as int,lowValue: null == lowValue ? _self.lowValue : lowValue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Peak].
extension PeakPatterns on Peak {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Peak value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Peak() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Peak value)  $default,){
final _that = this;
switch (_that) {
case _Peak():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Peak value)?  $default,){
final _that = this;
switch (_that) {
case _Peak() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int peakHour,  int lowHour,  int lowValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Peak() when $default != null:
return $default(_that.peakHour,_that.lowHour,_that.lowValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int peakHour,  int lowHour,  int lowValue)  $default,) {final _that = this;
switch (_that) {
case _Peak():
return $default(_that.peakHour,_that.lowHour,_that.lowValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int peakHour,  int lowHour,  int lowValue)?  $default,) {final _that = this;
switch (_that) {
case _Peak() when $default != null:
return $default(_that.peakHour,_that.lowHour,_that.lowValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Peak implements Peak {
  const _Peak({required this.peakHour, required this.lowHour, required this.lowValue});
  factory _Peak.fromJson(Map<String, dynamic> json) => _$PeakFromJson(json);

@override final  int peakHour;
@override final  int lowHour;
@override final  int lowValue;

/// Create a copy of Peak
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeakCopyWith<_Peak> get copyWith => __$PeakCopyWithImpl<_Peak>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeakToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Peak&&(identical(other.peakHour, peakHour) || other.peakHour == peakHour)&&(identical(other.lowHour, lowHour) || other.lowHour == lowHour)&&(identical(other.lowValue, lowValue) || other.lowValue == lowValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,peakHour,lowHour,lowValue);
}

@override
String toString() {
    return 'Peak(peakHour: $peakHour, lowHour: $lowHour, lowValue: $lowValue)';
}


}

/// @nodoc
abstract mixin class _$PeakCopyWith<$Res> implements $PeakCopyWith<$Res> {
  factory _$PeakCopyWith(_Peak value, $Res Function(_Peak) _then) = __$PeakCopyWithImpl;
@override @useResult
$Res call({
 int peakHour, int lowHour, int lowValue
});




}
/// @nodoc
class __$PeakCopyWithImpl<$Res>
    implements _$PeakCopyWith<$Res> {
  __$PeakCopyWithImpl(this._self, this._then);

  final _Peak _self;
  final $Res Function(_Peak) _then;

/// Create a copy of Peak
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? peakHour = null,Object? lowHour = null,Object? lowValue = null,}) {
  return _then(_Peak(
peakHour: null == peakHour ? _self.peakHour : peakHour // ignore: cast_nullable_to_non_nullable
as int,lowHour: null == lowHour ? _self.lowHour : lowHour // ignore: cast_nullable_to_non_nullable
as int,lowValue: null == lowValue ? _self.lowValue : lowValue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Peaks {

 Peak get weekday; Peak get weekend;
/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeaksCopyWith<Peaks> get copyWith => _$PeaksCopyWithImpl<Peaks>(this as Peaks, _$identity);

  /// Serializes this Peaks to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Peaks;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Peaks&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.weekend, _this.weekend) || other.weekend == _this.weekend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Peaks;
  return Object.hash(runtimeType,_this.weekday,_this.weekend);
}

@override
String toString() {
  final _this = this as Peaks;
  return 'Peaks(weekday: ${_this.weekday}, weekend: ${_this.weekend})';
}


}

/// @nodoc
abstract mixin class $PeaksCopyWith<$Res>  {
  factory $PeaksCopyWith(Peaks value, $Res Function(Peaks) _then) = _$PeaksCopyWithImpl;
@useResult
$Res call({
 Peak weekday, Peak weekend
});


$PeakCopyWith<$Res> get weekday;$PeakCopyWith<$Res> get weekend;

}
/// @nodoc
class _$PeaksCopyWithImpl<$Res>
    implements $PeaksCopyWith<$Res> {
  _$PeaksCopyWithImpl(this._self, this._then);

  final Peaks _self;
  final $Res Function(Peaks) _then;

/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? weekend = null,}) {
  return _then(Peaks(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as Peak,weekend: null == weekend ? _self.weekend : weekend // ignore: cast_nullable_to_non_nullable
as Peak,
  ));
}
/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeakCopyWith<$Res> get weekday {
  
  return $PeakCopyWith<$Res>(_self.weekday, (value) {
    return _then(_self.copyWith(weekday: value));
  });
}/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeakCopyWith<$Res> get weekend {
  
  return $PeakCopyWith<$Res>(_self.weekend, (value) {
    return _then(_self.copyWith(weekend: value));
  });
}
}


/// Adds pattern-matching-related methods to [Peaks].
extension PeaksPatterns on Peaks {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Peaks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Peaks() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Peaks value)  $default,){
final _that = this;
switch (_that) {
case _Peaks():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Peaks value)?  $default,){
final _that = this;
switch (_that) {
case _Peaks() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Peak weekday,  Peak weekend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Peaks() when $default != null:
return $default(_that.weekday,_that.weekend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Peak weekday,  Peak weekend)  $default,) {final _that = this;
switch (_that) {
case _Peaks():
return $default(_that.weekday,_that.weekend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Peak weekday,  Peak weekend)?  $default,) {final _that = this;
switch (_that) {
case _Peaks() when $default != null:
return $default(_that.weekday,_that.weekend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Peaks implements Peaks {
  const _Peaks({required this.weekday, required this.weekend});
  factory _Peaks.fromJson(Map<String, dynamic> json) => _$PeaksFromJson(json);

@override final  Peak weekday;
@override final  Peak weekend;

/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeaksCopyWith<_Peaks> get copyWith => __$PeaksCopyWithImpl<_Peaks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeaksToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Peaks&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.weekend, weekend) || other.weekend == weekend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,weekday,weekend);
}

@override
String toString() {
    return 'Peaks(weekday: $weekday, weekend: $weekend)';
}


}

/// @nodoc
abstract mixin class _$PeaksCopyWith<$Res> implements $PeaksCopyWith<$Res> {
  factory _$PeaksCopyWith(_Peaks value, $Res Function(_Peaks) _then) = __$PeaksCopyWithImpl;
@override @useResult
$Res call({
 Peak weekday, Peak weekend
});


@override $PeakCopyWith<$Res> get weekday;@override $PeakCopyWith<$Res> get weekend;

}
/// @nodoc
class __$PeaksCopyWithImpl<$Res>
    implements _$PeaksCopyWith<$Res> {
  __$PeaksCopyWithImpl(this._self, this._then);

  final _Peaks _self;
  final $Res Function(_Peaks) _then;

/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? weekend = null,}) {
  return _then(_Peaks(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as Peak,weekend: null == weekend ? _self.weekend : weekend // ignore: cast_nullable_to_non_nullable
as Peak,
  ));
}

/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeakCopyWith<$Res> get weekday {
  
  return $PeakCopyWith<$Res>(_self.weekday, (value) {
    return _then(_self.copyWith(weekday: value));
  });
}/// Create a copy of Peaks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeakCopyWith<$Res> get weekend {
  
  return $PeakCopyWith<$Res>(_self.weekend, (value) {
    return _then(_self.copyWith(weekend: value));
  });
}
}


/// @nodoc
mixin _$DongDetail {

 String get id; String get name; DongRef get sigungu; String get province; DongKind get kind; List<String> get tags; List<RegionPhoto> get photos; List<String> get landmarks;/// 예: `강릉시 북부 · 바닷가 0.0km`
 String get accessNote; String get month; DongStats get stats;/// 특수시설 동처럼 집계에서 빠지면 null
 DongScores? get scores;/// 백분위를 매긴 행정동 수(특수시설 제외)
 int get dongCount; Hourly get hourly; Peaks get peaks;/// 키는 [ActivityKey.name]
 Map<String, int> get activityMix; SeasonType get seasonType;
/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DongDetailCopyWith<DongDetail> get copyWith => _$DongDetailCopyWithImpl<DongDetail>(this as DongDetail, _$identity);

  /// Serializes this DongDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DongDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DongDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sigungu, _this.sigungu) || other.sigungu == _this.sigungu)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&const DeepCollectionEquality().equals(other.photos, _this.photos)&&const DeepCollectionEquality().equals(other.landmarks, _this.landmarks)&&(identical(other.accessNote, _this.accessNote) || other.accessNote == _this.accessNote)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.stats, _this.stats) || other.stats == _this.stats)&&(identical(other.scores, _this.scores) || other.scores == _this.scores)&&(identical(other.dongCount, _this.dongCount) || other.dongCount == _this.dongCount)&&(identical(other.hourly, _this.hourly) || other.hourly == _this.hourly)&&(identical(other.peaks, _this.peaks) || other.peaks == _this.peaks)&&const DeepCollectionEquality().equals(other.activityMix, _this.activityMix)&&(identical(other.seasonType, _this.seasonType) || other.seasonType == _this.seasonType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DongDetail;
  return Object.hash(runtimeType,_this.id,_this.name,_this.sigungu,_this.province,_this.kind,const DeepCollectionEquality().hash(_this.tags),const DeepCollectionEquality().hash(_this.photos),const DeepCollectionEquality().hash(_this.landmarks),_this.accessNote,_this.month,_this.stats,_this.scores,_this.dongCount,_this.hourly,_this.peaks,const DeepCollectionEquality().hash(_this.activityMix),_this.seasonType);
}

@override
String toString() {
  final _this = this as DongDetail;
  return 'DongDetail(id: ${_this.id}, name: ${_this.name}, sigungu: ${_this.sigungu}, province: ${_this.province}, kind: ${_this.kind}, tags: ${_this.tags}, photos: ${_this.photos}, landmarks: ${_this.landmarks}, accessNote: ${_this.accessNote}, month: ${_this.month}, stats: ${_this.stats}, scores: ${_this.scores}, dongCount: ${_this.dongCount}, hourly: ${_this.hourly}, peaks: ${_this.peaks}, activityMix: ${_this.activityMix}, seasonType: ${_this.seasonType})';
}


}

/// @nodoc
abstract mixin class $DongDetailCopyWith<$Res>  {
  factory $DongDetailCopyWith(DongDetail value, $Res Function(DongDetail) _then) = _$DongDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, DongRef sigungu, String province, DongKind kind, List<String> tags, List<RegionPhoto> photos, List<String> landmarks, String accessNote, String month, DongStats stats, DongScores? scores, int dongCount, Hourly hourly, Peaks peaks, Map<String, int> activityMix, SeasonType seasonType
});


$DongRefCopyWith<$Res> get sigungu;$DongStatsCopyWith<$Res> get stats;$DongScoresCopyWith<$Res>? get scores;$HourlyCopyWith<$Res> get hourly;$PeaksCopyWith<$Res> get peaks;

}
/// @nodoc
class _$DongDetailCopyWithImpl<$Res>
    implements $DongDetailCopyWith<$Res> {
  _$DongDetailCopyWithImpl(this._self, this._then);

  final DongDetail _self;
  final $Res Function(DongDetail) _then;

/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sigungu = null,Object? province = null,Object? kind = null,Object? tags = null,Object? photos = null,Object? landmarks = null,Object? accessNote = null,Object? month = null,Object? stats = null,Object? scores = freezed,Object? dongCount = null,Object? hourly = null,Object? peaks = null,Object? activityMix = null,Object? seasonType = null,}) {
  return _then(DongDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as DongRef,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<RegionPhoto>,landmarks: null == landmarks ? _self.landmarks : landmarks // ignore: cast_nullable_to_non_nullable
as List<String>,accessNote: null == accessNote ? _self.accessNote : accessNote // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DongStats,scores: freezed == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as DongScores?,dongCount: null == dongCount ? _self.dongCount : dongCount // ignore: cast_nullable_to_non_nullable
as int,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as Hourly,peaks: null == peaks ? _self.peaks : peaks // ignore: cast_nullable_to_non_nullable
as Peaks,activityMix: null == activityMix ? _self.activityMix : activityMix // ignore: cast_nullable_to_non_nullable
as Map<String, int>,seasonType: null == seasonType ? _self.seasonType : seasonType // ignore: cast_nullable_to_non_nullable
as SeasonType,
  ));
}
/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongRefCopyWith<$Res> get sigungu {
  
  return $DongRefCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongStatsCopyWith<$Res> get stats {
  
  return $DongStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongScoresCopyWith<$Res>? get scores {
    if (_self.scores == null) {
    return null;
  }

  return $DongScoresCopyWith<$Res>(_self.scores!, (value) {
    return _then(_self.copyWith(scores: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HourlyCopyWith<$Res> get hourly {
  
  return $HourlyCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeaksCopyWith<$Res> get peaks {
  
  return $PeaksCopyWith<$Res>(_self.peaks, (value) {
    return _then(_self.copyWith(peaks: value));
  });
}
}


/// Adds pattern-matching-related methods to [DongDetail].
extension DongDetailPatterns on DongDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DongDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DongDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DongDetail value)  $default,){
final _that = this;
switch (_that) {
case _DongDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DongDetail value)?  $default,){
final _that = this;
switch (_that) {
case _DongDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DongRef sigungu,  String province,  DongKind kind,  List<String> tags,  List<RegionPhoto> photos,  List<String> landmarks,  String accessNote,  String month,  DongStats stats,  DongScores? scores,  int dongCount,  Hourly hourly,  Peaks peaks,  Map<String, int> activityMix,  SeasonType seasonType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DongDetail() when $default != null:
return $default(_that.id,_that.name,_that.sigungu,_that.province,_that.kind,_that.tags,_that.photos,_that.landmarks,_that.accessNote,_that.month,_that.stats,_that.scores,_that.dongCount,_that.hourly,_that.peaks,_that.activityMix,_that.seasonType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DongRef sigungu,  String province,  DongKind kind,  List<String> tags,  List<RegionPhoto> photos,  List<String> landmarks,  String accessNote,  String month,  DongStats stats,  DongScores? scores,  int dongCount,  Hourly hourly,  Peaks peaks,  Map<String, int> activityMix,  SeasonType seasonType)  $default,) {final _that = this;
switch (_that) {
case _DongDetail():
return $default(_that.id,_that.name,_that.sigungu,_that.province,_that.kind,_that.tags,_that.photos,_that.landmarks,_that.accessNote,_that.month,_that.stats,_that.scores,_that.dongCount,_that.hourly,_that.peaks,_that.activityMix,_that.seasonType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DongRef sigungu,  String province,  DongKind kind,  List<String> tags,  List<RegionPhoto> photos,  List<String> landmarks,  String accessNote,  String month,  DongStats stats,  DongScores? scores,  int dongCount,  Hourly hourly,  Peaks peaks,  Map<String, int> activityMix,  SeasonType seasonType)?  $default,) {final _that = this;
switch (_that) {
case _DongDetail() when $default != null:
return $default(_that.id,_that.name,_that.sigungu,_that.province,_that.kind,_that.tags,_that.photos,_that.landmarks,_that.accessNote,_that.month,_that.stats,_that.scores,_that.dongCount,_that.hourly,_that.peaks,_that.activityMix,_that.seasonType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DongDetail implements DongDetail {
  const _DongDetail({required this.id, required this.name, required this.sigungu, required this.province, required this.kind,  List<String> tags = const <String>[],  List<RegionPhoto> photos = const <RegionPhoto>[],  List<String> landmarks = const <String>[], this.accessNote = '', required this.month, required this.stats, this.scores, this.dongCount = 0, required this.hourly, required this.peaks,  Map<String, int> activityMix = const <String, int>{}, required this.seasonType}): _tags = tags,_photos = photos,_landmarks = landmarks,_activityMix = activityMix;
  factory _DongDetail.fromJson(Map<String, dynamic> json) => _$DongDetailFromJson(json);

@override final  String id;
@override final  String name;
@override final  DongRef sigungu;
@override final  String province;
@override final  DongKind kind;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<RegionPhoto> _photos;
@override@JsonKey() List<RegionPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

 final  List<String> _landmarks;
@override@JsonKey() List<String> get landmarks {
  if (_landmarks is EqualUnmodifiableListView) return _landmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_landmarks);
}

/// 예: `강릉시 북부 · 바닷가 0.0km`
@override@JsonKey() final  String accessNote;
@override final  String month;
@override final  DongStats stats;
/// 특수시설 동처럼 집계에서 빠지면 null
@override final  DongScores? scores;
/// 백분위를 매긴 행정동 수(특수시설 제외)
@override@JsonKey() final  int dongCount;
@override final  Hourly hourly;
@override final  Peaks peaks;
/// 키는 [ActivityKey.name]
 final  Map<String, int> _activityMix;
/// 키는 [ActivityKey.name]
@override@JsonKey() Map<String, int> get activityMix {
  if (_activityMix is EqualUnmodifiableMapView) return _activityMix;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_activityMix);
}

@override final  SeasonType seasonType;

/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DongDetailCopyWith<_DongDetail> get copyWith => __$DongDetailCopyWithImpl<_DongDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DongDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DongDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sigungu, sigungu) || other.sigungu == sigungu)&&(identical(other.province, province) || other.province == province)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.tags, _tags)&&const DeepCollectionEquality().equals(other.photos, _photos)&&const DeepCollectionEquality().equals(other.landmarks, _landmarks)&&(identical(other.accessNote, accessNote) || other.accessNote == accessNote)&&(identical(other.month, month) || other.month == month)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.scores, scores) || other.scores == scores)&&(identical(other.dongCount, dongCount) || other.dongCount == dongCount)&&(identical(other.hourly, hourly) || other.hourly == hourly)&&(identical(other.peaks, peaks) || other.peaks == peaks)&&const DeepCollectionEquality().equals(other.activityMix, _activityMix)&&(identical(other.seasonType, seasonType) || other.seasonType == seasonType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,sigungu,province,kind,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_photos),const DeepCollectionEquality().hash(_landmarks),accessNote,month,stats,scores,dongCount,hourly,peaks,const DeepCollectionEquality().hash(_activityMix),seasonType);
}

@override
String toString() {
    return 'DongDetail(id: $id, name: $name, sigungu: $sigungu, province: $province, kind: $kind, tags: $tags, photos: $photos, landmarks: $landmarks, accessNote: $accessNote, month: $month, stats: $stats, scores: $scores, dongCount: $dongCount, hourly: $hourly, peaks: $peaks, activityMix: $activityMix, seasonType: $seasonType)';
}


}

/// @nodoc
abstract mixin class _$DongDetailCopyWith<$Res> implements $DongDetailCopyWith<$Res> {
  factory _$DongDetailCopyWith(_DongDetail value, $Res Function(_DongDetail) _then) = __$DongDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DongRef sigungu, String province, DongKind kind, List<String> tags, List<RegionPhoto> photos, List<String> landmarks, String accessNote, String month, DongStats stats, DongScores? scores, int dongCount, Hourly hourly, Peaks peaks, Map<String, int> activityMix, SeasonType seasonType
});


@override $DongRefCopyWith<$Res> get sigungu;@override $DongStatsCopyWith<$Res> get stats;@override $DongScoresCopyWith<$Res>? get scores;@override $HourlyCopyWith<$Res> get hourly;@override $PeaksCopyWith<$Res> get peaks;

}
/// @nodoc
class __$DongDetailCopyWithImpl<$Res>
    implements _$DongDetailCopyWith<$Res> {
  __$DongDetailCopyWithImpl(this._self, this._then);

  final _DongDetail _self;
  final $Res Function(_DongDetail) _then;

/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sigungu = null,Object? province = null,Object? kind = null,Object? tags = null,Object? photos = null,Object? landmarks = null,Object? accessNote = null,Object? month = null,Object? stats = null,Object? scores = freezed,Object? dongCount = null,Object? hourly = null,Object? peaks = null,Object? activityMix = null,Object? seasonType = null,}) {
  return _then(_DongDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sigungu: null == sigungu ? _self.sigungu : sigungu // ignore: cast_nullable_to_non_nullable
as DongRef,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DongKind,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<RegionPhoto>,landmarks: null == landmarks ? _self._landmarks : landmarks // ignore: cast_nullable_to_non_nullable
as List<String>,accessNote: null == accessNote ? _self.accessNote : accessNote // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DongStats,scores: freezed == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as DongScores?,dongCount: null == dongCount ? _self.dongCount : dongCount // ignore: cast_nullable_to_non_nullable
as int,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as Hourly,peaks: null == peaks ? _self.peaks : peaks // ignore: cast_nullable_to_non_nullable
as Peaks,activityMix: null == activityMix ? _self._activityMix : activityMix // ignore: cast_nullable_to_non_nullable
as Map<String, int>,seasonType: null == seasonType ? _self.seasonType : seasonType // ignore: cast_nullable_to_non_nullable
as SeasonType,
  ));
}

/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongRefCopyWith<$Res> get sigungu {
  
  return $DongRefCopyWith<$Res>(_self.sigungu, (value) {
    return _then(_self.copyWith(sigungu: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongStatsCopyWith<$Res> get stats {
  
  return $DongStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DongScoresCopyWith<$Res>? get scores {
    if (_self.scores == null) {
    return null;
  }

  return $DongScoresCopyWith<$Res>(_self.scores!, (value) {
    return _then(_self.copyWith(scores: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HourlyCopyWith<$Res> get hourly {
  
  return $HourlyCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of DongDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeaksCopyWith<$Res> get peaks {
  
  return $PeaksCopyWith<$Res>(_self.peaks, (value) {
    return _then(_self.copyWith(peaks: value));
  });
}
}

// dart format on
