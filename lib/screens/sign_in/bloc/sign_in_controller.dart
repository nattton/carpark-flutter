import 'package:carpark/common/widgets/flutter_alert.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/screens/main/main_screen.dart';
import 'package:carpark/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  void handleSignIn() async {
    final state = context.read<SignInBloc>().state;
    final String username = state.username;
    final String password = state.password;
    if (username.isEmpty || password.isEmpty) {
      alertError(context, "Please fill username and password");
      return;
    }

    sl<ApiService>().login(username, password).then((value) async {
      await sl<AppService>().saveLogin(value);
      goToMainScreen();
    }).catchError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        alert(response.error);
      } else {
        alert(error.toString());
      }
      return;
    });
  }

  void alert(String message) {
    alertError(context, message);
  }

  void goToMainScreen() {
    Navigator.of(context).pushReplacementNamed(MainScreen.id);
  }
}
