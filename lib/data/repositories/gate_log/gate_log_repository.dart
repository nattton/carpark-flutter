import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';

abstract class GateLogRepository {
  Future<Result<LastGate>> getLastGate();
  Future<Result<GateLogModel>> getGateIn();
  Future<Result<GateLogModel>> getGateOut();
  Future<Result<List<GateLogResult>>> searchGateLog(String date, String dateTo);
  Future<Result<void>> openDoor(String name);
  Future<Result<void>> manualCapture(String name);
}
