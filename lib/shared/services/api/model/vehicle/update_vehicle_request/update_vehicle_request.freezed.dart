// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_vehicle_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateVehicleRequest {

 int? get id; int? get memberId; String? get plateNumber; String? get plateProvince; String? get brand; String? get color; String? get telephone; String? get resemble;
/// Create a copy of UpdateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateVehicleRequestCopyWith<UpdateVehicleRequest> get copyWith => _$UpdateVehicleRequestCopyWithImpl<UpdateVehicleRequest>(this as UpdateVehicleRequest, _$identity);

  /// Serializes this UpdateVehicleRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateVehicleRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'UpdateVehicleRequest(id: $id, memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class $UpdateVehicleRequestCopyWith<$Res>  {
  factory $UpdateVehicleRequestCopyWith(UpdateVehicleRequest value, $Res Function(UpdateVehicleRequest) _then) = _$UpdateVehicleRequestCopyWithImpl;
@useResult
$Res call({
 int? id, int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class _$UpdateVehicleRequestCopyWithImpl<$Res>
    implements $UpdateVehicleRequestCopyWith<$Res> {
  _$UpdateVehicleRequestCopyWithImpl(this._self, this._then);

  final UpdateVehicleRequest _self;
  final $Res Function(UpdateVehicleRequest) _then;

/// Create a copy of UpdateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? memberId = freezed,Object? plateNumber = freezed,Object? plateProvince = freezed,Object? brand = freezed,Object? color = freezed,Object? telephone = freezed,Object? resemble = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [UpdateVehicleRequest].
extension UpdateVehicleRequestPatterns on UpdateVehicleRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateVehicleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateVehicleRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateVehicleRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateVehicleRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateVehicleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateVehicleRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateVehicleRequest() when $default != null:
return $default(_that.id,_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)  $default,) {final _that = this;
switch (_that) {
case _UpdateVehicleRequest():
return $default(_that.id,_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? memberId,  String? plateNumber,  String? plateProvince,  String? brand,  String? color,  String? telephone,  String? resemble)?  $default,) {final _that = this;
switch (_that) {
case _UpdateVehicleRequest() when $default != null:
return $default(_that.id,_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateVehicleRequest implements UpdateVehicleRequest {
  const _UpdateVehicleRequest({this.id, this.memberId, this.plateNumber, this.plateProvince, this.brand, this.color, this.telephone, this.resemble});
  factory _UpdateVehicleRequest.fromJson(Map<String, dynamic> json) => _$UpdateVehicleRequestFromJson(json);

@override final  int? id;
@override final  int? memberId;
@override final  String? plateNumber;
@override final  String? plateProvince;
@override final  String? brand;
@override final  String? color;
@override final  String? telephone;
@override final  String? resemble;

/// Create a copy of UpdateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateVehicleRequestCopyWith<_UpdateVehicleRequest> get copyWith => __$UpdateVehicleRequestCopyWithImpl<_UpdateVehicleRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateVehicleRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateVehicleRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'UpdateVehicleRequest(id: $id, memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class _$UpdateVehicleRequestCopyWith<$Res> implements $UpdateVehicleRequestCopyWith<$Res> {
  factory _$UpdateVehicleRequestCopyWith(_UpdateVehicleRequest value, $Res Function(_UpdateVehicleRequest) _then) = __$UpdateVehicleRequestCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class __$UpdateVehicleRequestCopyWithImpl<$Res>
    implements _$UpdateVehicleRequestCopyWith<$Res> {
  __$UpdateVehicleRequestCopyWithImpl(this._self, this._then);

  final _UpdateVehicleRequest _self;
  final $Res Function(_UpdateVehicleRequest) _then;

/// Create a copy of UpdateVehicleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? plateNumber = freezed,Object? plateProvince = freezed,Object? brand = freezed,Object? color = freezed,Object? telephone = freezed,Object? resemble = freezed,}) {
  return _then(_UpdateVehicleRequest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
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
