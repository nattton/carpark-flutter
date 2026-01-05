import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

@singleton
class VisitorViewmodel {
  VisitorViewmodel({required ApiService apiService})
    : _apiService = apiService {
    getVisitorsCommand = Command.createAsyncNoResult((selectedDate) async {
      if (selectedDate.isNotEmpty) {
        final date = DateFormat('yyyy-MM-dd').format(selectedDate[0]!);
        var dateTo = date;
        if (selectedDate.length > 1) {
          dateTo = DateFormat('yyyy-MM-dd').format(selectedDate[1]!);
        }
        try {
          visitors.value = await _apiService.listVisitor(date, dateTo);
          filteredVisitors.value = visitors.value;
        } catch (error) {
          _log.warning('getVisitorsCommand failed! $error');
          rethrow;
        }
      }

      filterCommand = Command.createSyncNoParamNoResult(() {
        var filterVisitors = <VisitorModel>[];

        filterVisitors = filter.value.isEmpty
            ? visitors.value
            : visitors.value.where((visitor) {
                return visitor.plateNumber!.contains(filter.value) ||
                    visitor.member!.name!.contains(filter.value);
              }).toList();

        if (sortBy.value.isNotEmpty) {
          switch (sortBy.value) {
            case 'date':
              filterVisitors.sort((a, b) {
                return a.createdAt!.compareTo(b.createdAt!);
              });
            case '-date':
              filterVisitors.sort((b, a) {
                return a.createdAt!.compareTo(b.createdAt!);
              });
            case 'exitTime':
              filterVisitors.sort((a, b) {
                return a.exitTime!.time!.compareTo(b.createdAt!);
              });
            case '-exitTime':
              filterVisitors.sort((b, a) {
                return a.exitTime!.time!.compareTo(b.createdAt!);
              });
            case 'plateNumber':
              filterVisitors.sort((a, b) {
                return a.plateNumber!.compareTo(b.plateNumber!);
              });
            case '-plateNumber':
              filterVisitors.sort((b, a) {
                return a.plateNumber!.compareTo(b.plateNumber!);
              });
            case 'memberName':
              filterVisitors.sort((a, b) {
                return a.member!.name!.compareTo(b.member!.name!);
              });
            case '-memberName':
              filterVisitors.sort((b, a) {
                return a.member!.name!.compareTo(b.member!.name!);
              });
          }
        }

        filteredVisitors.value = [...filterVisitors];
      });
    });
  }
  final _log = Logger('VisitorViewmodel');
  final ApiService _apiService;
  final filteredVisitors = ValueNotifier<List<VisitorModel>>([]);
  late final visitors = ValueNotifier<List<VisitorModel>>([]);
  late final filter = ValueNotifier<String>('')..pipeToCommand(filterCommand);
  late final sortBy = ValueNotifier<String>('')..pipeToCommand(filterCommand);

  late Command<List<DateTime?>, void> getVisitorsCommand;
  late Command<void, void> filterCommand;
}
