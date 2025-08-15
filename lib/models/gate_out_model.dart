import 'package:json_annotation/json_annotation.dart';

import 'gate_log_model.dart';

part 'gate_out_model.g.dart';

@JsonSerializable()
class GateOutModel {
  final GateLogModel gateLog;

  const GateOutModel({required this.gateLog});

  factory GateOutModel.fromJson(Map<String, dynamic> json) =>
      _$GateOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$GateOutModelToJson(this);
}
