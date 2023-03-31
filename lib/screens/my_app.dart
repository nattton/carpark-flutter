import 'package:carpark/models/member.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/screens/login_screen.dart';
import 'package:carpark/screens/vehicle_screen.dart';
import 'package:carpark/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Car Park',
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          MainScreen.id: (context) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case VehicleScreen.id:
              final member = settings.arguments as Member;
              return MaterialPageRoute(builder: (context) {
                return VehicleScreen(member: member);
              });
          }
          return null;
        });
  }
}
