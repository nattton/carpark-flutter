// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_member_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateMemberRequest {

 String? get name; String? get telephone; String? get type; String? get status;
/// Create a copy of CreateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMemberRequestCopyWith<CreateMemberRequest> get copyWith => _$CreateMemberRequestCopyWithImpl<CreateMemberRequest>(this as CreateMemberRequest, _$identity);

  /// Serializes this CreateMemberRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMemberRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,telephone,type,status);

@override
String toString() {
  return 'CreateMemberRequest(name: $name, telephone: $telephone, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class $CreateMemberRequestCopyWith<$Res>  {
  factory $CreateMemberRequestCopyWith(CreateMemberRequest value, $Res Function(CreateMemberRequest) _then) = _$CreateMemberRequestCopyWithImpl;
@useResult
$Res call({
 String? name, String? telephone, String? type, String? status
});




}
/// @nodoc
class _$CreateMemberRequestCopyWithImpl<$Res>
    implements $CreateMemberRequestCopyWith<$Res> {
  _$CreateMemberRequestCopyWithImpl(this._self, this._then);

  final CreateMemberRequest _self;
  final $Res Function(CreateMemberRequest) _then;

/// Create a copy of CreateMemberRequest
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


/// Adds pattern-matching-related methods to [CreateMemberRequest].
extension CreateMemberRequestPatterns on CreateMemberRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateMemberRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateMemberRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateMemberRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateMemberRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateMemberRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateMemberRequest() when $default != null:
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
case _CreateMemberRequest() when $default != null:
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
case _CreateMemberRequest():
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
case _CreateMemberRequest() when $default != null:
return $default(_that.name,_that.telephone,_that.type,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateMemberRequest implements CreateMemberRequest {
  const _CreateMemberRequest({this.name, this.telephone, this.type, this.status});
  factory _CreateMemberRequest.fromJson(Map<String, dynamic> json) => _$CreateMemberRequestFromJson(json);

@override final  String? name;
@override final  String? telephone;
@override final  String? type;
@override final  String? status;

/// Create a copy of CreateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateMemberRequestCopyWith<_CreateMemberRequest> get copyWith => __$CreateMemberRequestCopyWithImpl<_CreateMemberRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateMemberRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateMemberRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,telephone,type,status);

@override
String toString() {
  return 'CreateMemberRequest(name: $name, telephone: $telephone, type: $type, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CreateMemberRequestCopyWith<$Res> implements $CreateMemberRequestCopyWith<$Res> {
  factory _$CreateMemberRequestCopyWith(_CreateMemberRequest value, $Res Function(_CreateMemberRequest) _then) = __$CreateMemberRequestCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? telephone, String? type, String? status
});




}
/// @nodoc
class __$CreateMemberRequestCopyWithImpl<$Res>
    implements _$CreateMemberRequestCopyWith<$Res> {
  __$CreateMemberRequestCopyWithImpl(this._self, this._then);

  final _CreateMemberRequest _self;
  final $Res Function(_CreateMemberRequest) _then;

/// Create a copy of CreateMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? telephone = freezed,Object? type = freezed,Object? status = freezed,}) {
  return _then(_CreateMemberRequest(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
