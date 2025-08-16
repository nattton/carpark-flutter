import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'core/presentation/bloc/app_title/app_title_cubit.dart';
import 'injector/injector.dart';
import 'screens/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: providersRemote,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppTitleCubit>(
            create: (context) => getIt<AppTitleCubit>(),
          ),
        ],
        child: const ProviderScope(child: MyApp()),
      ),
    ),
  );
}
