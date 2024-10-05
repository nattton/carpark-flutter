import 'package:carpark/core/cubit/app_user_cubit.dart';
import 'package:carpark/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:carpark/features/main/presentation/pages/main_screen.dart';
import 'package:carpark/features/member/presentation/pages/member_screen.dart';
import 'package:carpark/features/people/presentation/pages/person_screen.dart';
import 'package:carpark/screens/display_screen.dart';
import 'package:carpark/screens/visitor_detail_screen.dart';
import 'package:carpark/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Car Park',
        initialRoute: WelcomeScreen.id,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(selector: (state) {
          return state is LoggedIn;
        }, builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const MainScreen();
          }
          return const SignInScreen();
        }),
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
            case PersonScreen.id:
              final personId = settings.arguments as String;
              return MaterialPageRoute(builder: (context) {
                return PersonScreen(
                  personId: personId,
                );
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
    );
  }
}
