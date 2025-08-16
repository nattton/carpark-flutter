// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_vehicle_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateVehicleRequest {

 int? get memberId; String? get plateNumber; String? get plateProvince; String? get brand; String? get color; String? get telephone; String? get resemble;
/// Create a copy of CreateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVehicleRequestCopyWith<CreateVehicleRequest> get copyWith => _$CreateVehicleRequestCopyWithImpl<CreateVehicleRequest>(this as CreateVehicleRequest, _$identity);

  /// Serializes this CreateVehicleRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVehicleRequest&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'CreateVehicleRequest(memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class $CreateVehicleRequestCopyWith<$Res>  {
  factory $CreateVehicleRequestCopyWith(CreateVehicleRequest value, $Res Function(CreateVehicleRequest) _then) = _$CreateVehicleRequestCopyWithImpl;
@useResult
$Res call({
 int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class _$CreateVehicleRequestCopyWithImpl<$Res>
    implements $CreateVehicleRequestCopyWith<$Res> {
  _$CreateVehicleRequestCopyWithImpl(this._self, this._then);

  final CreateVehicleRequest _self;
  final $Res Function(CreateVehicleRequest) _then;

/// Create a copy of CreateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = freezed,Object? plateNumber = freezed,Object? plateProvince = freezed,Object? brand = freezed,Object? color = freezed,Object? telephone = freezed,Object? resemble = freezed,}) {
  return _then(_self.copyWith(
memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,plateNumber: freezed == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String?,plateProvince: freezed == plateProvince ? _self.plateProvince : plateProvince // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,resemble: freezed == resemble ? _self.resemble : resemble // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVehicleRequest].
extension CreateVehicleRequestPatterns on CreateVehicleRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVehicleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVehicleRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVehicleRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateVehicleRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVehicleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVehicleRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVehicleRequest() when $default != null:
return $default(_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)  $default,) {final _that = this;
switch (_that) {
case _CreateVehicleRequest():
return $default(_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)?  $default,) {final _that = this;
switch (_that) {
case _CreateVehicleRequest() when $default != null:
return $default(_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateVehicleRequest implements CreateVehicleRequest {
  const _CreateVehicleRequest({this.memberId, this.plateNumber, this.plateProvince, this.brand, this.color, this.telephone, this.resemble});
  factory _CreateVehicleRequest.fromJson(Map<String, dynamic> json) => _$CreateVehicleRequestFromJson(json);

@override final  int? memberId;
@override final  String? plateNumber;
@override final  String? plateProvince;
@override final  String? brand;
@override final  String? color;
@override final  String? telephone;
@override final  String? resemble;

/// Create a copy of CreateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVehicleRequestCopyWith<_CreateVehicleRequest> get copyWith => __$CreateVehicleRequestCopyWithImpl<_CreateVehicleRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVehicleRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVehicleRequest&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'CreateVehicleRequest(memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class _$CreateVehicleRequestCopyWith<$Res> implements $CreateVehicleRequestCopyWith<$Res> {
  factory _$CreateVehicleRequestCopyWith(_CreateVehicleRequest value, $Res Function(_CreateVehicleRequest) _then) = __$CreateVehicleRequestCopyWithImpl;
@override @useResult
$Res call({
 int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class __$CreateVehicleRequestCopyWithImpl<$Res>
    implements _$CreateVehicleRequestCopyWith<$Res> {
  __$CreateVehicleRequestCopyWithImpl(this._self, this._then);

  final _CreateVehicleRequest _self;
  final $Res Function(_CreateVehicleRequest) _then;

/// Create a copy of CreateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = freezed,Object? plateNumber = freezed,Object? plateProvince = freezed,Object? brand = freezed,Object? color = freezed,Object? telephone = freezed,Object? resemble = freezed,}) {
  return _then(_CreateVehicleRequest(
memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,plateNumber: freezed == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String?,plateProvince: freezed == plateProvince ? _self.plateProvince : plateProvince // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,resemble: freezed == resemble ? _self.resemble : resemble // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
