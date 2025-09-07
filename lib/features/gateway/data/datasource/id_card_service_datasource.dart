import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/utils/generic_response_data.dart';

abstract class IdCardServiceDataSource {
  Future<GenericResponseData<IDCardEntity>> readIdCard();
}
