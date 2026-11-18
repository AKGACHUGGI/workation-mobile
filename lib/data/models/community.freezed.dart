// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

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
mixin _$Tip {

 String get id; TipAuthor get author;/// ISO 8601
 String get createdAt; String? get dongName;/// 예: `2주 체류`
 String? get stayLabel;/// `2025-10`
 String? get visitMonth; String get body; int get helpful; int get replies;
/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipCopyWith<Tip> get copyWith => _$TipCopyWithImpl<Tip>(this as Tip, _$identity);

  /// Serializes this Tip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Tip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.dongName, _this.dongName) || other.dongName == _this.dongName)&&(identical(other.stayLabel, _this.stayLabel) || other.stayLabel == _this.stayLabel)&&(identical(other.visitMonth, _this.visitMonth) || other.visitMonth == _this.visitMonth)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.helpful, _this.helpful) || other.helpful == _this.helpful)&&(identical(other.replies, _this.replies) || other.replies == _this.replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Tip;
  return Object.hash(runtimeType,_this.id,_this.author,_this.createdAt,_this.dongName,_this.stayLabel,_this.visitMonth,_this.body,_this.helpful,_this.replies);
}

@override
String toString() {
  final _this = this as Tip;
  return 'Tip(id: ${_this.id}, author: ${_this.author}, createdAt: ${_this.createdAt}, dongName: ${_this.dongName}, stayLabel: ${_this.stayLabel}, visitMonth: ${_this.visitMonth}, body: ${_this.body}, helpful: ${_this.helpful}, replies: ${_this.replies})';
}


}

/// @nodoc
abstract mixin class $TipCopyWith<$Res>  {
  factory $TipCopyWith(Tip value, $Res Function(Tip) _then) = _$TipCopyWithImpl;
@useResult
$Res call({
 String id, TipAuthor author, String createdAt, String? dongName, String? stayLabel, String? visitMonth, String body, int helpful, int replies
});


$TipAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$TipCopyWithImpl<$Res>
    implements $TipCopyWith<$Res> {
  _$TipCopyWithImpl(this._self, this._then);

  final Tip _self;
  final $Res Function(Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? dongName = freezed,Object? stayLabel = freezed,Object? visitMonth = freezed,Object? body = null,Object? helpful = null,Object? replies = null,}) {
  return _then(Tip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as TipAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,dongName: freezed == dongName ? _self.dongName : dongName // ignore: cast_nullable_to_non_nullable
as String?,stayLabel: freezed == stayLabel ? _self.stayLabel : stayLabel // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,helpful: null == helpful ? _self.helpful : helpful // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipAuthorCopyWith<$Res> get author {
  
  return $TipAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Tip].
extension TipPatterns on Tip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tip value)  $default,){
final _that = this;
switch (_that) {
case _Tip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tip value)?  $default,){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies)  $default,) {final _that = this;
switch (_that) {
case _Tip():
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TipAuthor author,  String createdAt,  String? dongName,  String? stayLabel,  String? visitMonth,  String body,  int helpful,  int replies)?  $default,) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.dongName,_that.stayLabel,_that.visitMonth,_that.body,_that.helpful,_that.replies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tip implements Tip {
  const _Tip({required this.id, required this.author, required this.createdAt, this.dongName, this.stayLabel, this.visitMonth, required this.body, this.helpful = 0, this.replies = 0});
  factory _Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

@override final  String id;
@override final  TipAuthor author;
/// ISO 8601
@override final  String createdAt;
@override final  String? dongName;
/// 예: `2주 체류`
@override final  String? stayLabel;
/// `2025-10`
@override final  String? visitMonth;
@override final  String body;
@override@JsonKey() final  int helpful;
@override@JsonKey() final  int replies;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipCopyWith<_Tip> get copyWith => __$TipCopyWithImpl<_Tip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tip&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dongName, dongName) || other.dongName == dongName)&&(identical(other.stayLabel, stayLabel) || other.stayLabel == stayLabel)&&(identical(other.visitMonth, visitMonth) || other.visitMonth == visitMonth)&&(identical(other.body, body) || other.body == body)&&(identical(other.helpful, helpful) || other.helpful == helpful)&&(identical(other.replies, replies) || other.replies == replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,author,createdAt,dongName,stayLabel,visitMonth,body,helpful,replies);
}

