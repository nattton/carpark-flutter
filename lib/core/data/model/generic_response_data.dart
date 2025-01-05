import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_response_data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericResponseData<T> extends Equatable {
  final String? message;
  final T? data;

  const GenericResponseData({this.message, this.data});

  factory GenericResponseData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$GenericResponseDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$GenericResponseDataToJson(this, toJsonT);

  @override
  List<Object?> get props => [message, data];
}
