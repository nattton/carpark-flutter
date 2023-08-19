import 'package:carpark/models/gate_log_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gate_out_model.g.dart';

@JsonSerializable()
class GateOutModel {
  GateLogModel gateLog;

  GateOutModel({required this.gateLog});

  factory GateOutModel.fromJson(Map<String, dynamic> json) =>
      _$GateOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$GateOutModelToJson(this);
}
