// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

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

import '../core/presentation/bloc/app_title/app_title_cubit.dart' as _i314;
import '../data/services/api/api_service.dart' as _i552;
import '../features/gateway/data/datasource/id_card_service_datasource.dart'
    as _i680;
import '../features/gateway/data/datasource/id_card_service_datasource_impl.dart'
    as _i440;
import '../features/gateway/data/network/id_card_service.dart' as _i313;
import '../features/gateway/data/repository/id_card_service_repository_impl.dart'
    as _i1028;
import '../features/gateway/domain/repository/id_card_service_repository.dart'
    as _i325;
import '../features/member/presentation/bloc/member_list/member_list_bloc.dart'
    as _i207;
import '../features/registered_user/data/datasources/registered_user_service_datasource.dart'
    as _i798;
import '../features/registered_user/data/datasources/registered_user_service_datasource_impl.dart'
    as _i790;
import '../features/registered_user/data/network/registered_user_service.dart'
    as _i636;
import '../features/registered_user/data/repositories/registered_user_service_repository_impl.dart'
    as _i296;
import '../features/registered_user/domain/repositories/registered_user_service_repository.dart'
    as _i960;
import '../features/registered_user/domain/usecases/get_registered_user_log_not_check_out_response.dart'
    as _i1039;
import '../features/registered_user/domain/usecases/get_registered_user_logs_usecase.dart'
    as _i287;
import '../features/registered_user/domain/usecases/read_id_card_usecase.dart'
    as _i399;
import '../features/registered_user/domain/usecases/registered_user_add_photo_usecase.dart'
    as _i856;
import '../features/registered_user/domain/usecases/registered_user_check_in_usecase.dart'
    as _i1063;
import '../features/registered_user/domain/usecases/registered_user_check_out_usecase.dart'
    as _i815;
import '../features/registered_user/domain/usecases/registered_user_create_usecase.dart'
    as _i589;
import '../features/registered_user/domain/usecases/registered_user_get_usecase.dart'
    as _i173;
import '../features/registered_user/domain/usecases/registered_user_list_usecase.dart'
    as _i390;
import '../features/registered_user/domain/usecases/registered_user_logs_usecase.dart'
    as _i908;
import '../features/registered_user/domain/usecases/registered_user_update_usecase.dart'
    as _i544;
import '../features/registered_user/presentation/bloc/registered_user_check_in/registered_user_check_in_bloc.dart'
    as _i399;
import '../features/registered_user/presentation/bloc/registered_user_check_out/registered_user_check_out_bloc.dart'
    as _i349;
import '../features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart'
    as _i582;
import '../features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart'
    as _i707;
import '../features/registered_user/presentation/bloc/registered_user_logs/registered_user_logs_bloc.dart'
    as _i540;
import '../features/registered_user/presentation/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart'
    as _i813;
import '../features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart'
    as _i92;
