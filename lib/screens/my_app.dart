import 'package:carpark/core/presentation/bloc/app_title/app_title_cubit.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_logs_screen.dart';
import 'package:carpark/screens/login_screen.dart';
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
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: context.read<AppTitleCubit>().state.title,
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
            case VisitorDetailScreen.id:
              final visitorId = settings.arguments as int;
              return MaterialPageRoute(builder: (context) {
                return VisitorDetailScreen(visitorId: visitorId);
              });
            case RegisteredUserLogsScreen.routeName:
              final userId = settings.arguments as int;
              return MaterialPageRoute(builder: (context) {
                return RegisteredUserLogsScreen.page(userId: userId);
              });
          }
          return null;
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
