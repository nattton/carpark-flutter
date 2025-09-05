import 'package:injectable/injectable.dart';

import '../../../../utils/generic_response_data.dart';
import '../../domain/entity/id_card_entity.dart';
import '../network/id_card_service.dart';
import 'id_card_service_datasource.dart';

@Injectable(as: IdCardServiceDataSource)
class IdCardServiceDataSourceImpl extends IdCardServiceDataSource {
  final IdCardService _idCardService;

  IdCardServiceDataSourceImpl(this._idCardService);

  @override
  Future<GenericResponseData<IDCardEntity>> readIdCard() {
    return _idCardService.readIdCard();
  }
}
