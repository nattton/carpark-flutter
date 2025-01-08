import 'package:carpark/core/presentation/bloc/app_title/app_title_cubit.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/screens/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppTitleCubit>(create: (context) => AppTitleCubit()),
      ],
      child: const ProviderScope(child: MyApp()),
    ),
  );
}
