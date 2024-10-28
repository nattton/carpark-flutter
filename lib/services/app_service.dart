import 'dart:convert';

import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kTokenKey = 'TOKEN_KEY';
const kUserKey = 'USER_KEY';
const kPrinterKey = 'PRINTER_KEY';

class AppService {
  final SharedPreferences prefs;

  AppService({required this.prefs});

  get token => prefs.getString(kTokenKey) ?? '';
  get printer => prefs.getString(kPrinterKey) ?? '';

  Future<void> saveLogin(UserLoginModel login) async {
    await prefs.setString(kTokenKey, "Bearer ${login.refreshToken}");
    await prefs.setString(kUserKey, jsonEncode(login.user.toJson()));
  }

  Future<void> savePrinter(String printerName) async {
    await prefs.setString(kPrinterKey, printerName);
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
    await prefs.remove(kUserKey);
    await prefs.remove(kTokenKey);
  }
}
