import 'package:carpark/data/repositories/printer/printer_repository.dart';
import 'package:carpark/data/services/local/shared_preferences_service.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:thermal_printer/thermal_printer.dart';

@Singleton(as: PrinterRepository)
class PrinterRepositoryLocal extends PrinterRepository {
  new({
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
    final devices = <String>[];
    final printerManager = PrinterManager.instance;
    final streamDevice = printerManager.discovery(type: PrinterType.usb);
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

  @override
  Future<Result<void>> printBytes(List<int> bytes) async {
    try {
      final printerManager = PrinterManager.instance;
      await printerManager.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(name: await printerName),
      );
      await printerManager.send(type: PrinterType.usb, bytes: bytes);
      await printerManager.disconnect(type: PrinterType.usb);
      return const Result.ok(null);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
