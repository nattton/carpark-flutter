import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_list_state.dart';
part 'member_list_cubit.freezed.dart';

class MemberListCubit extends Cubit<MemberListState> {
  MemberListCubit() : super(const MemberListState());
  void fetchMember() async {
    sl<ApiService>().fetchMember(sl<AppService>().token).then((members) {
      emit(MemberListState(members: members, filteredMembers: members));
    }).catchError((error) {});
  }

  void filter(String term, String type, String status) async {
    if (term.isEmpty && type == "" && status == "") {
      emit(state.copyWith(filteredMembers: state.members));
      return;
    }

    var filtered = state.members.where((member) {
      return member.name.contains(term) ||
          member.plateVehicles.contains(term) ||
          member.telephone.contains(term);
    }).toList();

    if (type != "") {
      filtered = state.members.where((member) {
        return member.type == type;
      }).toList();
    }

    if (status != "") {
      filtered = state.members.where((member) {
        return member.status == status;
      }).toList();
    }
    emit(state.copyWith(filteredMembers: filtered));
    return;
  }
}
