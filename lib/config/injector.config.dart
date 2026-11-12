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

import '../data/repositories/auth/auth_repository.dart' as _i161;
import '../data/repositories/auth/auth_repository_dev.dart' as _i941;
import '../data/repositories/auth/auth_repository_remote.dart' as _i1018;
import '../data/repositories/camera/camera_repository.dart' as _i101;
import '../data/repositories/camera/camera_repository_remote.dart' as _i102;
import '../data/repositories/card_reader/id_card_service_repository.dart'
    as _i180;
import '../data/repositories/card_reader/id_card_service_repository_impl.dart'
    as _i736;
import '../data/repositories/gate_log/gate_log_repository.dart' as _i103;
import '../data/repositories/gate_log/gate_log_repository_remote.dart' as _i104;
import '../data/repositories/member/member_repository.dart' as _i986;
import '../data/repositories/member/member_repository_local.dart' as _i1061;
import '../data/repositories/member/member_repository_remote.dart' as _i718;
import '../data/repositories/printer/printer_repository.dart' as _i788;
import '../data/repositories/printer/printer_repository_local.dart' as _i225;
import '../data/repositories/registered_user/registered_user_service_repository.dart'
    as _i568;
import '../data/repositories/registered_user/registered_user_service_repository_impl.dart'
    as _i178;
import '../data/repositories/report/report_repository.dart' as _i105;
import '../data/repositories/report/report_repository_remote.dart' as _i106;
import '../data/repositories/user/user_repository.dart' as _i107;
import '../data/repositories/user/user_repository_remote.dart' as _i108;
import '../data/repositories/visitor/visitor_repository.dart' as _i109;
import '../data/repositories/visitor/visitor_repository_remote.dart' as _i110;
import '../data/services/api/api_service.dart' as _i561;
import '../data/services/api/id_card_service.dart' as _i1033;
import '../data/services/api/registered_user_service.dart' as _i37;
import '../data/services/local/shared_preferences_service.dart' as _i29;
import '../ui/features/auth/login/view_models/login_viewmodel.dart' as _i226;
import '../ui/features/auth/logout/view_models/logout_viewmodel.dart' as _i97;
import '../ui/features/gate_log/view_models/gate_log_viewmodel.dart' as _i755;
import '../ui/features/gateway/view_models/entrance_viewmodel.dart' as _i201;
import '../ui/features/gateway/view_models/exit_viewmodel.dart' as _i202;
import '../ui/features/home/view_models/home_viewmodel.dart' as _i277;
import '../ui/features/home/view_models/last_gate_viewmodel.dart' as _i195;
import '../ui/features/live_player/view_models/live_player_viewmodel.dart'
    as _i183;
import '../ui/features/member/view_models/member_list_viewmodel.dart' as _i733;
import '../ui/features/registered_user/view_models/registered_user_check_out_viewmodel.dart'
    as _i989;
import '../ui/features/registered_user/view_models/registered_user_create_viewmodel.dart'
    as _i316;
import '../ui/features/registered_user/view_models/registered_user_list_viewmodel.dart'
    as _i114;
import '../ui/features/registered_user/view_models/registered_user_logs_viewmodel.dart'
    as _i1070;
import '../ui/features/registered_user/view_models/registered_user_not_check_out_viewmodel.dart'
    as _i77;
import '../ui/features/registered_user/view_models/registered_user_update_viewmodel.dart'
    as _i1045;
import '../ui/features/report/view_models/report_viewmodel.dart' as _i203;
import '../ui/features/setting/view_models/printer_viewmodel.dart' as _i282;
import '../ui/features/setting/view_models/setting_viewmodel.dart' as _i204;
import '../ui/features/user/view_models/user_viewmodel.dart' as _i205;
import '../ui/features/visitor/view_models/visitor_detail_viewmodel.dart'
    as _i598;
