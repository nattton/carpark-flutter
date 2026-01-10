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

import '../../features/auth/login/view_models/login_viewmodel.dart' as _i226;
import '../../features/auth/logout/view_models/logout_viewmodel.dart' as _i97;
import '../../features/gate_log/view_models/gate_log_viewmodel.dart' as _i755;
import '../../features/home/view_models/home_viewmodel.dart' as _i277;
import '../../features/home/view_models/late_gate_viewmodel.dart' as _i195;
import '../../features/live_player/view_models/live_player_viewmodel.dart'
    as _i183;
import '../../features/member/view_models/member_list_viewmodel.dart' as _i733;
import '../../features/registered_user/bloc/registered_user_check_in/registered_user_check_in_bloc.dart'
    as _i115;
import '../../features/registered_user/bloc/registered_user_check_out/registered_user_check_out_bloc.dart'
    as _i989;
import '../../features/registered_user/bloc/registered_user_create/registered_user_create_bloc.dart'
    as _i316;
import '../../features/registered_user/bloc/registered_user_list/registered_user_list_bloc.dart'
    as _i114;
import '../../features/registered_user/bloc/registered_user_logs/registered_user_logs_bloc.dart'
    as _i1070;
import '../../features/registered_user/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart'
    as _i77;
import '../../features/registered_user/bloc/registered_user_update/registered_user_update_bloc.dart'
    as _i1045;
import '../../features/registered_user/datasources/registered_user_service_datasource.dart'
    as _i972;
import '../../features/registered_user/datasources/registered_user_service_datasource_impl.dart'
    as _i1002;
import '../../features/registered_user/use_cases/get_registered_user_log_not_check_out_response.dart'
    as _i493;
import '../../features/registered_user/use_cases/get_registered_user_logs_usecase.dart'
    as _i910;
import '../../features/registered_user/use_cases/read_id_card_usecase.dart'
    as _i728;
import '../../features/registered_user/use_cases/registered_user_add_photo_usecase.dart'
    as _i64;
import '../../features/registered_user/use_cases/registered_user_check_in_usecase.dart'
    as _i752;
import '../../features/registered_user/use_cases/registered_user_check_out_usecase.dart'
    as _i118;
import '../../features/registered_user/use_cases/registered_user_create_usecase.dart'
    as _i353;
import '../../features/registered_user/use_cases/registered_user_get_usecase.dart'
    as _i520;
import '../../features/registered_user/use_cases/registered_user_list_usecase.dart'
    as _i10;
import '../../features/registered_user/use_cases/registered_user_logs_usecase.dart'
    as _i1025;
import '../../features/registered_user/use_cases/registered_user_update_usecase.dart'
    as _i31;
import '../../features/setting/printer/view_models/printer_viewmodel.dart'
    as _i282;
import '../../features/visitor/view_models/visitor_viewmodel.dart' as _i597;
import '../repositories/auth/auth_repository.dart' as _i161;
import '../repositories/auth/auth_repository_dev.dart' as _i941;
import '../repositories/auth/auth_repository_remote.dart' as _i1018;
import '../repositories/card_reader/datasource/id_card_service_datasource.dart'
    as _i282;
import '../repositories/card_reader/datasource/id_card_service_datasource_impl.dart'
    as _i710;
import '../repositories/card_reader/id_card_service_repository.dart' as _i180;
import '../repositories/card_reader/id_card_service_repository_impl.dart'
    as _i736;
import '../repositories/card_reader/network/id_card_service.dart' as _i1033;
import '../repositories/member/member_repository.dart' as _i986;
import '../repositories/member/member_repository_local.dart' as _i1061;
import '../repositories/member/member_repository_remote.dart' as _i718;
import '../repositories/printer/printer_repository.dart' as _i788;
import '../repositories/printer/printer_repository_local.dart' as _i225;
import '../repositories/registered_user/registered_user_service_repository.dart'
    as _i568;
import '../repositories/registered_user/registered_user_service_repository_impl.dart'
    as _i178;
