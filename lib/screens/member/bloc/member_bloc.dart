import 'dart:async';

import 'package:carpark/models/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_event.dart';
part 'member_state.dart';
part 'member_bloc.freezed.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(const MemberState.initial()) {
    on<MemberEvent>((event, emit) {});
    on<GetMember>(onGetMember);
    on<UpdateMember>(onUpdateMember);
  }

  FutureOr<void> onGetMember(GetMember event, Emitter<MemberState> emit) async {
    emit(const MemberState.loading());
    await sl<ApiService>()
        .getMember(sl<AppService>().token, event.id)
        .then((value) {
      emit(MemberState.success(member: value));
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(MemberState.error(message: response.error));
      } else {
        emit(MemberState.error(message: error.toString()));
      }
    });
  }

  FutureOr<void> onUpdateMember(
      UpdateMember event, Emitter<MemberState> emit) async {
    emit(const MemberState.loading());
    print(event.member.toJson());
    await sl<ApiService>()
        .updateMember(sl<AppService>().token, event.member.id, event.member)
        .then((value) {
      emit(const MemberState.updateSuccess());
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(MemberState.error(message: response.error));
      } else {
        emit(MemberState.error(message: error.toString()));
      }
    });
  }
}