import '../ui/features/visitor/view_models/visitor_viewmodel.dart' as _i597;
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
    gh.factory<_i101.CameraRepository>(
      () => _i102.CameraRepositoryRemote(apiService: gh<_i561.ApiService>()),
    );
    gh.factory<_i103.GateLogRepository>(
      () => _i104.GateLogRepositoryRemote(apiService: gh<_i561.ApiService>()),
    );
    gh.factory<_i105.ReportRepository>(
      () => _i106.ReportRepositoryRemote(apiService: gh<_i561.ApiService>()),
    );
    gh.factory<_i107.UserRepository>(
      () => _i108.UserRepositoryRemote(apiService: gh<_i561.ApiService>()),
    );
    gh.factory<_i109.VisitorRepository>(
      () => _i110.VisitorRepositoryRemote(apiService: gh<_i561.ApiService>()),
    );
    gh.singleton<_i755.GateLogViewmodel>(
      () => _i755.GateLogViewmodel(
        gateLogRepository: gh<_i103.GateLogRepository>(),
      ),
    );
    gh.singleton<_i195.LastGateViewmodel>(
      () => _i195.LastGateViewmodel(
        gateLogRepository: gh<_i103.GateLogRepository>(),
      ),
    );
    gh.singleton<_i183.LivePlayerViewmodel>(
      () => _i183.LivePlayerViewmodel(
        cameraRepository: gh<_i101.CameraRepository>(),
      ),
    );
    gh.singleton<_i597.VisitorViewmodel>(
      () => _i597.VisitorViewmodel(
        visitorRepository: gh<_i109.VisitorRepository>(),
      ),
    );
    gh.factory<_i598.VisitorDetailViewModel>(
      () => _i598.VisitorDetailViewModel(
        visitorRepository: gh<_i109.VisitorRepository>(),
      ),
    );
    gh.factory<_i282.PrinterViewModel>(
      () => _i282.PrinterViewModel(
        printerRepository: gh<_i788.PrinterRepository>(),
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
        idCardService: gh<_i1033.IdCardService>(),
        dio: gh<_i361.Dio>(),
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
        registeredUserService: gh<_i37.RegisteredUserService>(),
      ),
    );
    gh.factory<_i989.RegisteredUserCheckOutViewModel>(
      () => _i989.RegisteredUserCheckOutViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i316.RegisteredUserCreateViewModel>(
      () => _i316.RegisteredUserCreateViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
        idCardRepository: gh<_i180.IdCardServiceRepository>(),
      ),
    );
    gh.factory<_i1070.RegisteredUserLogsViewModel>(
      () => _i1070.RegisteredUserLogsViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i77.RegisteredUserNotCheckOutViewModel>(
      () => _i77.RegisteredUserNotCheckOutViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i1045.RegisteredUserUpdateViewModel>(
      () => _i1045.RegisteredUserUpdateViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i114.RegisteredUserListViewModel>(
      () => _i114.RegisteredUserListViewModel(
        repository: gh<_i568.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i201.EntranceViewModel>(
      () => _i201.EntranceViewModel(
        visitorRepository: gh<_i109.VisitorRepository>(),
        gateLogRepository: gh<_i103.GateLogRepository>(),
        idCardRepository: gh<_i180.IdCardServiceRepository>(),
        printerRepository: gh<_i788.PrinterRepository>(),
        livePlayerViewModel: gh<_i183.LivePlayerViewmodel>(),
        lastGateViewModel: gh<_i195.LastGateViewmodel>(),
      ),
    );
    gh.factory<_i202.ExitViewModel>(
      () => _i202.ExitViewModel(
        visitorRepository: gh<_i109.VisitorRepository>(),
        registeredUserRepository: gh<_i568.RegisteredUserServiceRepository>(),
        livePlayerViewModel: gh<_i183.LivePlayerViewmodel>(),
        lastGateViewModel: gh<_i195.LastGateViewmodel>(),
      ),
    );
    gh.factory<_i203.ReportViewModel>(
      () =>
          _i203.ReportViewModel(reportRepository: gh<_i105.ReportRepository>()),
    );
    gh.factory<_i204.SettingViewModel>(
      () => _i204.SettingViewModel(
        cameraRepository: gh<_i101.CameraRepository>(),
        livePlayerViewModel: gh<_i183.LivePlayerViewmodel>(),
      ),
    );
    gh.factory<_i205.UserViewModel>(
      () => _i205.UserViewModel(userRepository: gh<_i107.UserRepository>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i811.SharedPreferencesModule {}

class _$DioModule extends _i811.DioModule {}

class _$IdCardServiceModule extends _i1033.IdCardServiceModule {}

class _$ApiServiceModule extends _i561.ApiServiceModule {}

class _$RegisteredUserServiceModule extends _i37.RegisteredUserServiceModule {}
