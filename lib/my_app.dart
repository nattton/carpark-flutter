import 'package:carpark/config/injector.dart';
import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/routing/router.dart';
import 'package:carpark/ui/core/scroll_behavior.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_ui/material_ui.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

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
