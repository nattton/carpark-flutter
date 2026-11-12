import 'package:carpark/data/repositories/report/report_repository.dart';
import 'package:carpark/domain/models/report_traffic_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportViewModel extends ChangeNotifier {
  new({required ReportRepository reportRepository})
    : _reportRepository = reportRepository;

  final ReportRepository _reportRepository;

  Future<Result<List<ReportTrafficModel>>> getReportTraffic({
    required String type,
    required String date,
    required String dateTo,
  }) {
    return _reportRepository.reportTraffic(type, date, dateTo);
  }
}
