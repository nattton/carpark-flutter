import 'package:carpark/screens/welcome/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';
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
    WelcomeController(context: context).handleUserState();
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
