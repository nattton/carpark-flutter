import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/data/services/api/model/registered_user/create_registered_user_request.dart';
import 'package:carpark/data/services/api/model/registered_user/registered_user_response.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCreateUsecase
    extends UseCase<RegisteredUserResponse, CreateRegisteredUserRequest> {

  RegisteredUserCreateUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
    CreateRegisteredUserRequest params,
  ) async {
    final result = await repository.createRegisteredUser(params);
    return result.fold(Left.new, (r) => Right(r.data!));
  }
}
