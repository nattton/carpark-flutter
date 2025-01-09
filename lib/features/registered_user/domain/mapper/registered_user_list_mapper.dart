import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';

class RegisteredUserListMapper {
  static List<RegisteredUser> responseMapper(
      List<RegisteredUserResponse> response) {
    return response.map((e) => RegisteredUserMapper.responseMapper(e)).toList();
  }
}
