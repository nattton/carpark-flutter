part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<UserModel> users;
  final DelayedResult<void> loadingResult;

  const UserState({
    required this.users,
    required this.loadingResult,
  });

  UserState copyWith({
    List<UserModel>? users,
    DelayedResult<void>? loadingResult,
  }) {
    return UserState(
      users: users ?? this.users,
      loadingResult: loadingResult ?? this.loadingResult,
    );
  }

  @override
  List<Object?> get props => [users, loadingResult];
}
