import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/models/models.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

@singleton
class GateLogViewmodel {
  GateLogViewmodel({required ApiService apiService}) : _apiService = apiService;
  final _log = Logger('GateLogViewmodel');
  final ApiService _apiService;

  late final Command<List<GateLogResult>, List<GateLogResult>> gateLogsCommand =
      Command.createSync<List<GateLogResult>, List<GateLogResult>>(
        initialValue: [],
        (gateLogs) => gateLogs,
      );
  late final Command<List<GateLogResult>, List<GateLogResult>>
  filteredGateLogsCommand =
      Command.createSync<List<GateLogResult>, List<GateLogResult>>(
        initialValue: [],
        (gateLogs) => gateLogs,
      );

  late final Command<List<DateTime?>, void> getGateLogsCommand =
      Command.createAsyncNoResult((selectedDate) async {
        if (selectedDate.isNotEmpty) {
          final date = DateFormat('yyyy-MM-dd').format(selectedDate[0]!);
          var dateTo = date;
          if (selectedDate.length > 1) {
            dateTo = DateFormat('yyyy-MM-dd').format(selectedDate[1]!);
          }
          try {
            final gateLogs = await _apiService.searchGateLog(date, dateTo);
            gateLogsCommand(gateLogs);
            filterUpdatedCommand();
          } catch (error) {
            _log.warning('getGateLogsCommand failed! $error');
            rethrow;
          }
        }
      });

  late final Command<void, void> filterUpdatedCommand =
      Command.createSyncNoParamNoResult(() {
        var filterGateLogs = <GateLogResult>[];
        final filter = filterChangedCommand.value;
        final sortBy = sortByChangedCommand.value;
        filterGateLogs = filter.isEmpty
            ? gateLogsCommand.value
            : gateLogsCommand.value.where((gateLog) {
                return gateLog.plateNumber.contains(filter) ||
                    gateLog.memberName.contains(filter);
              }).toList();

        if (sortBy.isNotEmpty) {
          switch (sortBy) {
            case 'date':
              filterGateLogs.sort((a, b) {
                return a.createdAt.compareTo(b.createdAt);
              });
            case '-date':
              filterGateLogs.sort((b, a) {
                return a.createdAt.compareTo(b.createdAt);
              });
            case 'plateNumber':
              filterGateLogs.sort((a, b) {
                return a.plateNumber.compareTo(b.plateNumber);
              });
            case '-plateNumber':
              filterGateLogs.sort((b, a) {
                return a.plateNumber.compareTo(b.plateNumber);
              });
            case 'memberName':
              filterGateLogs.sort((a, b) {
                return a.memberName.compareTo(b.memberName);
              });
            case '-memberName':
              filterGateLogs.sort((b, a) {
                return a.memberName.compareTo(b.memberName);
              });
            default:
          }
        }

        filteredGateLogsCommand(filterGateLogs);
      });

  late final Command<String, String> filterChangedCommand =
      Command.createSync<String, String>(
          initialValue: '',
          (s) => s,
        )
        ..debounce(
          const Duration(milliseconds: 500),
        )
        ..listen((_, _) => filterUpdatedCommand());

  late final Command<String, String> sortByChangedCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (fieldName) {
          final sortBy = sortByChangedCommand.value;
          if (sortBy == fieldName) {
            return '-$sortBy';
          } else {
            return fieldName;
          }
        },
      )..listen((_, _) => filterUpdatedCommand());
}
