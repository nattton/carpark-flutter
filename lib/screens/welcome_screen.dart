import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/screens/login_screen.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

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
    AppService appService = await AppService.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    if (!appService.isLogIn()) {
      appService.logout().then((value) {
        goLoginPage();
      });
      return;
    }
    goAdminScreen();
  }

  void goLoginPage() {
    Navigator.of(context).pushNamed(LoginScreen.id);
  }

  void goAdminScreen() {
    Navigator.of(context).pushNamed(MainScreen.id).then((value) {
      goLoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: kBackgroundGradiant),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
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
