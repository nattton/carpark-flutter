// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
import '../features/registered_user/domain/usecases/registered_user_list_usecase.dart'
    as _i390;
import '../features/registered_user/domain/usecases/registered_user_update_usecase.dart'
    as _i544;
import '../features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart'
    as _i582;
import '../features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart'
    as _i707;
import '../features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart'
    as _i92;
import '../services/api_service.dart' as _i137;
import '../services/app_service.dart' as _i479;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registeredUserServiceModule = _$RegisteredUserServiceModule();
    final apiServiceModule = _$ApiServiceModule();
    final appServiceModule = _$AppServiceModule();
    gh.singleton<_i636.RegisteredUserService>(
        () => registeredUserServiceModule.registeredUserService);
    gh.singleton<_i137.ApiService>(() => apiServiceModule.apiService);
    gh.singleton<_i479.AppService>(() => appServiceModule.appService);
    gh.factory<_i798.RegisteredUserServiceDataSource>(() =>
        _i790.RegisteredUserServiceDataSourceImpl(
            gh<_i636.RegisteredUserService>()));
    gh.factory<_i960.RegisteredUserServiceRepository>(() =>
        _i296.RegisteredUserServiceRepositoryImpl(
            gh<_i798.RegisteredUserServiceDataSource>()));
    gh.factory<_i399.ReadIdCardUsecase>(() =>
        _i399.ReadIdCardUsecase(gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i856.RegisteredUserAddPhotoUsecase>(() =>
        _i856.RegisteredUserAddPhotoUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i1063.RegisteredUserCheckInUsecase>(() =>
        _i1063.RegisteredUserCheckInUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i815.RegisteredUserCheckOutUsecase>(() =>
        _i815.RegisteredUserCheckOutUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i589.RegisteredUserCreateUsecase>(() =>
        _i589.RegisteredUserCreateUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i390.RegisteredUserListUsecase>(() =>
        _i390.RegisteredUserListUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i544.RegisteredUserUpdateUsecase>(() =>
        _i544.RegisteredUserUpdateUsecase(
            gh<_i960.RegisteredUserServiceRepository>()));
    gh.factory<_i707.RegisteredUserListBloc>(() =>
        _i707.RegisteredUserListBloc(gh<_i390.RegisteredUserListUsecase>()));
    gh.factory<_i582.RegisteredUserCreateBloc>(
        () => _i582.RegisteredUserCreateBloc(
              gh<_i589.RegisteredUserCreateUsecase>(),
              gh<_i399.ReadIdCardUsecase>(),
              gh<_i856.RegisteredUserAddPhotoUsecase>(),
            ));
    gh.factory<_i92.RegisteredUserUpdateBloc>(() =>
        _i92.RegisteredUserUpdateBloc(gh<_i544.RegisteredUserUpdateUsecase>()));
    return this;
  }
}

class _$RegisteredUserServiceModule extends _i636.RegisteredUserServiceModule {}

class _$ApiServiceModule extends _i137.ApiServiceModule {}

class _$AppServiceModule extends _i479.AppServiceModule {}
