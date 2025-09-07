import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/features/gateway/domain/repository/id_card_service_repository.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ReadIdCardUsecase extends UseCase<IDCardEntity, NoParams> {

  ReadIdCardUsecase(this.repository);
  final IdCardServiceRepository repository;

  @override
  Future<Either<Failure, IDCardEntity>> call(NoParams params) async {
    final result = await repository.readIdCard();
    return result.fold(Left.new, (r) => Right(r.data!));
  }
}
