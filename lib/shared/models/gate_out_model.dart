import 'package:carpark/shared/models/gate_log_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gate_out_model.g.dart';

@JsonSerializable()
class GateOutModel {
  const GateOutModel({required this.gateLog});

  factory GateOutModel.fromJson(Map<String, dynamic> json) =>
      _$GateOutModelFromJson(json);
  final GateLogModel gateLog;

  Map<String, dynamic> toJson() => _$GateOutModelToJson(this);
}
