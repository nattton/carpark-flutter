import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:injectable/injectable.dart';
import 'package:media_kit/media_kit.dart';

import 'injector/injector.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies(env: Environment.prod);
  runApp(const ProviderScope(child: MyApp()));
}
