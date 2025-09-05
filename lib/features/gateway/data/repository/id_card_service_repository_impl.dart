import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/failures.dart';
import '../../../../utils/generic_response_data.dart';
import '../../domain/entity/id_card_entity.dart';
import '../../domain/repository/id_card_service_repository.dart';
import '../datasource/id_card_service_datasource.dart';

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
