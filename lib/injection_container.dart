import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
