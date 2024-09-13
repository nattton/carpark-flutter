import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

@freezed
sealed class VehicleModel with _$VehicleModel {
  const VehicleModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory VehicleModel({
    @Default(0) int id,
    @Default(0) int memberId,
    @Default("") String plateNumber,
    @Default("") String plateProvince,
    @Default("") String brand,
    @Default("") String color,
    @Default("") String telephone,
    @Default("") String resemble,
    MemberModel? member,
    NullTimeModel? inTime,
    NullTimeModel? outTime,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  String inTimeFormat() {
    if (inTime!.valid) {
      DateTime dt = inTime!.time.add(const Duration(hours: 7));
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
    }
    return "";
  }

  String outTimeFormat() {
    if (outTime!.valid) {
      DateTime dt = outTime!.time.add(const Duration(hours: 7));
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
    }
    return "";
  }
}
