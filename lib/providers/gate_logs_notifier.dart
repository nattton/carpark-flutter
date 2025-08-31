import 'package:hooks_riverpod/legacy.dart';

import '../models/gate_log_result.dart';

class GateLogsNotifier extends StateNotifier<List<GateLogResult>> {
  GateLogsNotifier() : super(const []);

  void setState(List<GateLogResult> gateLogs) {
    state = gateLogs;
  }
}
