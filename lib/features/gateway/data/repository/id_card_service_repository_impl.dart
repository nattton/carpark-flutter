import 'package:carpark/features/gateway/data/datasource/id_card_service_datasource.dart';
import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/features/gateway/domain/repository/id_card_service_repository.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/generic_response_data.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdCardServiceRepository)
class IdCardServiceRepositoryImpl extends IdCardServiceRepository {

  IdCardServiceRepositoryImpl(this.dataSource);
  final IdCardServiceDataSource dataSource;

  @override
  Future<Either<Failure, GenericResponseData<IDCardEntity>>>
  readIdCard() async {
    return TaskEither.tryCatch(
      dataSource.readIdCard,
      (e, _) => Failure.fromException(e),
    ).run();
  }
}
