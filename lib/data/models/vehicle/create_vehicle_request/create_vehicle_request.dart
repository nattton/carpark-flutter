import 'package:json_annotation/json_annotation.dart';

part 'create_vehicle_request.g.dart';

@JsonSerializable()
class CreateVehicleRequest {
  const new({
    this.memberId,
    this.plateNumber,
    this.plateProvince,
    this.brand,
    this.color,
    this.telephone,
    this.resemble,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$CreateVehicleRequestFromJson(json);

  final int? memberId;
  final String? plateNumber;
  final String? plateProvince;
  final String? brand;
  final String? color;
  final String? telephone;
  final String? resemble;

  Map<String, dynamic> toJson() => _$CreateVehicleRequestToJson(this);
}
