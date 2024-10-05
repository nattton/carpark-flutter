import 'package:carpark/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:carpark/features/main/presentation/pages/main_screen.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';

class WelcomeController {
  final BuildContext context;

  const WelcomeController({required this.context});

  void handleUserState() async {
    var app = sl<AppService>();
    await Future.delayed(const Duration(seconds: 1));
    if (!app.isLogIn()) {
      app.logout().then((value) {
        goToSignInScreen();
      });
    } else {
      goToMainScreen();
    }
  }

  void goToSignInScreen() {
    Navigator.of(context).pushNamed(SignInScreen.id);
  }

  void goToMainScreen() {
    Navigator.of(context).pushNamed(MainScreen.id);
  }
}
