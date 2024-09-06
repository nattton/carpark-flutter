import 'dart:convert';

import 'package:carpark/models/gate_log_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'last_gate.g.dart';
part 'last_gate.freezed.dart';

@freezed
class LastGate with _$LastGate {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LastGate({
    required GateLogModel gateIn,
    required GateLogModel gateOut,
  }) = _LastGate;

  factory LastGate.fromJson(Map<String, dynamic> json) =>
      _$LastGateFromJson(json);
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
