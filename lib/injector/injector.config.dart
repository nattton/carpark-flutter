// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/datasources/registered_user/registered_user_service_datasource.dart'
    as _i515;
import '../data/datasources/registered_user/registered_user_service_datasource_impl.dart'
    as _i122;
import '../data/repositories/auth/auth_repository.dart' as _i401;
import '../data/repositories/auth/auth_repository_dev.dart' as _i860;
import '../data/repositories/auth/auth_repository_remote.dart' as _i399;
import '../data/repositories/member/member_repository.dart' as _i379;
import '../data/repositories/member/member_repository_local.dart' as _i176;
import '../data/repositories/member/member_repository_remote.dart' as _i155;
import '../data/repositories/printer/printer_repository.dart' as _i413;
import '../data/repositories/printer/printer_repository_local.dart' as _i228;
import '../data/repositories/registered_user/registered_user_service_repository.dart'
    as _i184;
import '../data/repositories/registered_user/registered_user_service_repository_impl.dart'
    as _i709;
import '../data/services/api/api_service.dart' as _i552;
import '../data/services/api/registered_user_service.dart' as _i217;
import '../data/services/shared_preferences_service.dart' as _i375;
import '../domain/use_cases/registered_user/get_registered_user_log_not_check_out_response.dart'
    as _i975;
import '../domain/use_cases/registered_user/get_registered_user_logs_usecase.dart'
    as _i68;
import '../domain/use_cases/registered_user/read_id_card_usecase.dart' as _i744;
import '../domain/use_cases/registered_user/registered_user_add_photo_usecase.dart'
    as _i322;
import '../domain/use_cases/registered_user/registered_user_check_in_usecase.dart'
    as _i541;
import '../domain/use_cases/registered_user/registered_user_check_out_usecase.dart'
    as _i809;
import '../domain/use_cases/registered_user/registered_user_create_usecase.dart'
    as _i300;
import '../domain/use_cases/registered_user/registered_user_get_usecase.dart'
    as _i619;
import '../domain/use_cases/registered_user/registered_user_list_usecase.dart'
    as _i1020;
import '../domain/use_cases/registered_user/registered_user_logs_usecase.dart'
    as _i894;
import '../domain/use_cases/registered_user/registered_user_update_usecase.dart'
    as _i113;
import '../features/gateway/data/datasource/id_card_service_datasource.dart'
    as _i680;
import '../features/gateway/data/datasource/id_card_service_datasource_impl.dart'
    as _i440;
import '../features/gateway/data/network/id_card_service.dart' as _i313;
import '../features/gateway/data/repository/id_card_service_repository_impl.dart'
    as _i1028;
import '../features/gateway/domain/repository/id_card_service_repository.dart'
    as _i325;
import '../ui/auth/login/view_models/login_viewmodel.dart' as _i1068;
import '../ui/auth/logout/view_models/logout_viewmodel.dart' as _i337;
import '../ui/home/view_models/home_viewmodel.dart' as _i152;
import '../ui/member/bloc/member_list/member_list_bloc.dart' as _i1056;
import '../ui/member/view_models/member_viewmodel.dart' as _i692;
import '../ui/registered_user/bloc/registered_user_check_in/registered_user_check_in_bloc.dart'
    as _i680;
import '../ui/registered_user/bloc/registered_user_check_out/registered_user_check_out_bloc.dart'
    as _i499;
import '../ui/registered_user/bloc/registered_user_create/registered_user_create_bloc.dart'
    as _i56;
import '../ui/registered_user/bloc/registered_user_list/registered_user_list_bloc.dart'
    as _i485;
import '../ui/registered_user/bloc/registered_user_logs/registered_user_logs_bloc.dart'
    as _i492;
import '../ui/registered_user/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart'
    as _i64;
import '../ui/registered_user/bloc/registered_user_update/registered_user_update_bloc.dart'
    as _i497;
