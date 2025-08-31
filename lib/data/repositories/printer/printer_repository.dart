import 'package:flutter/foundation.dart';

import '../../../utils/result.dart';

abstract class PrinterRepository extends ChangeNotifier {
  Future<String?> get printerName;

  Future<Result<void>> updatePrinter(String printerName);

  Future<List<String>> getPrinterList();
}
