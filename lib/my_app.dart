import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/repositories/auth/auth_repository.dart';
import 'package:carpark/shared/rounting/router.dart';
import 'package:carpark/shared/ui/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: AppCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      routerConfig: router(getIt<AuthRepository>()),
      builder: EasyLoading.init(),
    );
  }
}
