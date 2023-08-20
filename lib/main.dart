import 'package:carpark/injection_container.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:carpark/screens/my_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  DartVLC.initialize();
  await initializeDependencies();
  runApp(const ProviderScope(child: MyApp()));
}
