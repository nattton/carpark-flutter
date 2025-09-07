import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';

abstract class PrinterRepository extends ChangeNotifier {
  Future<String?> get printerName;

  Future<Result<void>> updatePrinter(String printerName);

  Future<List<String>> getPrinterList();
}