@override
String toString() {
    return 'Tip(id: $id, author: $author, createdAt: $createdAt, dongName: $dongName, stayLabel: $stayLabel, visitMonth: $visitMonth, body: $body, helpful: $helpful, replies: $replies)';
}


}

/// @nodoc
abstract mixin class _$TipCopyWith<$Res> implements $TipCopyWith<$Res> {
  factory _$TipCopyWith(_Tip value, $Res Function(_Tip) _then) = __$TipCopyWithImpl;
@override @useResult
$Res call({
 String id, TipAuthor author, String createdAt, String? dongName, String? stayLabel, String? visitMonth, String body, int helpful, int replies
});


@override $TipAuthorCopyWith<$Res> get author;

}
/// @nodoc
class __$TipCopyWithImpl<$Res>
    implements _$TipCopyWith<$Res> {
  __$TipCopyWithImpl(this._self, this._then);

  final _Tip _self;
  final $Res Function(_Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? dongName = freezed,Object? stayLabel = freezed,Object? visitMonth = freezed,Object? body = null,Object? helpful = null,Object? replies = null,}) {
  return _then(_Tip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as TipAuthor,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,dongName: freezed == dongName ? _self.dongName : dongName // ignore: cast_nullable_to_non_nullable
as String?,stayLabel: freezed == stayLabel ? _self.stayLabel : stayLabel // ignore: cast_nullable_to_non_nullable
as String?,visitMonth: freezed == visitMonth ? _self.visitMonth : visitMonth // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,helpful: null == helpful ? _self.helpful : helpful // ignore: cast_nullable_to_non_nullable
as int,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipAuthorCopyWith<$Res> get author {
  
  return $TipAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$TipsResponse {

 int get total; List<Tip> get items; String? get nextCursor;
/// Create a copy of TipsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipsResponseCopyWith<TipsResponse> get copyWith => _$TipsResponseCopyWithImpl<TipsResponse>(this as TipsResponse, _$identity);

  /// Serializes this TipsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TipsResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipsResponse&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TipsResponse;
  return Object.hash(runtimeType,_this.total,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as TipsResponse;
  return 'TipsResponse(total: ${_this.total}, items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $TipsResponseCopyWith<$Res>  {
  factory $TipsResponseCopyWith(TipsResponse value, $Res Function(TipsResponse) _then) = _$TipsResponseCopyWithImpl;
@useResult
$Res call({
 int total, List<Tip> items, String? nextCursor
});




}
/// @nodoc
class _$TipsResponseCopyWithImpl<$Res>
    implements $TipsResponseCopyWith<$Res> {
  _$TipsResponseCopyWithImpl(this._self, this._then);

  final TipsResponse _self;
  final $Res Function(TipsResponse) _then;

/// Create a copy of TipsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? items = null,Object? nextCursor = freezed,}) {
  return _then(TipsResponse(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Tip>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TipsResponse].
extension TipsResponsePatterns on TipsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TipsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TipsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  List<Tip> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipsResponse() when $default != null:
return $default(_that.total,_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  List<Tip> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _TipsResponse():
return $default(_that.total,_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  List<Tip> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _TipsResponse() when $default != null:
return $default(_that.total,_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipsResponse implements TipsResponse {
  const _TipsResponse({required this.total,  List<Tip> items = const <Tip>[], this.nextCursor}): _items = items;
  factory _TipsResponse.fromJson(Map<String, dynamic> json) => _$TipsResponseFromJson(json);

@override final  int total;
 final  List<Tip> _items;
@override@JsonKey() List<Tip> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of TipsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipsResponseCopyWith<_TipsResponse> get copyWith => __$TipsResponseCopyWithImpl<_TipsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipsResponse&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'TipsResponse(total: $total, items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$TipsResponseCopyWith<$Res> implements $TipsResponseCopyWith<$Res> {
  factory _$TipsResponseCopyWith(_TipsResponse value, $Res Function(_TipsResponse) _then) = __$TipsResponseCopyWithImpl;
@override @useResult
$Res call({
 int total, List<Tip> items, String? nextCursor
});




}
/// @nodoc
class __$TipsResponseCopyWithImpl<$Res>
    implements _$TipsResponseCopyWith<$Res> {
  __$TipsResponseCopyWithImpl(this._self, this._then);

  final _TipsResponse _self;
  final $Res Function(_TipsResponse) _then;

/// Create a copy of TipsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_TipsResponse(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Tip>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserPhoto {

 String get url; String get author;
/// Create a copy of UserPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPhotoCopyWith<UserPhoto> get copyWith => _$UserPhotoCopyWithImpl<UserPhoto>(this as UserPhoto, _$identity);

  /// Serializes this UserPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserPhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPhoto&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.author, _this.author) || other.author == _this.author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserPhoto;
  return Object.hash(runtimeType,_this.url,_this.author);
}

@override
String toString() {
  final _this = this as UserPhoto;
  return 'UserPhoto(url: ${_this.url}, author: ${_this.author})';
}


}

/// @nodoc
abstract mixin class $UserPhotoCopyWith<$Res>  {
  factory $UserPhotoCopyWith(UserPhoto value, $Res Function(UserPhoto) _then) = _$UserPhotoCopyWithImpl;
@useResult
$Res call({
 String url, String author
});




}
/// @nodoc
class _$UserPhotoCopyWithImpl<$Res>
    implements $UserPhotoCopyWith<$Res> {
  _$UserPhotoCopyWithImpl(this._self, this._then);

  final UserPhoto _self;
  final $Res Function(UserPhoto) _then;

/// Create a copy of UserPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? author = null,}) {
  return _then(UserPhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPhoto].
extension UserPhotoPatterns on UserPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPhoto value)  $default,){
final _that = this;
switch (_that) {
case _UserPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _UserPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPhoto() when $default != null:
return $default(_that.url,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String author)  $default,) {final _that = this;
switch (_that) {
case _UserPhoto():
return $default(_that.url,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String author)?  $default,) {final _that = this;
switch (_that) {
case _UserPhoto() when $default != null:
return $default(_that.url,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPhoto implements UserPhoto {
  const _UserPhoto({required this.url, required this.author});
  factory _UserPhoto.fromJson(Map<String, dynamic> json) => _$UserPhotoFromJson(json);

@override final  String url;
@override final  String author;

/// Create a copy of UserPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPhotoCopyWith<_UserPhoto> get copyWith => __$UserPhotoCopyWithImpl<_UserPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPhoto&&(identical(other.url, url) || other.url == url)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,author);
}

@override
String toString() {
    return 'UserPhoto(url: $url, author: $author)';
}


}

/// @nodoc
abstract mixin class _$UserPhotoCopyWith<$Res> implements $UserPhotoCopyWith<$Res> {
  factory _$UserPhotoCopyWith(_UserPhoto value, $Res Function(_UserPhoto) _then) = __$UserPhotoCopyWithImpl;
@override @useResult
$Res call({
 String url, String author
});




}
/// @nodoc
class __$UserPhotoCopyWithImpl<$Res>
    implements _$UserPhotoCopyWith<$Res> {
  __$UserPhotoCopyWithImpl(this._self, this._then);

  final _UserPhoto _self;
  final $Res Function(_UserPhoto) _then;

/// Create a copy of UserPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? author = null,}) {
  return _then(_UserPhoto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PollResponse {

 String get question; int get yes; int get no; int get total; List<UserPhoto> get photos; PollChoice? get myVote;
/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollResponseCopyWith<PollResponse> get copyWith => _$PollResponseCopyWithImpl<PollResponse>(this as PollResponse, _$identity);

  /// Serializes this PollResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PollResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollResponse&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.yes, _this.yes) || other.yes == _this.yes)&&(identical(other.no, _this.no) || other.no == _this.no)&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.photos, _this.photos)&&(identical(other.myVote, _this.myVote) || other.myVote == _this.myVote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PollResponse;
  return Object.hash(runtimeType,_this.question,_this.yes,_this.no,_this.total,const DeepCollectionEquality().hash(_this.photos),_this.myVote);
}

@override
String toString() {
  final _this = this as PollResponse;
  return 'PollResponse(question: ${_this.question}, yes: ${_this.yes}, no: ${_this.no}, total: ${_this.total}, photos: ${_this.photos}, myVote: ${_this.myVote})';
}


}

/// @nodoc
abstract mixin class $PollResponseCopyWith<$Res>  {
  factory $PollResponseCopyWith(PollResponse value, $Res Function(PollResponse) _then) = _$PollResponseCopyWithImpl;
@useResult
$Res call({
 String question, int yes, int no, int total, List<UserPhoto> photos, PollChoice? myVote
});




}
/// @nodoc
class _$PollResponseCopyWithImpl<$Res>
    implements $PollResponseCopyWith<$Res> {
  _$PollResponseCopyWithImpl(this._self, this._then);

  final PollResponse _self;
  final $Res Function(PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? yes = null,Object? no = null,Object? total = null,Object? photos = null,Object? myVote = freezed,}) {
  return _then(PollResponse(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,yes: null == yes ? _self.yes : yes // ignore: cast_nullable_to_non_nullable
as int,no: null == no ? _self.no : no // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<UserPhoto>,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as PollChoice?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollResponse].
extension PollResponsePatterns on PollResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollResponse value)  $default,){
final _that = this;
switch (_that) {
case _PollResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  int yes,  int no,  int total,  List<UserPhoto> photos,  PollChoice? myVote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.question,_that.yes,_that.no,_that.total,_that.photos,_that.myVote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  int yes,  int no,  int total,  List<UserPhoto> photos,  PollChoice? myVote)  $default,) {final _that = this;
switch (_that) {
case _PollResponse():
return $default(_that.question,_that.yes,_that.no,_that.total,_that.photos,_that.myVote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  int yes,  int no,  int total,  List<UserPhoto> photos,  PollChoice? myVote)?  $default,) {final _that = this;
switch (_that) {
case _PollResponse() when $default != null:
return $default(_that.question,_that.yes,_that.no,_that.total,_that.photos,_that.myVote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollResponse extends PollResponse {
  const _PollResponse({this.question = '', required this.yes, required this.no, required this.total,  List<UserPhoto> photos = const <UserPhoto>[], this.myVote}): _photos = photos,super._();
  factory _PollResponse.fromJson(Map<String, dynamic> json) => _$PollResponseFromJson(json);

@override@JsonKey() final  String question;
@override final  int yes;
@override final  int no;
@override final  int total;
 final  List<UserPhoto> _photos;
@override@JsonKey() List<UserPhoto> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  PollChoice? myVote;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollResponseCopyWith<_PollResponse> get copyWith => __$PollResponseCopyWithImpl<_PollResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollResponse&&(identical(other.question, question) || other.question == question)&&(identical(other.yes, yes) || other.yes == yes)&&(identical(other.no, no) || other.no == no)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.photos, _photos)&&(identical(other.myVote, myVote) || other.myVote == myVote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,question,yes,no,total,const DeepCollectionEquality().hash(_photos),myVote);
}

@override
String toString() {
    return 'PollResponse(question: $question, yes: $yes, no: $no, total: $total, photos: $photos, myVote: $myVote)';
}


}

/// @nodoc
abstract mixin class _$PollResponseCopyWith<$Res> implements $PollResponseCopyWith<$Res> {
  factory _$PollResponseCopyWith(_PollResponse value, $Res Function(_PollResponse) _then) = __$PollResponseCopyWithImpl;
@override @useResult
$Res call({
 String question, int yes, int no, int total, List<UserPhoto> photos, PollChoice? myVote
});




}
/// @nodoc
class __$PollResponseCopyWithImpl<$Res>
    implements _$PollResponseCopyWith<$Res> {
  __$PollResponseCopyWithImpl(this._self, this._then);

  final _PollResponse _self;
  final $Res Function(_PollResponse) _then;

/// Create a copy of PollResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? yes = null,Object? no = null,Object? total = null,Object? photos = null,Object? myVote = freezed,}) {
  return _then(_PollResponse(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,yes: null == yes ? _self.yes : yes // ignore: cast_nullable_to_non_nullable
as int,no: null == no ? _self.no : no // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<UserPhoto>,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as PollChoice?,
  ));
}


}

// dart format on
