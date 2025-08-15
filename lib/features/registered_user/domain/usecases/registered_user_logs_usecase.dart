import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../models/registered_user_logs_response.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class RegisteredUserLogsUsecase
    extends UseCase<RegisteredUserLogsResponse, int> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserLogsUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserLogsResponse>> call(int params) async {
    final result = await repository.getRegisteredUserLogs(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
