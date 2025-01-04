import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource.dart';
import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource_impl.dart';
import 'package:carpark/features/registered_user/data/repositories/registered_user_service_repository_impl.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/registered_user/domain/usecases/usercases.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  sl.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();

  sl.registerSingleton(AppService(prefs: sl()));

  //
  sl.registerSingleton<ApiService>(ApiService(sl()));

  sl.registerSingleton<RegisteredUserServiceDataSource>(
      RegisteredUserServiceDataSourceImpl(sl()));
  sl.registerSingleton<RegisteredUserServiceRepository>(
      RegisteredUserServiceRepositoryImpl(sl()));

  sl.registerSingleton<RegisteredUserCheckInUsecase>(
      RegisteredUserCheckInUsecase(sl()));
  sl.registerSingleton<RegisteredUserCheckOutUsecase>(
      RegisteredUserCheckOutUsecase(sl()));
  sl.registerSingleton<RegisteredUserCreateUsecase>(
      RegisteredUserCreateUsecase(sl()));
  sl.registerSingleton<RegisteredUserUpdateUsecase>(
      RegisteredUserUpdateUsecase(sl()));
  sl.registerSingleton<RegisteredUserListUsecase>(
      RegisteredUserListUsecase(sl()));
}
