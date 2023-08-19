import 'package:json_annotation/json_annotation.dart';

part 'null_time_model.g.dart';

@JsonSerializable()
class NullTimeModel {
  @JsonKey(name: "Time")
  DateTime? time;
  @JsonKey(name: "Valid")
  bool? valid;

  NullTimeModel(
    this.time, {
    this.valid,
  });

  factory NullTimeModel.fromJson(Map<String, dynamic> json) =>
      _$NullTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NullTimeModelToJson(this);
}
