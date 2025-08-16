// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_member_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetMemberResponse {

 int? get id; String? get name; String? get telephone; String? get type; String? get status; List<VehicleResponse>? get vehicles;
/// Create a copy of GetMemberResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetMemberResponseCopyWith<GetMemberResponse> get copyWith => _$GetMemberResponseCopyWithImpl<GetMemberResponse>(this as GetMemberResponse, _$identity);

  /// Serializes this GetMemberResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetMemberResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.vehicles, vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,telephone,type,status,const DeepCollectionEquality().hash(vehicles));

@override
String toString() {
  return 'GetMemberResponse(id: $id, name: $name, telephone: $telephone, type: $type, status: $status, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $GetMemberResponseCopyWith<$Res>  {
  factory $GetMemberResponseCopyWith(GetMemberResponse value, $Res Function(GetMemberResponse) _then) = _$GetMemberResponseCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? telephone, String? type, String? status, List<VehicleResponse>? vehicles
});




}
/// @nodoc
class _$GetMemberResponseCopyWithImpl<$Res>
    implements $GetMemberResponseCopyWith<$Res> {
  _$GetMemberResponseCopyWithImpl(this._self, this._then);

  final GetMemberResponse _self;
  final $Res Function(GetMemberResponse) _then;

/// Create a copy of GetMemberResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? telephone = freezed,Object? type = freezed,Object? status = freezed,Object? vehicles = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,vehicles: freezed == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<VehicleResponse>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetMemberResponse].
extension GetMemberResponsePatterns on GetMemberResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetMemberResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetMemberResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetMemberResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetMemberResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetMemberResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetMemberResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  String? telephone,  String? type,  String? status,  List<VehicleResponse>? vehicles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetMemberResponse() when $default != null:
return $default(_that.id,_that.name,_that.telephone,_that.type,_that.status,_that.vehicles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  String? telephone,  String? type,  String? status,  List<VehicleResponse>? vehicles)  $default,) {final _that = this;
switch (_that) {
case _GetMemberResponse():
return $default(_that.id,_that.name,_that.telephone,_that.type,_that.status,_that.vehicles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  String? telephone,  String? type,  String? status,  List<VehicleResponse>? vehicles)?  $default,) {final _that = this;
switch (_that) {
case _GetMemberResponse() when $default != null:
return $default(_that.id,_that.name,_that.telephone,_that.type,_that.status,_that.vehicles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetMemberResponse extends GetMemberResponse {
  const _GetMemberResponse({this.id, this.name, this.telephone, this.type, this.status, final  List<VehicleResponse>? vehicles}): _vehicles = vehicles,super._();
  factory _GetMemberResponse.fromJson(Map<String, dynamic> json) => _$GetMemberResponseFromJson(json);

@override final  int? id;
@override final  String? name;
@override final  String? telephone;
@override final  String? type;
@override final  String? status;
 final  List<VehicleResponse>? _vehicles;
@override List<VehicleResponse>? get vehicles {
  final value = _vehicles;
  if (value == null) return null;
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of GetMemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetMemberResponseCopyWith<_GetMemberResponse> get copyWith => __$GetMemberResponseCopyWithImpl<_GetMemberResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetMemberResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetMemberResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,telephone,type,status,const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'GetMemberResponse(id: $id, name: $name, telephone: $telephone, type: $type, status: $status, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class _$GetMemberResponseCopyWith<$Res> implements $GetMemberResponseCopyWith<$Res> {
  factory _$GetMemberResponseCopyWith(_GetMemberResponse value, $Res Function(_GetMemberResponse) _then) = __$GetMemberResponseCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? telephone, String? type, String? status, List<VehicleResponse>? vehicles
});




}
/// @nodoc
class __$GetMemberResponseCopyWithImpl<$Res>
    implements _$GetMemberResponseCopyWith<$Res> {
  __$GetMemberResponseCopyWithImpl(this._self, this._then);

  final _GetMemberResponse _self;
  final $Res Function(_GetMemberResponse) _then;

/// Create a copy of GetMemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? telephone = freezed,Object? type = freezed,Object? status = freezed,Object? vehicles = freezed,}) {
  return _then(_GetMemberResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,telephone: freezed == telephone ? _self.telephone : telephone // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,vehicles: freezed == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<VehicleResponse>?,
  ));
}


}


/// @nodoc
mixin _$VehicleResponse {

 int? get id; int? get memberId; String? get plateNumber; String? get plateProvince; String? get brand; String? get color; String? get telephone; String? get resemble;
/// Create a copy of VehicleResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleResponseCopyWith<VehicleResponse> get copyWith => _$VehicleResponseCopyWithImpl<VehicleResponse>(this as VehicleResponse, _$identity);

  /// Serializes this VehicleResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'VehicleResponse(id: $id, memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class $VehicleResponseCopyWith<$Res>  {
  factory $VehicleResponseCopyWith(VehicleResponse value, $Res Function(VehicleResponse) _then) = _$VehicleResponseCopyWithImpl;
@useResult
$Res call({
 int? id, int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class _$VehicleResponseCopyWithImpl<$Res>
    implements $VehicleResponseCopyWith<$Res> {
  _$VehicleResponseCopyWithImpl(this._self, this._then);

  final VehicleResponse _self;
  final $Res Function(VehicleResponse) _then;

/// Create a copy of VehicleResponse
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


/// Adds pattern-matching-related methods to [VehicleResponse].
extension VehicleResponsePatterns on VehicleResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleResponse value)  $default,){
final _that = this;
switch (_that) {
case _VehicleResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleResponse() when $default != null:
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
case _VehicleResponse() when $default != null:
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
case _VehicleResponse():
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
case _VehicleResponse() when $default != null:
return $default(_that.id,_that.memberId,_that.plateNumber,_that.plateProvince,_that.brand,_that.color,_that.telephone,_that.resemble);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleResponse implements VehicleResponse {
  const _VehicleResponse({this.id, this.memberId, this.plateNumber, this.plateProvince, this.brand, this.color, this.telephone, this.resemble});
  factory _VehicleResponse.fromJson(Map<String, dynamic> json) => _$VehicleResponseFromJson(json);

@override final  int? id;
@override final  int? memberId;
@override final  String? plateNumber;
@override final  String? plateProvince;
@override final  String? brand;
@override final  String? color;
@override final  String? telephone;
@override final  String? resemble;

/// Create a copy of VehicleResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleResponseCopyWith<_VehicleResponse> get copyWith => __$VehicleResponseCopyWithImpl<_VehicleResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.plateProvince, plateProvince) || other.plateProvince == plateProvince)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.color, color) || other.color == color)&&(identical(other.telephone, telephone) || other.telephone == telephone)&&(identical(other.resemble, resemble) || other.resemble == resemble));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,plateNumber,plateProvince,brand,color,telephone,resemble);

@override
String toString() {
  return 'VehicleResponse(id: $id, memberId: $memberId, plateNumber: $plateNumber, plateProvince: $plateProvince, brand: $brand, color: $color, telephone: $telephone, resemble: $resemble)';
}


}

/// @nodoc
abstract mixin class _$VehicleResponseCopyWith<$Res> implements $VehicleResponseCopyWith<$Res> {
  factory _$VehicleResponseCopyWith(_VehicleResponse value, $Res Function(_VehicleResponse) _then) = __$VehicleResponseCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? memberId, String? plateNumber, String? plateProvince, String? brand, String? color, String? telephone, String? resemble
});




}
/// @nodoc
class __$VehicleResponseCopyWithImpl<$Res>
    implements _$VehicleResponseCopyWith<$Res> {
  __$VehicleResponseCopyWithImpl(this._self, this._then);

  final _VehicleResponse _self;
  final $Res Function(_VehicleResponse) _then;

/// Create a copy of VehicleResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? memberId = freezed,Object? plateNumber = freezed,Object? plateProvince = freezed,Object? brand = freezed,Object? color = freezed,Object? telephone = freezed,Object? resemble = freezed,}) {
  return _then(_VehicleResponse(
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
