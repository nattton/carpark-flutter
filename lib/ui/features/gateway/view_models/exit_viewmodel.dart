import 'dart:io';

import 'package:carpark/data/models/registered_user/registered_user_check_out_request.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/data/repositories/visitor/visitor_repository.dart';
import 'package:carpark/domain/models/checkout_model.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/domain/models/registered_user_model.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/ui/features/home/view_models/last_gate_viewmodel.dart';
import 'package:carpark/ui/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

sealed class ExitCheckoutOutcome {
  const new();
}

final class ExitRegisteredUserCheckout extends ExitCheckoutOutcome {
  const new(this.registeredUser);
  final RegisteredUser registeredUser;
}

final class ExitVisitorCheckout extends ExitCheckoutOutcome {
  const new(this.visitor);
  final VisitorModel visitor;
}

@injectable
class ExitViewModel extends ChangeNotifier {
  new({
    required VisitorRepository visitorRepository,
    required RegisteredUserServiceRepository registeredUserRepository,
    required LivePlayerViewmodel livePlayerViewModel,
    required LastGateViewmodel lastGateViewModel,
  }) : _visitorRepository = visitorRepository,
       _registeredUserRepository = registeredUserRepository,
       _livePlayerViewModel = livePlayerViewModel,
       _lastGateViewModel = lastGateViewModel;

  final VisitorRepository _visitorRepository;
  final RegisteredUserServiceRepository _registeredUserRepository;
  final LivePlayerViewmodel _livePlayerViewModel;
  final LastGateViewmodel _lastGateViewModel;

  Future<Result<ExitCheckoutOutcome>> checkout(String barcode) async {
    if (Uuid.isValidUUID(fromString: barcode)) {
      final result = await _registeredUserRepository.checkOutRegisteredUser(
        RegisteredUserCheckOutRequest(generatedId: barcode),
      );
      switch (result) {
        case Ok<RegisteredUserModel>():
          return Result.ok(ExitRegisteredUserCheckout(result.value));
        case Error<RegisteredUserModel>():
          return Result.error(result.error);
      }
    } else {
      final gateLogOut = _lastGateViewModel.gateOut.value;
      final result = await _visitorRepository.checkoutVisitor(
        CheckoutModel(barcode: barcode, gateLogId: gateLogOut.id),
      );
      switch (result) {
        case Ok<VisitorModel>():
          final visitor = result.value;
          await _addImageToVisitor(visitor);
          return Result.ok(ExitVisitorCheckout(visitor));
        case Error<VisitorModel>():
          final error = result.error;
          if (error is DioException) {
            final res = error.response;
            if (res != null) {
              if (res.statusCode == HttpStatus.badRequest) {
                return Result.error(
                  Exception(
                    'ข้อมูลไม่ถูกต้อง หรือ ไม่ได้เปลี่ยนคีย์บอร์ดเป็นภาษาอังกฤษ',
                  ),
                );
              } else if (res.statusCode == HttpStatus.notFound) {
                return Result.error(Exception('ไม่พบข้อมูล'));
              }
            }
          }
          return Result.error(error);
      }
    }
  }

  Future<void> _addImageToVisitor(VisitorModel visitor) async {
    final outSideImage = await _tempImage('out_side');
    final exitImage = await _tempImage('exit');

    final sideScreenshot = await _livePlayerViewModel.sidePlayer.screenshot();
    final mainScreenshot = await _livePlayerViewModel.mainPlayer.screenshot();

    if (sideScreenshot != null) {
      await outSideImage.writeAsBytes(sideScreenshot);
    }
    if (mainScreenshot != null) {
      await exitImage.writeAsBytes(mainScreenshot);
    }

    if (outSideImage.existsSync()) {
      await _visitorRepository.addImageToVisitor(
        visitor.id,
        'out_side',
        outSideImage,
      );
      await outSideImage.delete();
    }
    if (exitImage.existsSync()) {
      await _visitorRepository.addImageToVisitor(visitor.id, 'exit', exitImage);
      await exitImage.delete();
    }
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();
    return File('${directory.path}/$type.jpg');
  }
}
