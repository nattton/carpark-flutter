class SignInState {
  final String username;
  final String password;

  SignInState({this.username = "", this.password = ""});

  SignInState copyWith({String? username, String? password}) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
