import 'package:carpark/data/repositories/report/report_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/report_traffic_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ReportRepository)
class ReportRepositoryRemote extends ReportRepository {
  new({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<List<ReportTrafficModel>>> reportTraffic(
    String type,
    String date,
    String dateTo,
  ) async {
    try {
      final report = await _apiService.reportTraffic(type, date, dateTo);
      return Result.ok(report);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
