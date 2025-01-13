import 'package:carpark/constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();

@module
abstract class SharedPreferencesModule {
  @preResolve
  @injectable
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: kHostUrl));
  // CONFIG FOR WEB
  // Dio get dio => Dio(
  //     BaseOptions(baseUrl: kIsWeb ? html.window.location.origin : kHostUrl));
}
