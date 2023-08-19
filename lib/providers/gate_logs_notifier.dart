import 'package:carpark/models/member_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GateLogsNotifier extends StateNotifier<List<MemberModel>> {
  GateLogsNotifier() : super(const []);

  void setState(List<MemberModel> gateLogs) {
    state = [...gateLogs];
  }
}
