import 'package:carpark/data/models/registered_user/registered_user_check_in_request.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

class CheckInEmptyException implements Exception {
  @override
  String toString() {
    return 'Generated ID is required!';
  }
}

class CheckInInvalidException implements Exception {
  @override
  String toString() {
    return 'Generated ID is incorrect!';
  }
}

class RegisteredUserCheckInViewmodel {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final _log = Logger('RegisteredUserCheckInViewmodel');
  final RegisteredUserServiceRepository _repository;

  late final Command<String, RegisteredUserModel?>
  checkInRegisteredUserCommand =
      Command.createAsync<String, RegisteredUserModel?>(initialValue: null, (
        generatedId,
      ) async {
        if (generatedId.isEmpty) {
          throw CheckInEmptyException();
        }

        if (!Uuid.isValidUUID(fromString: generatedId)) {
          throw CheckInInvalidException();
        }

        final result = await _repository.checkInRegisteredUser(
          RegisteredUserCheckInRequest(generatedId: generatedId),
        );
        switch (result) {
          case Ok<RegisteredUserModel>():
            return result.value;
          case Error<RegisteredUserModel>():
            _log.warning('checkInRegisteredUser failed! ${result.error}');
            throw result.error;
        }
      });
}
