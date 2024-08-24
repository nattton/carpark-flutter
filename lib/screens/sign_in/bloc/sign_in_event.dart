sealed class SignInEvent {
  const SignInEvent();
}

class UsernameEvent extends SignInEvent {
  final String username;
  const UsernameEvent(this.username);
}

class PasswordEvent extends SignInEvent {
  final String password;
  const PasswordEvent(this.password);
}
