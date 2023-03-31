import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:carpark/models/login_user.dart';
import 'package:carpark/models/user.dart';
import 'package:carpark/models/member.dart';
import 'package:carpark/models/gate_log.dart';
import 'package:carpark/models/message_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kHostUrl = 'http://localhost:4000';
const kLoginUrl = '$kHostUrl/api/login';
const kAdminUserListUrl = '$kHostUrl/api/admin/users';
const kAdminUserUrl = '$kHostUrl/api/admin/user';
const kGateLogLastUrl = '$kHostUrl/api/gate_logs/last';
const kMemberUrl = '$kHostUrl/api/members';

const kRefreshTokenUrl = '$kHostUrl/api/refresh_token';

const kTokenKey = 'TOKEN_KEY';
const kUserKey = 'USER_KEY';

class AppService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String _token;
  late User _user;

  static Future<AppService> getInstance() async {
    AppService appService = AppService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appService._token = prefs.getString(kTokenKey) ?? '';
    String? userString = prefs.getString(kUserKey);
    if (userString != null) {
      try {
        appService._user = User.fromJson(jsonDecode(userString));
      } catch (e) {
        appService.logout();
      }
    } else {
      appService._user = User(0, "", "");
    }

    return appService;
  }

  bool isLogIn() {
    return _token != '';
  }

  User getUser() {
    return _user;
  }

  Future<void> _setToken(String token) async {
    _token = token;
    SharedPreferences prefs = await _prefs;
    await prefs.setString(kTokenKey, token);
  }

  Future<void> _setUser(User user) async {
    _user = user;
    SharedPreferences prefs = await _prefs;
    await prefs.setString(kUserKey, jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await _prefs;
    _token = "";
    _user = User(0, "", "");
    await prefs.clear();
  }

  Future<LoginUser> fetchLoginUser(String username, String password) async {
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    final response = await http.post(
      Uri.parse(kLoginUrl),
      body: jsonEncode(body).toString(),
    );

    if (response.statusCode == 200) {
      LoginUser loginData =
          LoginUser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (loginData.token != null) {
        await _setToken(loginData.token!);
        await _setUser(loginData.user!);
        return loginData;
      }
    }

    ErrorResponse errorResponse =
        ErrorResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return Future.error(errorResponse.error);
  }

  Future<LoginUser> fetchRefreshToken() async {
    final response = await http.post(
      Uri.parse(kRefreshTokenUrl),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      LoginUser loginData =
          LoginUser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (loginData.token != null) {
        await _setToken(loginData.token!);
        await _setUser(loginData.user!);
        return loginData;
      }
    }

    ErrorResponse errorResponse =
        ErrorResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return Future.error(errorResponse.error);
  }

  Future<List<User>> fetchUserList() async {
    final response = await http.get(Uri.parse(kAdminUserListUrl),
        headers: {'Authorization': 'Bearer $_token'});

    if (response.statusCode == 200) {
      try {
        final res = jsonDecode(utf8.decode(response.bodyBytes))["users"];
        return (res as List).map((data) => User.fromJson(data)).toList();
      } catch (e) {
        return Future.error(response);
      }
    }
    return Future.error(response);
  }

  Future saveUser(int id, String username, String password) async {
    Map<String, String> body = {
      "username": username,
      "password": password,
    };
    final response = await http.patch(
      Uri.parse('$kAdminUserUrl/$id'),
      headers: {'Authorization': 'Bearer $_token'},
      body: jsonEncode(body).toString(),
    );
    if (response.statusCode == 200) {
      MessageResponse msgResponse =
          MessageResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return msgResponse;
    } else if (response.statusCode == 304) {
      return Future.error("not modified");
    }
    return Future.error(response.body);
  }

  Future<LastGateLog> fetchLastGateLog() async {
    final response = await http.get(Uri.parse(kGateLogLastUrl),
        headers: {'Authorization': 'Bearer $_token'});

    if (response.statusCode == 200) {
      try {
        final res = jsonDecode(utf8.decode(response.bodyBytes));
        return LastGateLog.fromJson(res);
      } catch (e) {
        return Future.error(response);
      }
    }
    return Future.error(response);
  }

  Future<List<Member>> fetchMemberList() async {
    final response = await http.get(Uri.parse(kMemberUrl),
        headers: {'Authorization': 'Bearer $_token'});
    if (response.statusCode == 200) {
      try {
        final res = jsonDecode(utf8.decode(response.bodyBytes))["members"];

        return (res as List).map((data) => Member.fromJson(data)).toList();
      } catch (e) {
        return Future.error(response);
      }
    }
    return Future.error(response);
  }
}
