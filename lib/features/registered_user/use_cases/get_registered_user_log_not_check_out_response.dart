import 'package:carpark/features/registered_user/models/registered_user_log.dart';
import 'package:carpark/features/registered_user/models/registered_user_log_model.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetRegisteredUserLogNotCheckOutResponseUsecase
    extends UseCase<List<RegisteredUserLog>, NoParams> {
  GetRegisteredUserLogNotCheckOutResponseUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, List<RegisteredUserLog>>> call(NoParams params) async {
    try {
      final result = await repository.getNotCheckOutRegisteredUser();
      return result.fold(
        Left.new,
        (r) => Right(
          RegisteredUserLogModel.responseMapperNotCheckOutList(r.data!.logs),
        ),
      );
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
