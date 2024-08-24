import 'package:carpark/screens/display_screen.dart';
import 'package:carpark/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:carpark/screens/sign_in/sign_in_screen.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/screens/member_screen.dart';
import 'package:carpark/screens/visitor_detail_screen.dart';
import 'package:carpark/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
        ],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            title: 'Car Park',
            initialRoute: WelcomeScreen.id,
            debugShowCheckedModeBanner: false,
            routes: {
              WelcomeScreen.id: (context) => const WelcomeScreen(),
              SignInScreen.id: (context) => const SignInScreen(),
              MainScreen.id: (context) => const MainScreen(),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case MemberScreen.id:
                  final memberId = settings.arguments as int;
                  return MaterialPageRoute(builder: (context) {
                    return MemberScreen(memberId: memberId);
                  });
                case VisitorDetailScreen.id:
                  final visitorId = settings.arguments as int;
                  return MaterialPageRoute(builder: (context) {
                    return VisitorDetailScreen(visitorId: visitorId);
                  });
                case DisplayScreen.id:
                  final screenId = settings.arguments as int;
                  return MaterialPageRoute(builder: (context) {
                    return DisplayScreen(screenId: screenId);
                  });
              }
              return null;
            },
            builder: EasyLoading.init(),
          ),
        ));
  }
}
