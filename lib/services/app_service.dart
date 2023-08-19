import 'dart:convert';
import 'package:carpark/models/user_model.dart';
import 'package:carpark/models/login_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kTokenKey = 'TOKEN_KEY';
const kUserKey = 'USER_KEY';

class AppService {
  final SharedPreferences prefs;

  AppService({required this.prefs});

  get token => prefs.getString(kTokenKey) ?? '';

  Future<void> saveLogin(LoginUserModel login) async {
    await prefs.setString(kTokenKey, login.token);
    await prefs.setString(kUserKey, jsonEncode(login.user.toJson()));
  }

  bool isLogIn() {
    return token != '';
  }

  UserModel? getUser() {
    String? userString = prefs.getString(kUserKey);
    if (userString != null) {
      try {
        return UserModel.fromJson(jsonDecode(userString));
      } catch (e) {
        logout();
      }
    }
    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
  }
}
