import 'package:carpark/models/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MemberModel {
  int? id;
  String? name;
  String? telephone;
  String? type;
  String? status;
  String? stringVehicles;
  List<VehicleModel>? vehicles;

  MemberModel(
      {this.id,
      this.name,
      this.telephone,
      this.type,
      this.status,
      this.stringVehicles,
      this.vehicles});

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  void setMember(MemberModel member) {
    id = member.id;
    name = member.name;
    telephone = member.telephone;
    type = member.type;
    status = member.status;
    stringVehicles = member.stringVehicles;
    vehicles = member.vehicles;
  }
}
