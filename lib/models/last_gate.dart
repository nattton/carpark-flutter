import 'dart:convert';

import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_gate.g.dart';

@JsonSerializable()
@immutable
class LastGate {
  final GateLogModel gateIn;
  final GateLogModel gateOut;
  const LastGate({
    required this.gateIn,
    required this.gateOut,
  });

  LastGate copyWith({
    GateLogModel? gateIn,
    GateLogModel? gateOut,
  }) {
    return LastGate(
      gateIn: gateIn ?? this.gateIn,
      gateOut: gateOut ?? this.gateOut,
    );
  }

  factory LastGate.fromJson(Map<String, dynamic> json) =>
      _$LastGateFromJson(json);

  Map<String, dynamic> toJson() => _$LastGateToJson(this);
}

class LastGateNotifier extends StateNotifier<LastGate> {
  LastGateNotifier(super.state);

  void setGateIn(GateLogModel log) {
    state = state.copyWith(gateIn: log);
  }

  void setGateOut(GateLogModel log) {
    state = state.copyWith(gateOut: log);
  }

  void setFromJson(dynamic data) {
    var gateLog = GateLogModel.fromJson(jsonDecode(data));
    if (gateLog.gateName == "in") {
      setGateIn(gateLog);
    } else if (gateLog.gateName == "out") {
      setGateOut(gateLog);
    }
  }
}
