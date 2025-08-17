// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_member_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateMemberRequest {

 String? get name; String? get telephone; String? get type; String? get status;
/// Create a copy of UpdateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMemberRequestCopyWith<UpdateMemberRequest> get copyWith => _$UpdateMemberRequestCopyWithImpl<UpdateMemberRequest>(this as UpdateMemberRequest, _$identity);

  /// Serializes this UpdateMemberRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMemberRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,telephone,type,status);

@override
String toString() {
  return 'UpdateMemberRequest(name: $name, telephone: $telephone, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class $UpdateMemberRequestCopyWith<$Res>  {
  factory $UpdateMemberRequestCopyWith(UpdateMemberRequest value, $Res Function(UpdateMemberRequest) _then) = _$UpdateMemberRequestCopyWithImpl;
@useResult
$Res call({
 String? name, String? telephone, String? type, String? status
});




}
/// @nodoc
class _$UpdateMemberRequestCopyWithImpl<$Res>
    implements $UpdateMemberRequestCopyWith<$Res> {
  _$UpdateMemberRequestCopyWithImpl(this._self, this._then);

  final UpdateMemberRequest _self;
  final $Res Function(UpdateMemberRequest) _then;

/// Create a copy of UpdateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? telephone = freezed,Object? type = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateMemberRequest].
extension UpdateMemberRequestPatterns on UpdateMemberRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateMemberRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateMemberRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateMemberRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateMemberRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateMemberRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateMemberRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? telephone,  String? type,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateMemberRequest() when $default != null:
return $default(_that.name,_that.telephone,_that.type,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? telephone,  String? type,  String? status)  $default,) {final _that = this;
switch (_that) {
case _UpdateMemberRequest():
return $default(_that.name,_that.telephone,_that.type,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? telephone,  String? type,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _UpdateMemberRequest() when $default != null:
return $default(_that.name,_that.telephone,_that.type,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateMemberRequest implements UpdateMemberRequest {
  const _UpdateMemberRequest({this.name, this.telephone, this.type, this.status});
  factory _UpdateMemberRequest.fromJson(Map<String, dynamic> json) => _$UpdateMemberRequestFromJson(json);

@override final  String? name;
@override final  String? telephone;
@override final  String? type;
@override final  String? status;

/// Create a copy of UpdateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMemberRequestCopyWith<_UpdateMemberRequest> get copyWith => __$UpdateMemberRequestCopyWithImpl<_UpdateMemberRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateMemberRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMemberRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,telephone,type,status);

@override
String toString() {
  return 'UpdateMemberRequest(name: $name, telephone: $telephone, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UpdateMemberRequestCopyWith<$Res> implements $UpdateMemberRequestCopyWith<$Res> {
  factory _$UpdateMemberRequestCopyWith(_UpdateMemberRequest value, $Res Function(_UpdateMemberRequest) _then) = __$UpdateMemberRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? telephone, String? type, String? status
});




}
/// @nodoc
class __$UpdateMemberRequestCopyWithImpl<$Res>
    implements _$UpdateMemberRequestCopyWith<$Res> {
  __$UpdateMemberRequestCopyWithImpl(this._self, this._then);

  final _UpdateMemberRequest _self;
  final $Res Function(_UpdateMemberRequest) _then;

/// Create a copy of UpdateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? telephone = freezed,Object? type = freezed,Object? status = freezed,}) {
  return _then(_UpdateMemberRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
