import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_remote.dart';
import '../data/repositories/member/member_repository.dart';
import '../data/repositories/member/member_repository_remote.dart';
import '../data/repositories/printer/printer_repository_local.dart';
import '../data/services/api/api_service.dart';
import '../data/services/shared_preferences_service.dart';
import '../injector/injector.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => SharedPreferencesService()),
    ChangeNotifierProvider(
      create: (context) =>
          AuthRepositoryRemote(
                dio: getIt<Dio>(),
                apiService: getIt<ApiService>(),
                sharedPreferencesService: context.read(),
              )
              as AuthRepository,
    ),
    Provider(
      create: (context) =>
          PrinterRepositoryLocal(sharedPreferencesService: context.read()),
    ),
    Provider(
      create: (context) =>
          MemberRepositoryRemote(apiService: getIt<ApiService>())
              as MemberRepository,
    ),
  ];
}
