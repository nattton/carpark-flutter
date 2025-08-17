import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrinterKey = 'PRINTER_KEY';

@module
abstract class AppServiceModule {
  @singleton
  AppService create(SharedPreferences prefs) => AppService(prefs: prefs);
}

class AppService {
  final SharedPreferences prefs;

  AppService({required this.prefs});

  String get printer => prefs.getString(kPrinterKey) ?? '';

  Future<void> savePrinter(String printerName) async {
    await prefs.setString(kPrinterKey, printerName);
  }
}
