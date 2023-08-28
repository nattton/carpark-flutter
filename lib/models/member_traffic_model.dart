import 'package:json_annotation/json_annotation.dart';

part 'member_traffic_model.g.dart';

@JsonSerializable()
class MemberTrafficModel {
  final int id;
  final String name;
  final String plateNumber;
  final int traffic;

  MemberTrafficModel(
      {required this.id,
      required this.name,
      required this.plateNumber,
      required this.traffic});

  factory MemberTrafficModel.fromJson(Map<String, dynamic> json) =>
      _$MemberTrafficModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberTrafficModelToJson(this);
}
