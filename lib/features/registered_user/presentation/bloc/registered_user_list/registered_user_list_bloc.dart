import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_list_mapper.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registered_user_list_event.dart';
part 'registered_user_list_state.dart';

class RegisteredUserListBloc
    extends Bloc<RegisteredUserListEvent, RegisteredUserListState> {
  final RegisteredUserListUsecase usecase;

  RegisteredUserListBloc(this.usecase) : super(RegisteredUserListInitial()) {
    on<GetRegisteredUserList>(_onGetRegisteredUserList);
  }

  Future<void> _onGetRegisteredUserList(GetRegisteredUserList event,
      Emitter<RegisteredUserListState> emit) async {
    emit(RegisteredUserListLoading());
    final result = await usecase.call(NoParams());
    result.fold((failure) {
      emit(RegisteredUserListFailure(failure.message));
    }, (response) {
      final registeredUsers = RegisteredUserListMapper.responseMapper(response);
      emit(RegisteredUserListSuccess(registeredUsers));
    });
  }
}
