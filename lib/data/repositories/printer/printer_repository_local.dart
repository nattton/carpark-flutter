import 'package:carpark/data/repositories/printer/printer_repository.dart';
import 'package:carpark/data/services/shared_preferences_service.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:thermal_printer/thermal_printer.dart';

@Singleton(as: PrinterRepository)
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
  Future<Result<void>> updatePrinter(String printerName) async {
    try {
      _printerName = printerName;
      return await _sharedPreferencesService.updatePrinter(printerName);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<List<String>> getPrinterList() async {
    // Find printers
    final devices = <String>[];
    final printerManager = PrinterManager.instance;
    final streamDevice = printerManager.discovery(
      type: PrinterType.usb,
    );
    await for (final device in streamDevice) {
      if (!devices.contains(device.name)) {
        devices.add(device.name);
        _log.info(
          'Printer Device ${device.name} | ${device.productId} | ${device.vendorId}',
        );
      }
    }
    return devices;
  }
}
