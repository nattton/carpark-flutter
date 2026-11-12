import 'package:carpark/domain/models/gate_log_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gate_in_model.g.dart';

@JsonSerializable()
class GateInModel {
  const new({required this.gateLog});

  factory fromJson(Map<String, dynamic> json) =>
      _$GateInModelFromJson(json);
  final GateLogModel gateLog;

  Map<String, dynamic> toJson() => _$GateInModelToJson(this);
}
