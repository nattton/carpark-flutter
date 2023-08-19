import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class LastGateModel {
  final GateLogModel gateIn;
  final GateLogModel gateOut;
  const LastGateModel({
    required this.gateIn,
    required this.gateOut,
  });

  LastGateModel copyWith({
    GateLogModel? gateIn,
    GateLogModel? gateOut,
  }) {
    return LastGateModel(
      gateIn: gateIn ?? this.gateIn,
      gateOut: gateOut ?? this.gateOut,
    );
  }
}

class LastGateNotifier extends StateNotifier<LastGateModel> {
  LastGateNotifier(super.state);

  void setGateIn(GateLogModel log) {
    if (state.gateIn.id != log.id) {
      state = state.copyWith(gateIn: log);
    }
  }

  void setGateOut(GateLogModel log) {
    if (state.gateOut.id != log.id) {
      state = state.copyWith(gateOut: log);
    }
  }
}
