import 'package:carpark/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: EasyLoading.init(),
    );

    // return MaterialApp(
    //   title: context.read<AppTitleCubit>().state.title,
    //   initialRoute: WelcomeScreen.routeName,
    //   debugShowCheckedModeBanner: false,
    //   routes: {
    //     WelcomeScreen.routeName: (context) => const WelcomeScreen(),
    //     LoginScreen.routeName: (context) => const LoginScreen(),
    //     MainScreen.routeName: (context) => MainScreen.page,
    //   },
    //   onGenerateRoute: (settings) {
    //     switch (settings.name) {
    //       case MemberScreen.routeName:
    //         final memberId = settings.arguments as int;
    //         return MaterialPageRoute(builder: (context) {
    //           return MemberScreen(memberId: memberId);
    //         });
    //       case VisitorDetailScreen.routeName:
    //         final visitorId = settings.arguments as int;
    //         return MaterialPageRoute(builder: (context) {
    //           return VisitorDetailScreen(visitorId: visitorId);
    //         });
    //       case RegisteredUserLogsScreen.routeName:
    //         final userId = settings.arguments as int;
    //         return MaterialPageRoute(builder: (context) {
    //           return RegisteredUserLogsScreen.page(userId: userId);
    //         });
    //     }
    //     return null;
    //   },
    //   builder: EasyLoading.init(),
    // );
  }
}
