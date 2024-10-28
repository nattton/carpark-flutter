import 'package:carpark/constants.dart';
import 'package:carpark/core/cubit/app_user_cubit.dart';
import 'package:carpark/features/auth/data/data_sources/auth_api_service.dart';
import 'package:carpark/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:carpark/features/auth/domain/repository/auth_repository.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  _initAuth();

  // Dio
  final dio = Dio();
  dio.options.baseUrl = kHostUrl;
  dio.options.headers['Content-Type'] = 'application/json';
  sl.registerSingleton<Dio>(dio);

  sl.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();

  sl.registerSingleton(AppService(prefs: sl()));

  //
  sl.registerSingleton<ApiService>(ApiService(sl()));

  // core
  sl.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  sl.registerFactory<AuthApiService>(() => AuthApiService(sl()));

  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authApiService: sl()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(appUserCubit: sl()));
}
