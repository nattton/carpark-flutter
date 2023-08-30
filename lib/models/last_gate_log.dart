import 'package:carpark/models/gate_log_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_gate_log.g.dart';

@JsonSerializable()
class LastGateLog {
  final GateLogModel gateIn;
  final GateLogModel gateOut;

  LastGateLog({required this.gateIn, required this.gateOut});

  factory LastGateLog.fromJson(Map<String, dynamic> json) =>
      _$LastGateLogFromJson(json);

  Map<String, dynamic> toJson() => _$LastGateLogToJson(this);
}
