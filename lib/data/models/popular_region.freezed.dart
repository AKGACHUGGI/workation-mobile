// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MetricScores {

 double get quiet; double get crowd; double get peer; double get overnight; double get vibe;
/// Create a copy of MetricScores
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<MetricScores> get copyWith => _$MetricScoresCopyWithImpl<MetricScores>(this as MetricScores, _$identity);

  /// Serializes this MetricScores to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MetricScores;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetricScores&&(identical(other.quiet, _this.quiet) || other.quiet == _this.quiet)&&(identical(other.crowd, _this.crowd) || other.crowd == _this.crowd)&&(identical(other.peer, _this.peer) || other.peer == _this.peer)&&(identical(other.overnight, _this.overnight) || other.overnight == _this.overnight)&&(identical(other.vibe, _this.vibe) || other.vibe == _this.vibe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MetricScores;
  return Object.hash(runtimeType,_this.quiet,_this.crowd,_this.peer,_this.overnight,_this.vibe);
}

@override
String toString() {
  final _this = this as MetricScores;
  return 'MetricScores(quiet: ${_this.quiet}, crowd: ${_this.crowd}, peer: ${_this.peer}, overnight: ${_this.overnight}, vibe: ${_this.vibe})';
}


}

/// @nodoc
abstract mixin class $MetricScoresCopyWith<$Res>  {
  factory $MetricScoresCopyWith(MetricScores value, $Res Function(MetricScores) _then) = _$MetricScoresCopyWithImpl;
@useResult
$Res call({
 double quiet, double crowd, double peer, double overnight, double vibe
});




}
/// @nodoc
class _$MetricScoresCopyWithImpl<$Res>
    implements $MetricScoresCopyWith<$Res> {
  _$MetricScoresCopyWithImpl(this._self, this._then);

  final MetricScores _self;
  final $Res Function(MetricScores) _then;

/// Create a copy of MetricScores
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quiet = null,Object? crowd = null,Object? peer = null,Object? overnight = null,Object? vibe = null,}) {
  return _then(MetricScores(
quiet: null == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as double,crowd: null == crowd ? _self.crowd : crowd // ignore: cast_nullable_to_non_nullable
as double,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as double,overnight: null == overnight ? _self.overnight : overnight // ignore: cast_nullable_to_non_nullable
as double,vibe: null == vibe ? _self.vibe : vibe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MetricScores].
extension MetricScoresPatterns on MetricScores {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MetricScores value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetricScores() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MetricScores value)  $default,){
final _that = this;
switch (_that) {
case _MetricScores():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MetricScores value)?  $default,){
final _that = this;
switch (_that) {
case _MetricScores() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double quiet,  double crowd,  double peer,  double overnight,  double vibe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetricScores() when $default != null:
return $default(_that.quiet,_that.crowd,_that.peer,_that.overnight,_that.vibe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double quiet,  double crowd,  double peer,  double overnight,  double vibe)  $default,) {final _that = this;
switch (_that) {
case _MetricScores():
return $default(_that.quiet,_that.crowd,_that.peer,_that.overnight,_that.vibe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double quiet,  double crowd,  double peer,  double overnight,  double vibe)?  $default,) {final _that = this;
switch (_that) {
case _MetricScores() when $default != null:
return $default(_that.quiet,_that.crowd,_that.peer,_that.overnight,_that.vibe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MetricScores extends MetricScores {
  const _MetricScores({required this.quiet, required this.crowd, required this.peer, required this.overnight, required this.vibe}): super._();
  factory _MetricScores.fromJson(Map<String, dynamic> json) => _$MetricScoresFromJson(json);

@override final  double quiet;
@override final  double crowd;
@override final  double peer;
@override final  double overnight;
@override final  double vibe;

/// Create a copy of MetricScores
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetricScoresCopyWith<_MetricScores> get copyWith => __$MetricScoresCopyWithImpl<_MetricScores>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetricScoresToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetricScores&&(identical(other.quiet, quiet) || other.quiet == quiet)&&(identical(other.crowd, crowd) || other.crowd == crowd)&&(identical(other.peer, peer) || other.peer == peer)&&(identical(other.overnight, overnight) || other.overnight == overnight)&&(identical(other.vibe, vibe) || other.vibe == vibe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quiet,crowd,peer,overnight,vibe);
}

@override
String toString() {
    return 'MetricScores(quiet: $quiet, crowd: $crowd, peer: $peer, overnight: $overnight, vibe: $vibe)';
}


}

/// @nodoc
abstract mixin class _$MetricScoresCopyWith<$Res> implements $MetricScoresCopyWith<$Res> {
  factory _$MetricScoresCopyWith(_MetricScores value, $Res Function(_MetricScores) _then) = __$MetricScoresCopyWithImpl;
@override @useResult
$Res call({
 double quiet, double crowd, double peer, double overnight, double vibe
});




}
/// @nodoc
class __$MetricScoresCopyWithImpl<$Res>
    implements _$MetricScoresCopyWith<$Res> {
  __$MetricScoresCopyWithImpl(this._self, this._then);

  final _MetricScores _self;
  final $Res Function(_MetricScores) _then;

/// Create a copy of MetricScores
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quiet = null,Object? crowd = null,Object? peer = null,Object? overnight = null,Object? vibe = null,}) {
  return _then(_MetricScores(
quiet: null == quiet ? _self.quiet : quiet // ignore: cast_nullable_to_non_nullable
as double,crowd: null == crowd ? _self.crowd : crowd // ignore: cast_nullable_to_non_nullable
as double,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as double,overnight: null == overnight ? _self.overnight : overnight // ignore: cast_nullable_to_non_nullable
as double,vibe: null == vibe ? _self.vibe : vibe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PopularRegion {

 String get id; String get name; String get province; String? get photoUrl; List<String> get tags; List<Terrain> get terrain; MetricScores get scores; int get favoriteCount; int get viewCount;
/// Create a copy of PopularRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularRegionCopyWith<PopularRegion> get copyWith => _$PopularRegionCopyWithImpl<PopularRegion>(this as PopularRegion, _$identity);

  /// Serializes this PopularRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PopularRegion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularRegion&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&const DeepCollectionEquality().equals(other.terrain, _this.terrain)&&(identical(other.scores, _this.scores) || other.scores == _this.scores)&&(identical(other.favoriteCount, _this.favoriteCount) || other.favoriteCount == _this.favoriteCount)&&(identical(other.viewCount, _this.viewCount) || other.viewCount == _this.viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PopularRegion;
  return Object.hash(runtimeType,_this.id,_this.name,_this.province,_this.photoUrl,const DeepCollectionEquality().hash(_this.tags),const DeepCollectionEquality().hash(_this.terrain),_this.scores,_this.favoriteCount,_this.viewCount);
}

@override
String toString() {
  final _this = this as PopularRegion;
  return 'PopularRegion(id: ${_this.id}, name: ${_this.name}, province: ${_this.province}, photoUrl: ${_this.photoUrl}, tags: ${_this.tags}, terrain: ${_this.terrain}, scores: ${_this.scores}, favoriteCount: ${_this.favoriteCount}, viewCount: ${_this.viewCount})';
}


}

/// @nodoc
abstract mixin class $PopularRegionCopyWith<$Res>  {
  factory $PopularRegionCopyWith(PopularRegion value, $Res Function(PopularRegion) _then) = _$PopularRegionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String province, String? photoUrl, List<String> tags, List<Terrain> terrain, MetricScores scores, int favoriteCount, int viewCount
});


$MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class _$PopularRegionCopyWithImpl<$Res>
    implements $PopularRegionCopyWith<$Res> {
  _$PopularRegionCopyWithImpl(this._self, this._then);

  final PopularRegion _self;
  final $Res Function(PopularRegion) _then;

/// Create a copy of PopularRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? province = null,Object? photoUrl = freezed,Object? tags = null,Object? terrain = null,Object? scores = null,Object? favoriteCount = null,Object? viewCount = null,}) {
  return _then(PopularRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,terrain: null == terrain ? _self.terrain : terrain // ignore: cast_nullable_to_non_nullable
as List<Terrain>,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PopularRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetricScoresCopyWith<$Res> get scores {
  
  return $MetricScoresCopyWith<$Res>(_self.scores, (value) {
    return _then(_self.copyWith(scores: value));
  });
}
}


/// Adds pattern-matching-related methods to [PopularRegion].
extension PopularRegionPatterns on PopularRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularRegion value)  $default,){
final _that = this;
switch (_that) {
case _PopularRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularRegion value)?  $default,){
final _that = this;
switch (_that) {
case _PopularRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String province,  String? photoUrl,  List<String> tags,  List<Terrain> terrain,  MetricScores scores,  int favoriteCount,  int viewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularRegion() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.tags,_that.terrain,_that.scores,_that.favoriteCount,_that.viewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String province,  String? photoUrl,  List<String> tags,  List<Terrain> terrain,  MetricScores scores,  int favoriteCount,  int viewCount)  $default,) {final _that = this;
switch (_that) {
case _PopularRegion():
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.tags,_that.terrain,_that.scores,_that.favoriteCount,_that.viewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String province,  String? photoUrl,  List<String> tags,  List<Terrain> terrain,  MetricScores scores,  int favoriteCount,  int viewCount)?  $default,) {final _that = this;
switch (_that) {
case _PopularRegion() when $default != null:
return $default(_that.id,_that.name,_that.province,_that.photoUrl,_that.tags,_that.terrain,_that.scores,_that.favoriteCount,_that.viewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularRegion implements PopularRegion {
  const _PopularRegion({required this.id, required this.name, required this.province, this.photoUrl,  List<String> tags = const <String>[],  List<Terrain> terrain = const <Terrain>[], required this.scores, required this.favoriteCount, required this.viewCount}): _tags = tags,_terrain = terrain;
  factory _PopularRegion.fromJson(Map<String, dynamic> json) => _$PopularRegionFromJson(json);

@override final  String id;
@override final  String name;
@override final  String province;
@override final  String? photoUrl;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<Terrain> _terrain;
@override@JsonKey() List<Terrain> get terrain {
  if (_terrain is EqualUnmodifiableListView) return _terrain;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terrain);
}

@override final  MetricScores scores;
@override final  int favoriteCount;
@override final  int viewCount;

/// Create a copy of PopularRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularRegionCopyWith<_PopularRegion> get copyWith => __$PopularRegionCopyWithImpl<_PopularRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularRegionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularRegion&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.province, province) || other.province == province)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.tags, _tags)&&const DeepCollectionEquality().equals(other.terrain, _terrain)&&(identical(other.scores, scores) || other.scores == scores)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,province,photoUrl,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_terrain),scores,favoriteCount,viewCount);
}

@override
String toString() {
    return 'PopularRegion(id: $id, name: $name, province: $province, photoUrl: $photoUrl, tags: $tags, terrain: $terrain, scores: $scores, favoriteCount: $favoriteCount, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class _$PopularRegionCopyWith<$Res> implements $PopularRegionCopyWith<$Res> {
  factory _$PopularRegionCopyWith(_PopularRegion value, $Res Function(_PopularRegion) _then) = __$PopularRegionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String province, String? photoUrl, List<String> tags, List<Terrain> terrain, MetricScores scores, int favoriteCount, int viewCount
});


@override $MetricScoresCopyWith<$Res> get scores;

}
/// @nodoc
class __$PopularRegionCopyWithImpl<$Res>
    implements _$PopularRegionCopyWith<$Res> {
  __$PopularRegionCopyWithImpl(this._self, this._then);

  final _PopularRegion _self;
  final $Res Function(_PopularRegion) _then;

/// Create a copy of PopularRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? province = null,Object? photoUrl = freezed,Object? tags = null,Object? terrain = null,Object? scores = null,Object? favoriteCount = null,Object? viewCount = null,}) {
  return _then(_PopularRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,terrain: null == terrain ? _self._terrain : terrain // ignore: cast_nullable_to_non_nullable
as List<Terrain>,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as MetricScores,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PopularRegion
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
mixin _$PopularResponse {

 String get month; String get asOf; List<PopularRegion> get items;
/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularResponseCopyWith<PopularResponse> get copyWith => _$PopularResponseCopyWithImpl<PopularResponse>(this as PopularResponse, _$identity);

  /// Serializes this PopularResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PopularResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularResponse&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.asOf, _this.asOf) || other.asOf == _this.asOf)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PopularResponse;
  return Object.hash(runtimeType,_this.month,_this.asOf,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as PopularResponse;
  return 'PopularResponse(month: ${_this.month}, asOf: ${_this.asOf}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $PopularResponseCopyWith<$Res>  {
  factory $PopularResponseCopyWith(PopularResponse value, $Res Function(PopularResponse) _then) = _$PopularResponseCopyWithImpl;
@useResult
$Res call({
 String month, String asOf, List<PopularRegion> items
});




}
/// @nodoc
class _$PopularResponseCopyWithImpl<$Res>
    implements $PopularResponseCopyWith<$Res> {
  _$PopularResponseCopyWithImpl(this._self, this._then);

  final PopularResponse _self;
  final $Res Function(PopularResponse) _then;

/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? asOf = null,Object? items = null,}) {
  return _then(PopularResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PopularRegion>,
  ));
}

}


/// Adds pattern-matching-related methods to [PopularResponse].
extension PopularResponsePatterns on PopularResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularResponse value)  $default,){
final _that = this;
switch (_that) {
case _PopularResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  String asOf,  List<PopularRegion> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
return $default(_that.month,_that.asOf,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  String asOf,  List<PopularRegion> items)  $default,) {final _that = this;
switch (_that) {
case _PopularResponse():
return $default(_that.month,_that.asOf,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  String asOf,  List<PopularRegion> items)?  $default,) {final _that = this;
switch (_that) {
case _PopularResponse() when $default != null:
return $default(_that.month,_that.asOf,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularResponse implements PopularResponse {
  const _PopularResponse({required this.month, required this.asOf, required  List<PopularRegion> items}): _items = items;
  factory _PopularResponse.fromJson(Map<String, dynamic> json) => _$PopularResponseFromJson(json);

@override final  String month;
@override final  String asOf;
 final  List<PopularRegion> _items;
@override List<PopularRegion> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularResponseCopyWith<_PopularResponse> get copyWith => __$PopularResponseCopyWithImpl<_PopularResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularResponse&&(identical(other.month, month) || other.month == month)&&(identical(other.asOf, asOf) || other.asOf == asOf)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,asOf,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'PopularResponse(month: $month, asOf: $asOf, items: $items)';
}


}

/// @nodoc
abstract mixin class _$PopularResponseCopyWith<$Res> implements $PopularResponseCopyWith<$Res> {
  factory _$PopularResponseCopyWith(_PopularResponse value, $Res Function(_PopularResponse) _then) = __$PopularResponseCopyWithImpl;
@override @useResult
$Res call({
 String month, String asOf, List<PopularRegion> items
});




}
/// @nodoc
class __$PopularResponseCopyWithImpl<$Res>
    implements _$PopularResponseCopyWith<$Res> {
  __$PopularResponseCopyWithImpl(this._self, this._then);

  final _PopularResponse _self;
  final $Res Function(_PopularResponse) _then;

/// Create a copy of PopularResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? asOf = null,Object? items = null,}) {
  return _then(_PopularResponse(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PopularRegion>,
  ));
}


}

// dart format on
