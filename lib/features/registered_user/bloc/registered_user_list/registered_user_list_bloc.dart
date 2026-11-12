import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_list_usecase.dart';
import 'package:carpark/shared/services/api/model/registered_user/list_registered_user_param.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'registered_user_list_event.dart';
part 'registered_user_list_state.dart';

@Injectable()
class RegisteredUserListBloc
    extends BlocSignal<RegisteredUserListEvent, RegisteredUserListState> {
  RegisteredUserListBloc(this.usecase)
    : super(initialState: RegisteredUserListInitial()) {
    on<GetRegisteredUserList>(_onGetRegisteredUserList);
    on<SearchRegisteredUser>(_onSearchRegisteredUser);
    on<RegisteredUserCreating>(_onGoToRegisteredUserCreateScreen);
    on<RegisteredUserUpdating>(_onGoToRegisteredUserUpdateScreen);
  }
  final RegisteredUserListUsecase usecase;

  Future<void> _onGetRegisteredUserList(
    GetRegisteredUserList event,
    void Function(RegisteredUserListState) emit,
  ) async {
    emit(RegisteredUserListLoading());
    final result = await usecase.call(
      const ListRegisteredUserParam(search: ''),
    );
    result.fold(
      (failure) {
        emit(RegisteredUserListFailure(failure.message));
      },
      (registeredUsers) {
        emit(RegisteredUserListSuccess(registeredUsers));
      },
    );
  }

  Future<void> _onSearchRegisteredUser(
    SearchRegisteredUser event,
    void Function(RegisteredUserListState) emit,
  ) async {
    emit(RegisteredUserListLoading());
    final result = await usecase.call(
      ListRegisteredUserParam(search: event.searchText),
    );
    result.fold(
      (failure) {
        emit(RegisteredUserListFailure(failure.message));
      },
      (registeredUsers) {
        emit(RegisteredUserListSuccess(registeredUsers));
      },
    );
  }

  Future<void> _onGoToRegisteredUserCreateScreen(
    RegisteredUserCreating event,
    void Function(RegisteredUserListState) emit,
  ) async {
    emit(RegisteredUserListCreating());
  }

  Future<void> _onGoToRegisteredUserUpdateScreen(
    RegisteredUserUpdating event,
    void Function(RegisteredUserListState) emit,
  ) async {
    emit(RegisteredUserListUpdating());
  }
}
