import 'package:carpark/config/injector.dart';
import 'package:carpark/my_app.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies(env: Environment.dev);
  runApp(const MyApp());
}
