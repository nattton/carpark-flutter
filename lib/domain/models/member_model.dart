import 'package:carpark/domain/models/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  const new({
    required this.id,
    this.name,
    this.telephone,
    this.type,
    this.status,
    this.vehicles,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  factory empty() => const MemberModel(id: 0);

  final int id;
  final String? name;
  final String? telephone;
  final String? type;
  final String? status;
  final List<VehicleModel>? vehicles;

  MemberModel copyWith({
    int? id,
    String? name,
    String? telephone,
    String? type,
    String? status,
    List<VehicleModel>? vehicles,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      type: type ?? this.type,
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
