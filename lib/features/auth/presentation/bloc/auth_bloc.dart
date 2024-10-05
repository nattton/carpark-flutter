import 'dart:async';

import 'package:carpark/core/cubit/app_user_cubit.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/auth/domain/usecases/user_login.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin userLogin;
  final AppUserCubit appUserCubit;
  AuthBloc({
    required this.userLogin,
    required this.appUserCubit,
  }) : super(const AuthState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<IsUserLoggedIn>(_onIsUserLoggedIn);
  }

  FutureOr<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    final String username = event.username;
    final String password = event.password;
    if (username.isEmpty || password.isEmpty) {
      emit(
          AuthState.error(error: Failure("Please fill username and password")));
      return;
    }

    final res = await userLogin
        .call(UserLoginParams(username: username, password: password));

    res.fold((error) {
      emit(
        AuthState.error(error: error),
      );
    }, (userLogin) {
      sl<AppService>().saveLogin(userLogin);
      emit(const AuthState.success());
    });
  }

  FutureOr<void> _onIsUserLoggedIn(
      IsUserLoggedIn event, Emitter<AuthState> emit) async {
    var app = sl<AppService>();
    await Future.delayed(const Duration(seconds: 1));
    if (!app.isLogIn()) {
      app.logout().then((value) {
        // emit(SignInState.error(message: error.toString()));
      });
    } else {
      emit(const AuthState.success());
    }
  }
}
