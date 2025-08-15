import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';

class RegisteredUserModel extends RegisteredUser {
  const RegisteredUserModel({
    required super.id,
    required super.generatedId,
    required super.type,
    required super.telephone,
    required super.idCard,
    required super.thaiName,
    required super.engName,
    required super.birthdate,
    required super.gender,
    required super.address,
    required super.photo,
    required super.createdAt,
    required super.updatedAt,
    required super.expiredDate,
  });

  factory RegisteredUserModel.responseMapper(RegisteredUserResponse response) {
    return RegisteredUserModel(
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
      expiredDate: response.expiredDate,
    );
  }
}
