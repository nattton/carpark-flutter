import 'package:carpark/domain/models/report_traffic_model.dart';
import 'package:carpark/utils/result.dart';

abstract class ReportRepository {
  Future<Result<List<ReportTrafficModel>>> reportTraffic(
    String type,
    String date,
    String dateTo,
  );
}
