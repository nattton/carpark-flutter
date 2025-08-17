import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../rounting/router.dart';
import '../ui/core/ui/scroll_behavior.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: AppCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      routerConfig: router(context.read()),
      builder: EasyLoading.init(),
    );
  }
}
