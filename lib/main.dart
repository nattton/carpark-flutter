import 'package:carpark/injection_container.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/screens/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await initializeDependencies();
  configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}
