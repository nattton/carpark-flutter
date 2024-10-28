import 'dart:async';

import 'package:carpark/common/model/delayed_result.dart';
import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:carpark/features/user/data/models/save_user_model.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(const UserState(users: [], loadingResult: DelayedResult.idle())) {
    on<Load>(_onLoad);
    on<Update>(_onUpdate);
    on<ClearError>(_onClearError);
  }

  FutureOr<void> _onLoad(Load event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final users = await sl<ApiService>().getUserList(sl<AppService>().token);
      emit(state.copyWith(users: users));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (e) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(e)));
    }
  }

  FutureOr<void> _onUpdate(Update event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final saveUser = SaveUserModel(
          id: event.id,
          username: event.username,
          password: event.password,
          role: event.role);
      final user = await sl<ApiService>()
          .updateUser(sl<AppService>().token, event.id, saveUser);
      if (user.id > 0) {
        emit(state.copyWith(
            loadingResult:
                DelayedResult.fromValue('Update user: ${user.username}')));
      }
      final users = await sl<ApiService>().getUserList(sl<AppService>().token);
      emit(state.copyWith(users: users));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (e) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(e)));
    }
  }

  FutureOr<void> _onClearError(ClearError event, Emitter<UserState> emit) {
    emit(state.copyWith(loadingResult: const DelayedResult.idle()));
  }
}
