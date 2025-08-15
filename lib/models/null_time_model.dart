import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'null_time_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NullTimeModel {
  @JsonKey(name: "Time")
  DateTime? time;
  @JsonKey(name: "Valid")
  bool? valid;

  NullTimeModel({this.time, this.valid});

  factory NullTimeModel.fromJson(Map<String, dynamic> json) =>
      _$NullTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NullTimeModelToJson(this);

  @override
  String toString() {
    if (time == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(time!);
  }

  String toDateString() {
    if (time == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd").format(time!);
  }

  String toDateTimeString() {
    if (valid == false || time == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(time!);
  }

  String toDateTimeNanoString() {
    if (valid == false || time == null) {
      return "";
    }
    return DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(time!);
  }

  NullTimeModel copyWith({DateTime? time, bool? valid}) {
    return NullTimeModel(time: time ?? this.time, valid: valid ?? this.valid);
  }
}
