import 'package:carpark/screens/main_web_screen.dart';
import 'package:carpark/screens/login_screen.dart';
import 'package:carpark/screens/member_screen.dart';
import 'package:carpark/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Park',
      initialRoute: WelcomeScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case MemberScreen.id:
            final memberId = settings.arguments as int;
            return MaterialPageRoute(builder: (context) {
              return MemberScreen(memberId: memberId);
            });
        }
        return null;
      },
      builder: EasyLoading.init(),
    );
  }
}
