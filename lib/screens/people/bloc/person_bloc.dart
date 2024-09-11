import 'dart:async';

import 'package:carpark/injection_container.dart';
import 'package:carpark/models/person_model.dart';
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

    on<GetPerson>(onGetPerson);

    on<UpdatePerson>(onUpdatePerson);
  }

  Future<void> onGetPerson(GetPerson event, Emitter<PersonState> emit) async {
    await sl<ApiService>()
        .getPerson(sl<AppService>().token, event.id)
        .then((person) {
      emit(PersonState.success(person: person));
    }).catchError((error) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(PersonState.error(message: response.error));
      } else {
        emit(PersonState.error(message: error.toString()));
      }
    });
  }

  Future<void> onUpdatePerson(
      UpdatePerson event, Emitter<PersonState> emit) async {
    await sl<ApiService>()
        .updatePerson(
            sl<AppService>().token, event.updatePerson.id, event.updatePerson)
        .then((person) {
      emit(PersonState.success(person: person));
    }).catchError((error) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(PersonState.error(message: response.error));
      } else {
        emit(PersonState.error(message: error.toString()));
      }
    });
  }
}
