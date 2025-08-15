import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../models/registered_user_response.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class RegisteredUserGetUsecase extends UseCase<RegisteredUserResponse, int> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserGetUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(int params) async {
    final result = await repository.getRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
