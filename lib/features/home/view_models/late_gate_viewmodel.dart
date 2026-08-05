import 'dart:convert';

import 'package:carpark/shared/models/models.dart';
import 'package:carpark/shared/services/api/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class LastGateViewmodel {
  LastGateViewmodel({required ApiService apiService})
    : _apiService = apiService {
    getLastGateCommand = Command.createAsyncNoParamNoResult(
      () async {
        try {
          final lastGate = await _apiService.getLastGate();
          gateIn.value = lastGate.gateIn;
          gateOut.value = lastGate.gateOut;
        } catch (error) {
          _log.warning('Get Last Gate failed! $error');
          rethrow;
        }
      },
    );

    getGateInCommand = Command.createAsyncNoParamNoResult(
      () async {
        try {
          final res = await _apiService.getGateIn();
          gateIn.value = res.gateLog;
        } catch (error) {
          _log.warning('Get Gate In failed! $error');
          rethrow;
        }
      },
    );

    getGateOutCommand = Command.createAsyncNoParamNoResult(
      () async {
        try {
          final res = await _apiService.getGateOut();
          gateOut.value = res.gateLog;
        } catch (error) {
          _log.warning('Get Gate Out failed! $error');
          rethrow;
        }
      },
    );

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
      } catch (error) {
        _log.warning('Get Last Gate failed! $error');
        rethrow;
      }
    });
  }

  final ApiService _apiService;
  final _log = Logger('LastGateViewmodel');

  final gateIn = ValueNotifier<GateLogModel>(GateLogModel(0));
  final gateOut = ValueNotifier<GateLogModel>(GateLogModel(0));

  late Command<void, void> getLastGateCommand;
  late Command<void, void> getGateInCommand;
  late Command<void, void> getGateOutCommand;
  late Command<String, void> setLastGateFromJsonCommand;
}
