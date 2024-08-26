part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default("") String username,
    @Default("") String password,
  }) = _SignInState;
}
