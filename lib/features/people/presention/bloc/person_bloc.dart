import 'dart:async';

import 'package:carpark/features/people/data/models/person_model.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/models/update_person_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_bloc.freezed.dart';
part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(const _Initial()) {
    on<PersonEvent>((event, emit) {});

    on<Get>(onGet);
    on<Update>(onUpdate);
  }

  Future<void> onGet(Get event, Emitter<PersonState> emit) async {
    await sl<ApiService>()
        .getPerson(sl<AppService>().token, event.id)
        .then((person) {
      emit(PersonState.success(person: person));
    }).onError((error, stackTrace) {
      final res = (error as DioException).response;
      if (res != null) {
        final response = ResponseModel.fromJson(res.data);
        emit(PersonState.error(message: response.error));
        return;
      }
      emit(PersonState.error(message: error.toString()));
    });
  }

  Future<void> onUpdate(Update event, Emitter<PersonState> emit) async {
    await sl<ApiService>()
        .updatePerson(
            sl<AppService>().token, event.updatePerson.id, event.updatePerson)
        .then((person) {
      emit(const PersonState.updateSuccess());
      Get(person.id);
    }).onError((error, stackTrace) {
      final res = (error as DioException).response;
      if (res != null) {
        final response = ResponseModel.fromJson(res.data);
        emit(PersonState.error(message: response.error));
        return;
      }
      emit(PersonState.error(message: error.toString()));
    });
  }
}
