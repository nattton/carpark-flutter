import 'package:json_annotation/json_annotation.dart';

part 'report_traffic_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportTrafficModel {
  final int id;
  final String name;
  final int vehicleId;
  final String plateNumber;
  final int traffic;

  ReportTrafficModel(
      {required this.id,
      required this.name,
      required this.vehicleId,
      required this.plateNumber,
      required this.traffic});

  factory ReportTrafficModel.fromJson(Map<String, dynamic> json) =>
      _$ReportTrafficModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTrafficModelToJson(this);
}
