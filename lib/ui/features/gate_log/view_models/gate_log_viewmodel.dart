import 'package:carpark/data/repositories/gate_log/gate_log_repository.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

@singleton
class GateLogViewmodel extends ChangeNotifier {
  new({required GateLogRepository gateLogRepository})
    : _gateLogRepository = gateLogRepository;

  final _log = Logger('GateLogViewmodel');
  final GateLogRepository _gateLogRepository;

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
          final result = await _gateLogRepository.searchGateLog(date, dateTo);
          switch (result) {
            case Ok<List<GateLogResult>>():
              gateLogsCommand(result.value);
              filterUpdatedCommand();
            case Error<List<GateLogResult>>():
              _log.warning('getGateLogsCommand failed! ${result.error}');
              throw result.error;
          }
        }
      });

  late final Command<void, void> filterUpdatedCommand =
      Command.createSyncNoParamNoResult(() {
        var filterGateLogs = <GateLogResult>[];
        final filter = filterChangedCommand.value;
        final sortBy = sortByChangedCommand.value;
        filterGateLogs = filter.isEmpty
            ? List<GateLogResult>.from(gateLogsCommand.value)
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
      Command.createSync<String, String>(initialValue: '', (s) => s)
        ..debounce(const Duration(milliseconds: 500))
        ..listen((_, _) => filterUpdatedCommand());

  late final Command<String, String> sortByChangedCommand =
      Command.createSync<String, String>(initialValue: '', (fieldName) {
        final sortBy = sortByChangedCommand.value;
        if (sortBy == fieldName) {
          return '-$sortBy';
        } else {
          return fieldName;
        }
      })..listen((_, _) => filterUpdatedCommand());
}
