import 'package:carpark/models/gate_log_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GateLogsNotifier extends StateNotifier<List<GateLogResult>> {
  GateLogsNotifier() : super(const []);

  void setState(List<GateLogResult> gateLogs) {
    state = gateLogs;
  }
}
