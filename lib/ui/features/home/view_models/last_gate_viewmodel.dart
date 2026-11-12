import 'dart:convert';

import 'package:carpark/data/repositories/gate_log/gate_log_repository.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class LastGateViewmodel extends ChangeNotifier {
  new({required GateLogRepository gateLogRepository})
    : _gateLogRepository = gateLogRepository {
    getLastGateCommand = Command.createAsyncNoParamNoResult(() async {
      final result = await _gateLogRepository.getLastGate();
      switch (result) {
        case Ok<LastGate>():
          gateIn.value = result.value.gateIn;
          gateOut.value = result.value.gateOut;
        case Error<LastGate>():
          _log.warning('Get Last Gate failed! ${result.error}');
          throw result.error;
      }
    });

    getGateInCommand = Command.createAsyncNoParamNoResult(() async {
      final result = await _gateLogRepository.getGateIn();
      switch (result) {
        case Ok<GateLogModel>():
          gateIn.value = result.value;
        case Error<GateLogModel>():
          _log.warning('Get Gate In failed! ${result.error}');
          throw result.error;
      }
    });

    getGateOutCommand = Command.createAsyncNoParamNoResult(() async {
      final result = await _gateLogRepository.getGateOut();
      switch (result) {
        case Ok<GateLogModel>():
          gateOut.value = result.value;
        case Error<GateLogModel>():
          _log.warning('Get Gate Out failed! ${result.error}');
          throw result.error;
      }
    });

    setLastGateFromJsonCommand = Command.createSyncNoResult((data) {
      try {
        final gateLog = GateLogModel.fromJson(
          jsonDecode(data) as Map<String, dynamic>,
        );
        if (gateLog.gateName == 'in') {
          gateIn.value = gateLog;
        } else if (gateLog.gateName == 'out') {
          gateOut.value = gateLog;
        }
      } on Object catch (error) {
        _log.warning('Get Last Gate failed! $error');
        rethrow;
      }
    });
  }

  final GateLogRepository _gateLogRepository;
  final _log = Logger('LastGateViewmodel');

  final gateIn = ValueNotifier<GateLogModel>(GateLogModel(0));
  final gateOut = ValueNotifier<GateLogModel>(GateLogModel(0));

  late Command<void, void> getLastGateCommand;
  late Command<void, void> getGateInCommand;
  late Command<void, void> getGateOutCommand;
  late Command<String, void> setLastGateFromJsonCommand;
}
