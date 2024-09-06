import 'package:carpark/models/vehicle_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
sealed class MemberModel with _$MemberModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory MemberModel({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String telephone,
    @Default("") String address,
    @Default("") String type,
    @Default("") String status,
    @Default("") String plateVehicles,
    @Default([]) List<VehicleModel>? vehicles,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}
