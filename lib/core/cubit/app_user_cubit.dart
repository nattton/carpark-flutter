import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_cubit.freezed.dart';
part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserState.initial());

  void updateUser(UserModel? user) {
    if (user == null) {
      emit(const AppUserState.initial());
    } else {
      emit(AppUserState.loggedIn(user));
    }
  }
}
