import 'package:carpark/models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginUser {
  String? token;
  User? user;

  LoginUser(this.token, this.user);

  LoginUser.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    print(payload);
    user = User.fromJson(payload);
  }
}
