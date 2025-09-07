import 'package:carpark/injector/injector.dart';
import 'package:carpark/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}
