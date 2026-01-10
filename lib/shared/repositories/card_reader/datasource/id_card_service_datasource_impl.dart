import 'package:carpark/shared/repositories/card_reader/datasource/id_card_service_datasource.dart';
import 'package:carpark/shared/repositories/card_reader/entity/id_card_entity.dart';
import 'package:carpark/shared/repositories/card_reader/network/id_card_service.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdCardServiceDataSource)
class IdCardServiceDataSourceImpl extends IdCardServiceDataSource {
  IdCardServiceDataSourceImpl(this._idCardService);
  final IdCardService _idCardService;

  @override
  Future<GenericResponseData<IDCardEntity>> readIdCard() {
    return _idCardService.readIdCard();
  }
}
