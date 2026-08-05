import 'package:json_annotation/json_annotation.dart';

part 'report_traffic_model.g.dart';

@JsonSerializable()
class ReportTrafficModel {
  ReportTrafficModel({
    required this.id,
    required this.name,
    required this.vehicleId,
    required this.plateNumber,
    required this.traffic,
  });

  factory ReportTrafficModel.fromJson(Map<String, dynamic> json) =>
      _$ReportTrafficModelFromJson(json);
  final int id;
  final String name;
  final int vehicleId;
  final String plateNumber;
  final int traffic;

  Map<String, dynamic> toJson() => _$ReportTrafficModelToJson(this);
}
