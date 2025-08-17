import 'package:logging/logging.dart';

import '../../../utils/result.dart';
import '../../services/shared_preferences_service.dart';
import 'printer_repository.dart';

class PrinterRepositoryLocal extends PrinterRepository {
  PrinterRepositoryLocal({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;

  String? _printerName;
  final _log = Logger('PrinterRepositoryLocal');

  Future<void> _fetchPrinterName() async {
    final result = await _sharedPreferencesService.fetchPrinter();
    switch (result) {
      case Ok<String?>():
        _printerName = result.value;
      case Error<String?>():
        _log.warning('Failed to get printer', result.error);
    }
  }

  @override
  Future<String?> get printerName async {
    if (_printerName != null) {
      return _printerName;
    }
    await _fetchPrinterName();
    return _printerName;
  }

  @override
  Future<Result<void>> savePrinter(String printerName) async {
    try {
      _printerName = printerName;
      return await _sharedPreferencesService.savePrinter(printerName);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
