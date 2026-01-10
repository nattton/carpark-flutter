import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class HomeViewModel {
  HomeViewModel() {
    setTitleCommand = Command.createSyncNoResult((param) {
      title.value = param;
      _log.info('setTitleCommand: $param');
    });
  }
  final _log = Logger('HomeViewModel');
  final title = ValueNotifier<String>('Car Park');

  late Command<String, void> setTitleCommand;
}