import '../ui/setting/printer/view_models/printer_viewmodel.dart' as _i151;
import 'injector.dart' as _i811;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioModule = _$DioModule();
    final apiServiceModule = _$ApiServiceModule();
    final registeredUserServiceModule = _$RegisteredUserServiceModule();
    final idCardServiceModule = _$IdCardServiceModule();
    gh.factory<_i375.SharedPreferencesService>(
      () => _i375.SharedPreferencesService(),
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i152.HomeViewModel>(() => _i152.HomeViewModel());
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.singleton<_i401.AuthRepository>(
      () => _i860.AuthRepositoryDev(),
      registerFor: {_dev},
    );
    gh.factory<_i379.MemberRepository>(
      () => _i176.MemberRepositoryLocal(),
      registerFor: {_dev},
    );
    gh.singleton<_i552.ApiService>(
      () => apiServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i217.RegisteredUserService>(
      () => registeredUserServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i313.IdCardService>(
      () => idCardServiceModule.create(gh<_i361.Dio>()),
    );
    gh.factory<_i680.IdCardServiceDataSource>(
      () => _i440.IdCardServiceDataSourceImpl(gh<_i313.IdCardService>()),
    );
    gh.factory<_i515.RegisteredUserServiceDataSource>(
      () => _i122.RegisteredUserServiceDataSourceImpl(
        gh<_i217.RegisteredUserService>(),
      ),
    );
    gh.factory<_i325.IdCardServiceRepository>(
      () => _i1028.IdCardServiceRepositoryImpl(
        gh<_i680.IdCardServiceDataSource>(),
      ),
    );
    gh.factory<_i379.MemberRepository>(
      () => _i155.MemberRepositoryRemote(apiService: gh<_i552.ApiService>()),
      registerFor: {_prod},
    );
    gh.factory<_i744.ReadIdCardUsecase>(
      () => _i744.ReadIdCardUsecase(gh<_i325.IdCardServiceRepository>()),
    );
    gh.singleton<_i413.PrinterRepository>(
      () => _i228.PrinterRepositoryLocal(
        sharedPreferencesService: gh<_i375.SharedPreferencesService>(),
      ),
    );
    gh.singleton<_i401.AuthRepository>(
      () => _i399.AuthRepositoryRemote(
        dio: gh<_i361.Dio>(),
        apiService: gh<_i552.ApiService>(),
        sharedPreferencesService: gh<_i375.SharedPreferencesService>(),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i151.PrinterViewModel>(
      () => _i151.PrinterViewModel(
        printerRepository: gh<_i413.PrinterRepository>(),
      ),
    );
    gh.factory<_i184.RegisteredUserServiceRepository>(
      () => _i709.RegisteredUserServiceRepositoryImpl(
        gh<_i515.RegisteredUserServiceDataSource>(),
      ),
    );
    gh.singleton<_i1068.LoginViewModel>(
      () => _i1068.LoginViewModel(authRepository: gh<_i401.AuthRepository>()),
    );
    gh.factory<_i337.LogoutViewModel>(
      () => _i337.LogoutViewModel(authRepository: gh<_i401.AuthRepository>()),
    );
    gh.factory<_i1056.MemberListBloc>(
      () =>
          _i1056.MemberListBloc(memberRepository: gh<_i379.MemberRepository>()),
    );
    gh.singleton<_i692.MemberViewModel>(
      () =>
          _i692.MemberViewModel(memberRepository: gh<_i379.MemberRepository>()),
    );
    gh.factory<_i975.GetRegisteredUserLogNotCheckOutResponseUsecase>(
      () => _i975.GetRegisteredUserLogNotCheckOutResponseUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i68.GetRegisteredUserLogsUsecase>(
      () => _i68.GetRegisteredUserLogsUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i322.RegisteredUserAddPhotoUsecase>(
      () => _i322.RegisteredUserAddPhotoUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i541.RegisteredUserCheckInUsecase>(
      () => _i541.RegisteredUserCheckInUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i809.RegisteredUserCheckOutUsecase>(
      () => _i809.RegisteredUserCheckOutUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i300.RegisteredUserCreateUsecase>(
      () => _i300.RegisteredUserCreateUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i619.RegisteredUserGetUsecase>(
      () => _i619.RegisteredUserGetUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i1020.RegisteredUserListUsecase>(
      () => _i1020.RegisteredUserListUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i894.RegisteredUserLogsUsecase>(
      () => _i894.RegisteredUserLogsUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i113.RegisteredUserUpdateUsecase>(
      () => _i113.RegisteredUserUpdateUsecase(
        gh<_i184.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i64.RegisteredUserNotCheckOutBloc>(
      () => _i64.RegisteredUserNotCheckOutBloc(
        gh<_i975.GetRegisteredUserLogNotCheckOutResponseUsecase>(),
      ),
    );
    gh.factory<_i680.RegisteredUserCheckInBloc>(
      () => _i680.RegisteredUserCheckInBloc(
        gh<_i541.RegisteredUserCheckInUsecase>(),
      ),
    );
    gh.factory<_i485.RegisteredUserListBloc>(
      () =>
          _i485.RegisteredUserListBloc(gh<_i1020.RegisteredUserListUsecase>()),
    );
    gh.factory<_i56.RegisteredUserCreateBloc>(
      () => _i56.RegisteredUserCreateBloc(
        gh<_i300.RegisteredUserCreateUsecase>(),
        gh<_i744.ReadIdCardUsecase>(),
        gh<_i322.RegisteredUserAddPhotoUsecase>(),
      ),
    );
    gh.factory<_i499.RegisteredUserCheckOutBloc>(
      () => _i499.RegisteredUserCheckOutBloc(
        gh<_i809.RegisteredUserCheckOutUsecase>(),
      ),
    );
    gh.factory<_i492.RegisteredUserLogsBloc>(
      () =>
          _i492.RegisteredUserLogsBloc(gh<_i68.GetRegisteredUserLogsUsecase>()),
    );
    gh.factory<_i497.RegisteredUserUpdateBloc>(
      () => _i497.RegisteredUserUpdateBloc(
        gh<_i619.RegisteredUserGetUsecase>(),
        gh<_i113.RegisteredUserUpdateUsecase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i811.SharedPreferencesModule {}

class _$DioModule extends _i811.DioModule {}

class _$ApiServiceModule extends _i552.ApiServiceModule {}

class _$RegisteredUserServiceModule extends _i217.RegisteredUserServiceModule {}

class _$IdCardServiceModule extends _i313.IdCardServiceModule {}
