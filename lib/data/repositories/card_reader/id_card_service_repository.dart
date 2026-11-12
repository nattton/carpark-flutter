import 'package:carpark/domain/models/id_card_entity.dart';
import 'package:carpark/utils/result.dart';

abstract class IdCardServiceRepository {
  Future<Result<IDCardEntity>> readIdCard();
  Future<Result<void>> downloadPhoto(String url, String savePath);
}
