import 'package:carpark/screens/sign_in/bloc/sign_in_event.dart';
import 'package:carpark/screens/sign_in/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<UsernameEvent>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<PasswordEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
  }
}
