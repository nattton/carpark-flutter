import 'package:carpark/shared/models/gate_log_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gate_in_model.g.dart';

@JsonSerializable()
class GateInModel {
  const GateInModel({required this.gateLog});

  factory GateInModel.fromJson(Map<String, dynamic> json) =>
      _$GateInModelFromJson(json);
  final GateLogModel gateLog;

  Map<String, dynamic> toJson() => _$GateInModelToJson(this);
}
