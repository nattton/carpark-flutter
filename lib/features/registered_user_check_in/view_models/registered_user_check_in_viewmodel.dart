import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_check_in_request.dart';
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
  RegisteredUserCheckInViewmodel({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;
  final _log = Logger('MemberListViewModel');
  final RegisteredUserServiceRepository _repository;

  late final Command<String, RegisteredUserModel?>
  checkInRegisteredUserCommand =
      Command.createAsync<String, RegisteredUserModel?>(
        initialValue: null,
        (generatedId) async {
          if (generatedId.isEmpty) {
            throw CheckInEmptyException();
          }

          if (!Uuid.isValidUUID(fromString: generatedId)) {
            throw CheckInInvalidException();
          }

          final result = await _repository.checkInRegisteredUser(
            RegisteredUserCheckInRequest(generatedId: generatedId),
          );
          return result.fold((l) {
            _log.warning('checkInRegisteredUser failed! ${l.message}');
            throw l;
          }, (r) => RegisteredUserModel.responseMapper(r.data!));
        },
      );
}
