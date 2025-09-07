import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/data/services/api/model/registered_user/registered_user_logs_response.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserLogsUsecase
    extends UseCase<RegisteredUserLogsResponse, int> {

  RegisteredUserLogsUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUserLogsResponse>> call(int params) async {
    final result = await repository.getRegisteredUserLogs(params);
    return result.fold(Left.new, (r) => Right(r.data!));
  }
}
