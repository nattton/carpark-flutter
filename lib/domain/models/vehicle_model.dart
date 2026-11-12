import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
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
      _$VehicleModelFromJson(json);

  final int? id;
  final int? memberId;
  final String? plateNumber;
  final String? plateProvince;
  final String? brand;
  final String? color;
  final String? telephone;
  final String? resemble;

  VehicleModel copyWith({
    int? id,
    int? memberId,
    String? plateNumber,
    String? plateProvince,
    String? brand,
    String? color,
    String? telephone,
    String? resemble,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      plateNumber: plateNumber ?? this.plateNumber,
      plateProvince: plateProvince ?? this.plateProvince,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      telephone: telephone ?? this.telephone,
      resemble: resemble ?? this.resemble,
    );
  }

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
