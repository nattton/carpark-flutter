import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<UsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
  }
}
