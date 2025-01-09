import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';

class RegisteredUserMapper {
  static RegisteredUser responseMapper(RegisteredUserResponse response) {
    return RegisteredUser(
        id: response.id,
        generatedId: response.generatedId,
        type: response.type,
        telephone: response.telephone,
        idCard: response.idCard,
        thaiName: response.thaiName,
        engName: response.engName,
        birthdate: response.birthdate,
        gender: response.gender,
        address: response.address,
        photo: response.photo,
        createdAt: response.createdAt,
        updatedAt: response.updatedAt,
        expiredDate: response.expiredDate);
  }
}
