import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../injector/injector.dart';
import '../services/app_service.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import 'main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final app = getIt<AppService>();
    await Future.delayed(const Duration(seconds: 1));
    if (!app.isLogIn()) {
      app.logout().then((value) {
        goLoginPage();
      });
      return;
    }
    goAdminScreen();
  }

  void goLoginPage() {
    context.go(LoginScreen.routeName);
  }

  void goAdminScreen() {
    context.go(MainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: kBackgroundGradiant),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Car Park',
                    style: TextStyle(
                      fontSize: 56.0,
                      fontFamily: kDefaultFont,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Car Park Management System',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: kDefaultFont,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
