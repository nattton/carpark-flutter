import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_gate.g.dart';

@JsonSerializable()
@immutable
class LastGate {
  const LastGate({required this.gateIn, required this.gateOut});

  factory LastGate.fromJson(Map<String, dynamic> json) =>
      _$LastGateFromJson(json);
  final GateLogModel gateIn;
  final GateLogModel gateOut;

  Map<String, dynamic> toJson() => _$LastGateToJson(this);
}
