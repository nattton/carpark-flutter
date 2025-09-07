import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user/registered_user_logs.dart';
import 'package:carpark/domain/models/registered_user/registered_user_logs_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetRegisteredUserLogsUsecase extends UseCase<RegisteredUserLogs, int> {
  GetRegisteredUserLogsUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUserLogs>> call(int params) async {
    try {
      final result = await repository.getRegisteredUserLogs(params);
      return result.fold(
        Left.new,
        (r) => Right(RegisteredUserLogsModel.responseMapper(r.data!)),
      );
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
