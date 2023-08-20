import 'package:carpark/models/gate_log_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GateLogsNotifier extends StateNotifier<List<GateLogModel>> {
  GateLogsNotifier() : super(const []);

  void setState(List<GateLogModel> gateLogs) {
    state = gateLogs;
  }
}
