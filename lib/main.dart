import 'package:carpark/core/cubit/app_user_cubit.dart';
import 'package:carpark/features/auth/presention/bloc/auth_bloc.dart';
import 'package:carpark/features/main/presention/cubit/player_cubit.dart';
import 'package:carpark/features/member/presention/bloc/member_bloc.dart';
import 'package:carpark/features/member/presention/bloc/vehicle_bloc.dart';
import 'package:carpark/features/member/presention/cubit/member_list_cubit.dart';
import 'package:carpark/features/people/presention/bloc/people_bloc.dart';
import 'package:carpark/features/people/presention/bloc/person_bloc.dart';
import 'package:carpark/features/vehicle/presention/bloc/vehicles_bloc.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/screens/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await initializeDependencies();

  runApp(ProviderScope(
      child: MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<AppUserCubit>()),
    BlocProvider(create: (_) => sl<AuthBloc>()),
    BlocProvider(create: (_) => PlayerCubit()),
    BlocProvider(create: (_) => MemberListCubit()),
    BlocProvider(create: (_) => MemberBloc()),
    BlocProvider(create: (_) => VehicleBloc()),
    BlocProvider(create: (_) => PeopleBloc()),
    BlocProvider(create: (_) => PersonBloc()),
    BlocProvider(create: (_) => VehiclesBloc()),
  ], child: const MyApp())));
}
