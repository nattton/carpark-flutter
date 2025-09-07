import 'package:carpark/config/constants.dart';
// import 'package:universal_html/html.dart' as html;

import 'package:carpark/injector/injector.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({
  String? env = Environment.prod,
  EnvironmentFilter? environmentFilter,
}) async {
  await getIt.init(environment: env, environmentFilter: environmentFilter);
}

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
