import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/registered_user.dart';
import '../../../domain/models/list_registered_user_param.dart';
import '../../../domain/usecases/registered_user_list_usecase.dart';

part 'registered_user_list_event.dart';
part 'registered_user_list_state.dart';

@Injectable()
class RegisteredUserListBloc
    extends Bloc<RegisteredUserListEvent, RegisteredUserListState> {
  final RegisteredUserListUsecase usecase;

  RegisteredUserListBloc(this.usecase) : super(RegisteredUserListInitial()) {
    on<GetRegisteredUserList>(_onGetRegisteredUserList);
    on<SearchRegisteredUser>(_onSearchRegisteredUser);
    on<RegisteredUserCreating>(_onGoToRegisteredUserCreateScreen);
    on<RegisteredUserUpdating>(_onGoToRegisteredUserUpdateScreen);
  }

  Future<void> _onGetRegisteredUserList(
    GetRegisteredUserList event,
    Emitter<RegisteredUserListState> emit,
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
    Emitter<RegisteredUserListState> emit,
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
    Emitter<RegisteredUserListState> emit,
  ) async {
    emit(RegisteredUserListCreating());
  }

  Future<void> _onGoToRegisteredUserUpdateScreen(
    RegisteredUserUpdating event,
    Emitter<RegisteredUserListState> emit,
  ) async {
    emit(RegisteredUserListUpdating());
  }
}
