import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/id_card_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ReadIdCardUsecase extends UseCase<IDCardResponse, NoParams> {
  final RegisteredUserServiceRepository repository;

  ReadIdCardUsecase(this.repository);

  @override
  Future<Either<Failure, IDCardResponse>> call(NoParams params) async {
    final result = await repository.readIdCard();
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
