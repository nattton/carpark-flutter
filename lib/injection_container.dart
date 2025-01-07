import 'package:carpark/constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  Dio dio = Dio();
  dio.options.baseUrl = kHostUrl;
  sl.registerSingleton<Dio>(dio);

  sl.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  await sl.isReady<SharedPreferences>();
}
