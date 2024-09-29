import 'dart:async';

import 'package:carpark/features/people/data/models/person_model.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_bloc.freezed.dart';
part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(const _Initial()) {
    on<PeopleEvent>((event, emit) {});

    on<Fetch>(onFetch);
  }

  FutureOr<void> onFetch(Fetch event, Emitter<PeopleState> emit) async {
    await sl<ApiService>()
        .listPeople(sl<AppService>().token, event.offset, event.limit,
            event.term, event.type, event.active)
        .then((people) {
      if (event.offset > 0 && people.isEmpty) {
        emit(const PeopleState.endOfList());
        return;
      }
      emit(PeopleState.success(offset: event.offset, people: people));
    }).catchError((error) {});
  }
}
