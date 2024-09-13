import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'null_time_model.g.dart';

@JsonSerializable()
class NullTimeModel {
  @JsonKey(name: "Time")
  DateTime time;
  @JsonKey(name: "Valid")
  bool valid;

  NullTimeModel(this.time, this.valid);

  factory NullTimeModel.fromJson(Map<String, dynamic> json) =>
      _$NullTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NullTimeModelToJson(this);

  String toDate() {
    if (!valid) return "";
    DateTime dt = time.add(const Duration(hours: 7));
    return DateFormat("yyyy-MM-dd").format(dt);
  }

  String toDateTime() {
    if (!valid) return "";
    DateTime dt = time.add(const Duration(hours: 7));
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
  }
}
