import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';

class RegisteredUserListMapper {
  static List<RegisteredUser> responseMapper(
      List<RegisteredUserResponse> response) {
    return response
        .map((e) => RegisteredUser(
            id: e.id,
            generatedId: e.generatedId,
            type: e.type,
            telephone: e.telephone,
            idCard: e.idCard,
            thaiName: e.thaiName,
            engName: e.engName,
            birthdate: e.birthdate,
            gender: e.gender,
            address: e.address,
            photo: e.photo,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            expiredDate: e.expiredDate))
        .toList();
  }
}
