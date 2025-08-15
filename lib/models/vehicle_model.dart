import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  int? id;
  int? memberId;
  String? plateNumber;
  String? plateProvince;
  String? brand;
  String? color;
  String? telephone;
  String? resemble;

  VehicleModel({
    this.id,
    this.memberId,
    this.plateNumber,
    this.plateProvince,
    this.brand,
    this.color,
    this.telephone,
    this.resemble,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
