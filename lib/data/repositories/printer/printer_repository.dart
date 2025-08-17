import 'package:flutter/foundation.dart';

import '../../../utils/result.dart';

abstract class PrinterRepository extends ChangeNotifier {
  Future<String?> get printerName;

  Future<Result<void>> savePrinter(String printerName);
}
