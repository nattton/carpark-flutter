import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carpark/models/person_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_state.dart';
part 'people_cubit.freezed.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(const PeopleState());

  void fetch(int offset, int limit, String term, String type, String active) {
    sl<ApiService>()
        .listPeople(sl<AppService>().token, offset, limit, term, type, active)
        .then((people) {
      emit(PeopleState(people: people, filteredPeople: people));
    }).catchError((error) {});
  }

  void filter(String term) async {
    if (term.isEmpty) {
      emit(state.copyWith(filteredPeople: state.people));
      return;
    }
    var filtered = state.people.where((member) {
      return member.idCard.contains(term) ||
          member.thaiName.contains(term) ||
          member.engName.contains(term);
    }).toList();
    emit(state.copyWith(filteredPeople: filtered));
    return;
  }
}
