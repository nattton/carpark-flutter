import 'package:carpark/data/repositories/member/member_repository.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'member_list_event.dart';
part 'member_list_state.dart';

@Injectable()
class MemberListBloc extends Bloc<MemberListEvent, MemberListState> {
  MemberListBloc({required MemberRepository memberRepository})
    : _memberRepository = memberRepository,
      super(const MemberListState()) {
    on<MemberListEvent>((event, emit) {});
    on<LoadMemberList>(_onLoadMemberList);
    on<FilterMemberList>(_onFilterMemberList);
  }
  final MemberRepository _memberRepository;

  Future<void> _onLoadMemberList(
    LoadMemberList event,
    Emitter<MemberListState> emit,
  ) async {
    emit(state.copyWith(status: MemberListStatus.loading));
    final result = await _memberRepository.getMemberList();
    switch (result) {
      case Ok<List<MemberModel>>():
        emit(
          state.copyWith(
            status: MemberListStatus.success,
            members: result.value,
            filteredMembers: result.value,
          ),
        );
      case Error<List<MemberModel>>():
        emit(
          state.copyWith(
            status: MemberListStatus.failure,
            errorMessage: result.error.toString(),
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
