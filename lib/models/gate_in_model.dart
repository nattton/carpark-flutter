import 'package:json_annotation/json_annotation.dart';

import 'gate_log_model.dart';

part 'gate_in_model.g.dart';

@JsonSerializable()
class GateInModel {
  final GateLogModel gateLog;

  const GateInModel({required this.gateLog});

  factory GateInModel.fromJson(Map<String, dynamic> json) =>
      _$GateInModelFromJson(json);

  Map<String, dynamic> toJson() => _$GateInModelToJson(this);
}
