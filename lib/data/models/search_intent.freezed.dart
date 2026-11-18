// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntentTag {

 IntentAxis get axis; String get label;
/// Create a copy of IntentTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntentTagCopyWith<IntentTag> get copyWith => _$IntentTagCopyWithImpl<IntentTag>(this as IntentTag, _$identity);

  /// Serializes this IntentTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as IntentTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntentTag&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as IntentTag;
  return Object.hash(runtimeType,_this.axis,_this.label);
}

@override
String toString() {
  final _this = this as IntentTag;
  return 'IntentTag(axis: ${_this.axis}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $IntentTagCopyWith<$Res>  {
  factory $IntentTagCopyWith(IntentTag value, $Res Function(IntentTag) _then) = _$IntentTagCopyWithImpl;
@useResult
$Res call({
 IntentAxis axis, String label
});




}
/// @nodoc
class _$IntentTagCopyWithImpl<$Res>
    implements $IntentTagCopyWith<$Res> {
  _$IntentTagCopyWithImpl(this._self, this._then);

  final IntentTag _self;
  final $Res Function(IntentTag) _then;

/// Create a copy of IntentTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? axis = null,Object? label = null,}) {
  return _then(IntentTag(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as IntentAxis,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IntentTag].
extension IntentTagPatterns on IntentTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntentTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntentTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntentTag value)  $default,){
final _that = this;
switch (_that) {
case _IntentTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntentTag value)?  $default,){
final _that = this;
switch (_that) {
case _IntentTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntentAxis axis,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntentTag() when $default != null:
return $default(_that.axis,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntentAxis axis,  String label)  $default,) {final _that = this;
switch (_that) {
case _IntentTag():
return $default(_that.axis,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntentAxis axis,  String label)?  $default,) {final _that = this;
switch (_that) {
case _IntentTag() when $default != null:
return $default(_that.axis,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntentTag implements IntentTag {
  const _IntentTag({required this.axis, required this.label});
  factory _IntentTag.fromJson(Map<String, dynamic> json) => _$IntentTagFromJson(json);

@override final  IntentAxis axis;
@override final  String label;

/// Create a copy of IntentTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntentTagCopyWith<_IntentTag> get copyWith => __$IntentTagCopyWithImpl<_IntentTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntentTagToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntentTag&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,axis,label);
}

@override
String toString() {
    return 'IntentTag(axis: $axis, label: $label)';
}


}

/// @nodoc
abstract mixin class _$IntentTagCopyWith<$Res> implements $IntentTagCopyWith<$Res> {
  factory _$IntentTagCopyWith(_IntentTag value, $Res Function(_IntentTag) _then) = __$IntentTagCopyWithImpl;
@override @useResult
$Res call({
 IntentAxis axis, String label
});




}
/// @nodoc
class __$IntentTagCopyWithImpl<$Res>
    implements _$IntentTagCopyWith<$Res> {
  __$IntentTagCopyWithImpl(this._self, this._then);

  final _IntentTag _self;
  final $Res Function(_IntentTag) _then;

/// Create a copy of IntentTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? axis = null,Object? label = null,}) {
  return _then(_IntentTag(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as IntentAxis,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SearchIntent {

/// `2025-10`
 String? get month;/// 계절처럼 여러 달일 때. 예: 봄 = `[3, 4, 5]`
 List<int>? get monthRange; PresetKey? get preset; List<Terrain>? get terrain; StayLength? get stay; bool? get peer; List<IntentTag> get tags;
/// Create a copy of SearchIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchIntentCopyWith<SearchIntent> get copyWith => _$SearchIntentCopyWithImpl<SearchIntent>(this as SearchIntent, _$identity);

  /// Serializes this SearchIntent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SearchIntent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchIntent&&(identical(other.month, _this.month) || other.month == _this.month)&&const DeepCollectionEquality().equals(other.monthRange, _this.monthRange)&&(identical(other.preset, _this.preset) || other.preset == _this.preset)&&const DeepCollectionEquality().equals(other.terrain, _this.terrain)&&(identical(other.stay, _this.stay) || other.stay == _this.stay)&&(identical(other.peer, _this.peer) || other.peer == _this.peer)&&const DeepCollectionEquality().equals(other.tags, _this.tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SearchIntent;
  return Object.hash(runtimeType,_this.month,const DeepCollectionEquality().hash(_this.monthRange),_this.preset,const DeepCollectionEquality().hash(_this.terrain),_this.stay,_this.peer,const DeepCollectionEquality().hash(_this.tags));
}

@override
String toString() {
  final _this = this as SearchIntent;
  return 'SearchIntent(month: ${_this.month}, monthRange: ${_this.monthRange}, preset: ${_this.preset}, terrain: ${_this.terrain}, stay: ${_this.stay}, peer: ${_this.peer}, tags: ${_this.tags})';
}


}

/// @nodoc
abstract mixin class $SearchIntentCopyWith<$Res>  {
  factory $SearchIntentCopyWith(SearchIntent value, $Res Function(SearchIntent) _then) = _$SearchIntentCopyWithImpl;
@useResult
$Res call({
 String? month, List<int>? monthRange, PresetKey? preset, List<Terrain>? terrain, StayLength? stay, bool? peer, List<IntentTag> tags
});




}
/// @nodoc
class _$SearchIntentCopyWithImpl<$Res>
    implements $SearchIntentCopyWith<$Res> {
  _$SearchIntentCopyWithImpl(this._self, this._then);

  final SearchIntent _self;
  final $Res Function(SearchIntent) _then;

/// Create a copy of SearchIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = freezed,Object? monthRange = freezed,Object? preset = freezed,Object? terrain = freezed,Object? stay = freezed,Object? peer = freezed,Object? tags = null,}) {
  return _then(SearchIntent(
month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,monthRange: freezed == monthRange ? _self.monthRange : monthRange // ignore: cast_nullable_to_non_nullable
as List<int>?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as PresetKey?,terrain: freezed == terrain ? _self.terrain : terrain // ignore: cast_nullable_to_non_nullable
as List<Terrain>?,stay: freezed == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as StayLength?,peer: freezed == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as bool?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<IntentTag>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchIntent].
extension SearchIntentPatterns on SearchIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchIntent value)  $default,){
final _that = this;
switch (_that) {
case _SearchIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchIntent value)?  $default,){
final _that = this;
switch (_that) {
case _SearchIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? month,  List<int>? monthRange,  PresetKey? preset,  List<Terrain>? terrain,  StayLength? stay,  bool? peer,  List<IntentTag> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchIntent() when $default != null:
return $default(_that.month,_that.monthRange,_that.preset,_that.terrain,_that.stay,_that.peer,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? month,  List<int>? monthRange,  PresetKey? preset,  List<Terrain>? terrain,  StayLength? stay,  bool? peer,  List<IntentTag> tags)  $default,) {final _that = this;
switch (_that) {
case _SearchIntent():
return $default(_that.month,_that.monthRange,_that.preset,_that.terrain,_that.stay,_that.peer,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? month,  List<int>? monthRange,  PresetKey? preset,  List<Terrain>? terrain,  StayLength? stay,  bool? peer,  List<IntentTag> tags)?  $default,) {final _that = this;
switch (_that) {
case _SearchIntent() when $default != null:
return $default(_that.month,_that.monthRange,_that.preset,_that.terrain,_that.stay,_that.peer,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchIntent extends SearchIntent {
  const _SearchIntent({this.month,  List<int>? monthRange, this.preset,  List<Terrain>? terrain, this.stay, this.peer,  List<IntentTag> tags = const <IntentTag>[]}): _monthRange = monthRange,_terrain = terrain,_tags = tags,super._();
  factory _SearchIntent.fromJson(Map<String, dynamic> json) => _$SearchIntentFromJson(json);

/// `2025-10`
@override final  String? month;
/// 계절처럼 여러 달일 때. 예: 봄 = `[3, 4, 5]`
 final  List<int>? _monthRange;
/// 계절처럼 여러 달일 때. 예: 봄 = `[3, 4, 5]`
@override List<int>? get monthRange {
  final value = _monthRange;
  if (value == null) return null;
  if (_monthRange is EqualUnmodifiableListView) return _monthRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  PresetKey? preset;
 final  List<Terrain>? _terrain;
@override List<Terrain>? get terrain {
  final value = _terrain;
  if (value == null) return null;
  if (_terrain is EqualUnmodifiableListView) return _terrain;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  StayLength? stay;
@override final  bool? peer;
 final  List<IntentTag> _tags;
@override@JsonKey() List<IntentTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of SearchIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchIntentCopyWith<_SearchIntent> get copyWith => __$SearchIntentCopyWithImpl<_SearchIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchIntentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchIntent&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.monthRange, _monthRange)&&(identical(other.preset, preset) || other.preset == preset)&&const DeepCollectionEquality().equals(other.terrain, _terrain)&&(identical(other.stay, stay) || other.stay == stay)&&(identical(other.peer, peer) || other.peer == peer)&&const DeepCollectionEquality().equals(other.tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,const DeepCollectionEquality().hash(_monthRange),preset,const DeepCollectionEquality().hash(_terrain),stay,peer,const DeepCollectionEquality().hash(_tags));
}

@override
String toString() {
    return 'SearchIntent(month: $month, monthRange: $monthRange, preset: $preset, terrain: $terrain, stay: $stay, peer: $peer, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$SearchIntentCopyWith<$Res> implements $SearchIntentCopyWith<$Res> {
  factory _$SearchIntentCopyWith(_SearchIntent value, $Res Function(_SearchIntent) _then) = __$SearchIntentCopyWithImpl;
@override @useResult
$Res call({
 String? month, List<int>? monthRange, PresetKey? preset, List<Terrain>? terrain, StayLength? stay, bool? peer, List<IntentTag> tags
});




}
/// @nodoc
class __$SearchIntentCopyWithImpl<$Res>
    implements _$SearchIntentCopyWith<$Res> {
  __$SearchIntentCopyWithImpl(this._self, this._then);

  final _SearchIntent _self;
  final $Res Function(_SearchIntent) _then;

/// Create a copy of SearchIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = freezed,Object? monthRange = freezed,Object? preset = freezed,Object? terrain = freezed,Object? stay = freezed,Object? peer = freezed,Object? tags = null,}) {
  return _then(_SearchIntent(
month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,monthRange: freezed == monthRange ? _self._monthRange : monthRange // ignore: cast_nullable_to_non_nullable
as List<int>?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as PresetKey?,terrain: freezed == terrain ? _self._terrain : terrain // ignore: cast_nullable_to_non_nullable
as List<Terrain>?,stay: freezed == stay ? _self.stay : stay // ignore: cast_nullable_to_non_nullable
as StayLength?,peer: freezed == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as bool?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<IntentTag>,
  ));
}


}

// dart format on
