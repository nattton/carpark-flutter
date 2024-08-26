part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.loginRequested({
    required String username,
    required String password,
  }) = LoginRequested;
  const factory SignInEvent.usernameChanged(String username) = UsernameChanged;
  const factory SignInEvent.passwordChanged(String password) = PasswordChanged;
}
