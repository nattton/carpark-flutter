import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  const new({this.message, this.error});

  factory fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  final String? message;
  final String? error;

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
