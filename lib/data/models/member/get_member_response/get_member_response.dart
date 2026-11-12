import 'package:carpark/domain/models/member_model.dart';
import 'package:carpark/domain/models/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_member_response.g.dart';

@JsonSerializable()
class GetMemberResponse {
  const new({
    this.id,
    this.name,
    this.telephone,
    this.type,
    this.status,
    this.vehicles,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$GetMemberResponseFromJson(json);

  final int? id;
  final String? name;
  final String? telephone;
  final String? type;
  final String? status;
  final List<VehicleResponse>? vehicles;

  Map<String, dynamic> toJson() => _$GetMemberResponseToJson(this);

  MemberModel toDomain() => MemberModel(
    id: id ?? 0,
    name: name,
    telephone: telephone,
    type: type,
    status: status,
    vehicles: vehicles
        ?.map(
          (e) => VehicleModel(
            id: e.id,
            plateNumber: e.plateNumber,
            plateProvince: e.plateProvince,
            brand: e.brand,
            color: e.color,
            telephone: e.telephone,
            resemble: e.resemble,
          ),
        )
        .toList(),
  );
}

@JsonSerializable()
class VehicleResponse {
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
      _$VehicleResponseFromJson(json);

  final int? id;
  final int? memberId;
  final String? plateNumber;
  final String? plateProvince;
  final String? brand;
  final String? color;
  final String? telephone;
  final String? resemble;

  Map<String, dynamic> toJson() => _$VehicleResponseToJson(this);
}
