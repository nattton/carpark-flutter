import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/gateway/data/datasource/id_card_service_datasource.dart';
import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/features/gateway/domain/repository/id_card_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdCardServiceRepository)
class IdCardServiceRepositoryImpl extends IdCardServiceRepository {
  final IdCardServiceDataSource dataSource;

  IdCardServiceRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, GenericResponseData<IDCardEntity>>>
      readIdCard() async {
    return TaskEither.tryCatch(
      () => dataSource.readIdCard(),
      (e, _) => Failure.fromException(e),
    ).run();
  }
}
