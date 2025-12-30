import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    setTitleCommand = Command.createSyncNoResult((param) {
      _title = param;
      _log.info('setTitleCommand: $param');
      notifyListeners();
    });
  }
  final _log = Logger('HomeViewModel');
  String _title = 'Car Park';

  late Command<String, void> setTitleCommand;

  String get title => _title;
}
