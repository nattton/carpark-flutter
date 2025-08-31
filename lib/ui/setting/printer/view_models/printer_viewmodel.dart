import 'package:command_it/command_it.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../../data/repositories/printer/printer_repository.dart';
import '../../../../utils/result.dart';

@injectable
class PrinterViewModel extends ChangeNotifier {
  final PrinterRepository _printerRepository;
  final _log = Logger('PrinterViewModel');

  late Command<void, String?> getPrinterCommand;
  late Command<String, Result<void>> updatePrinterCommand;
  late Command<void, List<String>> getPrinterListCommand;

  PrinterViewModel({required PrinterRepository printerRepository})
    : _printerRepository = printerRepository {
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
      initialValue: Result.ok(null),
      (printerName) async {
        final result = await _printerRepository.updatePrinter(printerName);
        if (result is Error<void>) {
          _log.warning('Update Printer name failed! ${result.error}');
        }
        getPrinterCommand.execute();
        return result;
      },
    );

    getPrinterListCommand = Command.createAsyncNoParam(
      initialValue: const [],
      () async {
        return await _printerRepository.getPrinterList();
      },
    );
  }
}
