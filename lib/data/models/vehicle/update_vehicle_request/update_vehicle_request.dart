import 'package:json_annotation/json_annotation.dart';

part 'update_vehicle_request.g.dart';

@JsonSerializable()
class UpdateVehicleRequest {
  const new({
    this.id,
    this.memberId,
    this.plateNumber,
    this.plateProvince,
    this.brand,
    this.color,
    this.telephone,
    this.resemble,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$UpdateVehicleRequestFromJson(json);

  final int? id;
  final int? memberId;
  final String? plateNumber;
  final String? plateProvince;
  final String? brand;
  final String? color;
  final String? telephone;
  final String? resemble;

  Map<String, dynamic> toJson() => _$UpdateVehicleRequestToJson(this);
}
