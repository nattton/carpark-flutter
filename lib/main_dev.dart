import 'package:carpark/injector/injector.dart';
import 'package:carpark/my_app.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies(env: Environment.dev);
  runApp(const MyApp());
}
