import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/data/models/registered_user_log_model.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetRegisteredUserLogNotCheckOutResponseUsecase
    extends UseCase<List<RegisteredUserLog>, NoParams> {
  final RegisteredUserServiceRepository repository;

  GetRegisteredUserLogNotCheckOutResponseUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUserLog>>> call(NoParams params) async {
    try {
      final result = await repository.getNotCheckOutRegisteredUser();
      return result.fold(
        (l) => Left(l),
        (r) => Right(
          RegisteredUserLogModel.responseMapperNotCheckOutList(r.data!.logs),
        ),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
