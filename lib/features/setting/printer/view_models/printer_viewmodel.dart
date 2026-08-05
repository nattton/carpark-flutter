import 'package:carpark/shared/repositories/printer/printer_repository.dart';
import 'package:carpark/shared/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class PrinterViewModel extends ChangeNotifier {
  PrinterViewModel({required this._printerRepository}) {
    getPrinterCommand = Command.createAsyncNoParam<String?>(
      initialValue: null,
      () async {
        final result = await _printerRepository.printerName;
        if (result == null) {
          _log.warning('Get Printer name failed');
        }
        return result;
      },
    );

    updatePrinterCommand = Command.createAsync<String, Result<void>>(
      initialValue: const Result.ok(null),
      (printerName) async {
        final result = await _printerRepository.updatePrinter(printerName);
        if (result is Error<void>) {
          _log.warning('Update Printer name failed! ${result.error}');
        }
        getPrinterCommand.run();
        return result;
      },
    );

    getPrinterListCommand = Command.createAsyncNoParam(
      initialValue: const [],
      () async {
        return _printerRepository.getPrinterList();
      },
    );
  }
  final PrinterRepository _printerRepository;
  final _log = Logger('PrinterViewModel');

  late Command<void, String?> getPrinterCommand;
  late Command<String, Result<void>> updatePrinterCommand;
  late Command<void, List<String>> getPrinterListCommand;
}