import '../services/api/api_service.dart' as _i561;
import '../services/api/registered_user_service.dart' as _i37;
import '../services/shared_preferences_service.dart' as _i29;
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
    final idCardServiceModule = _$IdCardServiceModule();
    final apiServiceModule = _$ApiServiceModule();
    final registeredUserServiceModule = _$RegisteredUserServiceModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i29.SharedPreferencesService>(
      () => _i29.SharedPreferencesService(),
    );
    gh.singleton<_i277.HomeViewModel>(() => _i277.HomeViewModel());
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i986.MemberRepository>(
      () => _i1061.MemberRepositoryLocal(),
      registerFor: {_dev},
    );
    gh.singleton<_i161.AuthRepository>(
      () => _i941.AuthRepositoryDev(),
      registerFor: {_dev},
    );
    gh.singleton<_i1033.IdCardService>(
      () => idCardServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i561.ApiService>(
      () => apiServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i37.RegisteredUserService>(
      () => registeredUserServiceModule.create(gh<_i361.Dio>()),
    );
    gh.factory<_i282.IdCardServiceDataSource>(
      () => _i710.IdCardServiceDataSourceImpl(gh<_i1033.IdCardService>()),
    );
    gh.singleton<_i788.PrinterRepository>(
      () => _i225.PrinterRepositoryLocal(
        sharedPreferencesService: gh<_i29.SharedPreferencesService>(),
      ),
    );
    gh.singleton<_i161.AuthRepository>(
      () => _i1018.AuthRepositoryRemote(
        dio: gh<_i361.Dio>(),
        apiService: gh<_i561.ApiService>(),
        sharedPreferencesService: gh<_i29.SharedPreferencesService>(),
      ),
      registerFor: {_prod},
    );
    gh.singleton<_i755.GateLogViewmodel>(
      () => _i755.GateLogViewmodel(apiService: gh<_i561.ApiService>()),
    );
    gh.singleton<_i195.LastGateViewmodel>(
      () => _i195.LastGateViewmodel(apiService: gh<_i561.ApiService>()),
    );
    gh.singleton<_i183.LivePlayerViewmodel>(
      () => _i183.LivePlayerViewmodel(apiService: gh<_i561.ApiService>()),
    );
    gh.singleton<_i597.VisitorViewmodel>(
      () => _i597.VisitorViewmodel(apiService: gh<_i561.ApiService>()),
    );
    gh.factory<_i282.PrinterViewModel>(
      () => _i282.PrinterViewModel(
        printerRepository: gh<_i788.PrinterRepository>(),
      ),
    );
    gh.factory<_i972.RegisteredUserServiceDataSource>(
      () => _i1002.RegisteredUserServiceDataSourceImpl(
        gh<_i37.RegisteredUserService>(),
      ),
    );
    gh.factory<_i986.MemberRepository>(
      () => _i718.MemberRepositoryRemote(apiService: gh<_i561.ApiService>()),
      registerFor: {_prod},
    );
    gh.singleton<_i733.MemberListViewModel>(
      () => _i733.MemberListViewModel(
        memberRepository: gh<_i986.MemberRepository>(),
      ),
    );
    gh.factory<_i180.IdCardServiceRepository>(
      () => _i736.IdCardServiceRepositoryImpl(
        gh<_i282.IdCardServiceDataSource>(),
      ),
    );
    gh.singleton<_i226.LoginViewModel>(
      () => _i226.LoginViewModel(authRepository: gh<_i161.AuthRepository>()),
    );
    gh.singleton<_i97.LogoutViewModel>(
      () => _i97.LogoutViewModel(authRepository: gh<_i161.AuthRepository>()),
    );
    gh.factory<_i568.RegisteredUserServiceRepository>(
      () => _i178.RegisteredUserServiceRepositoryImpl(
        gh<_i972.RegisteredUserServiceDataSource>(),
      ),
    );
    gh.factory<_i728.ReadIdCardUsecase>(
      () => _i728.ReadIdCardUsecase(gh<_i180.IdCardServiceRepository>()),
    );
    gh.factory<_i493.GetRegisteredUserLogNotCheckOutResponseUsecase>(
      () => _i493.GetRegisteredUserLogNotCheckOutResponseUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i910.GetRegisteredUserLogsUsecase>(
      () => _i910.GetRegisteredUserLogsUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i64.RegisteredUserAddPhotoUsecase>(
      () => _i64.RegisteredUserAddPhotoUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i752.RegisteredUserCheckInUsecase>(
      () => _i752.RegisteredUserCheckInUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i118.RegisteredUserCheckOutUsecase>(
      () => _i118.RegisteredUserCheckOutUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i353.RegisteredUserCreateUsecase>(
      () => _i353.RegisteredUserCreateUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i520.RegisteredUserGetUsecase>(
      () => _i520.RegisteredUserGetUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i10.RegisteredUserListUsecase>(
      () => _i10.RegisteredUserListUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i1025.RegisteredUserLogsUsecase>(
      () => _i1025.RegisteredUserLogsUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i31.RegisteredUserUpdateUsecase>(
      () => _i31.RegisteredUserUpdateUsecase(
        gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i989.RegisteredUserCheckOutBloc>(
      () => _i989.RegisteredUserCheckOutBloc(
        gh<_i118.RegisteredUserCheckOutUsecase>(),
      ),
    );
    gh.factory<_i316.RegisteredUserCreateBloc>(
      () => _i316.RegisteredUserCreateBloc(
        gh<_i353.RegisteredUserCreateUsecase>(),
        gh<_i728.ReadIdCardUsecase>(),
        gh<_i64.RegisteredUserAddPhotoUsecase>(),
      ),
    );
    gh.factory<_i115.RegisteredUserCheckInBloc>(
      () => _i115.RegisteredUserCheckInBloc(
        gh<_i752.RegisteredUserCheckInUsecase>(),
      ),
    );
    gh.factory<_i1070.RegisteredUserLogsBloc>(
      () => _i1070.RegisteredUserLogsBloc(
        gh<_i910.GetRegisteredUserLogsUsecase>(),
      ),
    );
    gh.factory<_i77.RegisteredUserNotCheckOutBloc>(
      () => _i77.RegisteredUserNotCheckOutBloc(
        gh<_i493.GetRegisteredUserLogNotCheckOutResponseUsecase>(),
      ),
    );
    gh.factory<_i1045.RegisteredUserUpdateBloc>(
      () => _i1045.RegisteredUserUpdateBloc(
        gh<_i520.RegisteredUserGetUsecase>(),
        gh<_i31.RegisteredUserUpdateUsecase>(),
      ),
    );
    gh.factory<_i114.RegisteredUserListBloc>(
      () => _i114.RegisteredUserListBloc(gh<_i10.RegisteredUserListUsecase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i811.SharedPreferencesModule {}

class _$DioModule extends _i811.DioModule {}

class _$IdCardServiceModule extends _i1033.IdCardServiceModule {}

class _$ApiServiceModule extends _i561.ApiServiceModule {}

class _$RegisteredUserServiceModule extends _i37.RegisteredUserServiceModule {}