import '../services/app_service.dart' as _i479;
import 'injector.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioModule = _$DioModule();
    final appServiceModule = _$AppServiceModule();
    final apiServiceModule = _$ApiServiceModule();
    final idCardServiceModule = _$IdCardServiceModule();
    final registeredUserServiceModule = _$RegisteredUserServiceModule();
    gh.factory<_i314.AppTitleCubit>(() => _i314.AppTitleCubit());
    gh.factory<_i207.MemberListBloc>(() => _i207.MemberListBloc());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.singleton<_i479.AppService>(
      () => appServiceModule.create(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i552.ApiService>(
      () => apiServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i313.IdCardService>(
      () => idCardServiceModule.create(gh<_i361.Dio>()),
    );
    gh.singleton<_i636.RegisteredUserService>(
      () => registeredUserServiceModule.create(gh<_i361.Dio>()),
    );
    gh.factory<_i680.IdCardServiceDataSource>(
      () => _i440.IdCardServiceDataSourceImpl(gh<_i313.IdCardService>()),
    );
    gh.factory<_i798.RegisteredUserServiceDataSource>(
      () => _i790.RegisteredUserServiceDataSourceImpl(
        gh<_i636.RegisteredUserService>(),
      ),
    );
    gh.factory<_i325.IdCardServiceRepository>(
      () => _i1028.IdCardServiceRepositoryImpl(
        gh<_i680.IdCardServiceDataSource>(),
      ),
    );
    gh.factory<_i399.ReadIdCardUsecase>(
      () => _i399.ReadIdCardUsecase(gh<_i325.IdCardServiceRepository>()),
    );
    gh.factory<_i960.RegisteredUserServiceRepository>(
      () => _i296.RegisteredUserServiceRepositoryImpl(
        gh<_i798.RegisteredUserServiceDataSource>(),
      ),
    );
    gh.factory<_i287.GetRegisteredUserLogsUsecase>(
      () => _i287.GetRegisteredUserLogsUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i1039.GetRegisteredUserLogNotCheckOutResponseUsecase>(
      () => _i1039.GetRegisteredUserLogNotCheckOutResponseUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i856.RegisteredUserAddPhotoUsecase>(
      () => _i856.RegisteredUserAddPhotoUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i1063.RegisteredUserCheckInUsecase>(
      () => _i1063.RegisteredUserCheckInUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i815.RegisteredUserCheckOutUsecase>(
      () => _i815.RegisteredUserCheckOutUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i589.RegisteredUserCreateUsecase>(
      () => _i589.RegisteredUserCreateUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i173.RegisteredUserGetUsecase>(
      () => _i173.RegisteredUserGetUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i390.RegisteredUserListUsecase>(
      () => _i390.RegisteredUserListUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i908.RegisteredUserLogsUsecase>(
      () => _i908.RegisteredUserLogsUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i544.RegisteredUserUpdateUsecase>(
      () => _i544.RegisteredUserUpdateUsecase(
        gh<_i960.RegisteredUserServiceRepository>(),
      ),
    );
    gh.factory<_i399.RegisteredUserCheckInBloc>(
      () => _i399.RegisteredUserCheckInBloc(
        gh<_i1063.RegisteredUserCheckInUsecase>(),
      ),
    );
    gh.factory<_i707.RegisteredUserListBloc>(
      () => _i707.RegisteredUserListBloc(gh<_i390.RegisteredUserListUsecase>()),
    );
    gh.factory<_i92.RegisteredUserUpdateBloc>(
      () => _i92.RegisteredUserUpdateBloc(
        gh<_i173.RegisteredUserGetUsecase>(),
        gh<_i544.RegisteredUserUpdateUsecase>(),
      ),
    );
    gh.factory<_i540.RegisteredUserLogsBloc>(
      () => _i540.RegisteredUserLogsBloc(
        gh<_i287.GetRegisteredUserLogsUsecase>(),
      ),
    );
    gh.factory<_i349.RegisteredUserCheckOutBloc>(
      () => _i349.RegisteredUserCheckOutBloc(
        gh<_i815.RegisteredUserCheckOutUsecase>(),
      ),
    );
    gh.factory<_i582.RegisteredUserCreateBloc>(
      () => _i582.RegisteredUserCreateBloc(
        gh<_i589.RegisteredUserCreateUsecase>(),
        gh<_i399.ReadIdCardUsecase>(),
        gh<_i856.RegisteredUserAddPhotoUsecase>(),
      ),
    );
    gh.factory<_i813.RegisteredUserNotCheckOutBloc>(
      () => _i813.RegisteredUserNotCheckOutBloc(
        gh<_i1039.GetRegisteredUserLogNotCheckOutResponseUsecase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i811.SharedPreferencesModule {}

class _$DioModule extends _i811.DioModule {}

class _$AppServiceModule extends _i479.AppServiceModule {}

class _$ApiServiceModule extends _i552.ApiServiceModule {}

class _$IdCardServiceModule extends _i313.IdCardServiceModule {}

class _$RegisteredUserServiceModule extends _i636.RegisteredUserServiceModule {}
