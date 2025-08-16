import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/services/api/api_service.dart';
import '../../../../../domain/models/member/member_model.dart';
import '../../../../../injector/injector.dart';
import '../../../../../services/app_service.dart';

part 'member_list_event.dart';
part 'member_list_state.dart';

@Injectable()
class MemberListBloc extends Bloc<MemberListEvent, MemberListState> {
  MemberListBloc() : super(MemberListState()) {
    on<MemberListEvent>((event, emit) {});
    on<LoadMemberList>(_onLoadMemberList);
    on<FilterMemberList>(_onFilterMemberList);
  }

  Future<void> _onLoadMemberList(
    LoadMemberList event,
    Emitter<MemberListState> emit,
  ) async {
    emit(state.copyWith(status: MemberListStatus.loading));
    try {
      final memberList = await getIt<ApiService>().getMemberList(
        getIt<AppService>().token,
      );
      emit(
        state.copyWith(
          status: MemberListStatus.success,
          members: memberList,
          filteredMembers: memberList,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MemberListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFilterMemberList(
    FilterMemberList event,
    Emitter<MemberListState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
    emit(
      state.copyWith(
        filteredMembers: state.members.where((member) {
          return member.name!.contains(event.filter) ||
              member.vehicles != null &&
                  member.vehicles!.any(
                    (vehicle) => vehicle.plateNumber!.contains(event.filter),
                  );
        }).toList(),
      ),
    );
  }
}
