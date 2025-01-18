part of 'registered_user_update_bloc.dart';

enum RegisteredUserUpdateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  updating,
  updateSuccess,
  updateFailure,
  failure,
  selectingExpiredDate,
  selectExpiredDateSuccess,
  selectType,
}

final class RegisteredUserUpdateState extends Equatable {
  final RegisteredUserUpdateStatus status;
  final String message;
  final RegisteredUser registeredUser;
  const RegisteredUserUpdateState(
      {this.status = RegisteredUserUpdateStatus.initial,
      this.message = "",
      this.registeredUser = const RegisteredUser()});

  @override
  List<Object> get props => [
        status,
        message,
        registeredUser,
      ];

  RegisteredUserUpdateState copyWith({
    RegisteredUserUpdateStatus? status,
    String? message,
    RegisteredUser? registeredUser,
  }) {
    return RegisteredUserUpdateState(
      status: status ?? this.status,
      message: message ?? this.message,
      registeredUser: registeredUser ?? this.registeredUser,
    );
  }
}
