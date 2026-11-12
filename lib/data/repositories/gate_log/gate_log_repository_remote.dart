import 'package:carpark/data/repositories/gate_log/gate_log_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GateLogRepository)
class GateLogRepositoryRemote extends GateLogRepository {
  new({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<LastGate>> getLastGate() async {
    try {
      final lastGate = await _apiService.getLastGate();
      return Result.ok(lastGate);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<GateLogModel>> getGateIn() async {
    try {
      final res = await _apiService.getGateIn();
      return Result.ok(res.gateLog);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<GateLogModel>> getGateOut() async {
    try {
      final res = await _apiService.getGateOut();
      return Result.ok(res.gateLog);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<List<GateLogResult>>> searchGateLog(
    String date,
    String dateTo,
  ) async {
    try {
      final logs = await _apiService.searchGateLog(date, dateTo);
      return Result.ok(logs);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<void>> openDoor(String name) async {
    try {
      await _apiService.openDoor(name);
      return const Result.ok(null);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<void>> manualCapture(String name) async {
    try {
      await _apiService.manualCapture(name);
      return const Result.ok(null);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
