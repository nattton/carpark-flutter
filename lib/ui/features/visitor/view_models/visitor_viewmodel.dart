import 'package:carpark/data/repositories/visitor/visitor_repository.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

@singleton
class VisitorViewmodel extends ChangeNotifier {
  new({required VisitorRepository visitorRepository})
    : _visitorRepository = visitorRepository;

  final _log = Logger('VisitorViewmodel');
  final VisitorRepository _visitorRepository;

  late final Command<List<VisitorModel>, List<VisitorModel>> visitorsCommand =
      Command.createSync<List<VisitorModel>, List<VisitorModel>>(
        initialValue: [],
        (visitors) => visitors,
      );
  late final Command<List<VisitorModel>, List<VisitorModel>>
  filteredVisitorsCommand =
      Command.createSync<List<VisitorModel>, List<VisitorModel>>(
        initialValue: [],
        (visitors) => visitors,
      );

  late final Command<List<DateTime?>, void> getVisitorsCommand =
      Command.createAsyncNoResult((selectedDate) async {
        if (selectedDate.isNotEmpty) {
          final date = DateFormat('yyyy-MM-dd').format(selectedDate[0]!);
          var dateTo = date;
          if (selectedDate.length > 1) {
            dateTo = DateFormat('yyyy-MM-dd').format(selectedDate[1]!);
          }
          final result = await _visitorRepository.listVisitor(date, dateTo);
          switch (result) {
            case Ok<List<VisitorModel>>():
              visitorsCommand(result.value);
              filterUpdatedCommand();
            case Error<List<VisitorModel>>():
              _log.warning('getVisitorsCommand failed! ${result.error}');
              throw result.error;
          }
        }
      });

  late final Command<void, void> filterUpdatedCommand =
      Command.createSyncNoParamNoResult(() {
        var filterVisitors = <VisitorModel>[];
        final filter = filterChangedCommand.value;
        final sortBy = sortByChangedCommand.value;
        filterVisitors = filter.isEmpty
            ? List<VisitorModel>.from(visitorsCommand.value)
            : visitorsCommand.value.where((visitor) {
                return visitor.plateNumber!.contains(filter) ||
                    visitor.member!.name!.contains(filter);
              }).toList();

        if (sortBy.isNotEmpty) {
          switch (sortBy) {
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

        filteredVisitorsCommand(filterVisitors);
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
