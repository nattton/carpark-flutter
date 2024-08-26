import 'dart:async';

import 'package:carpark/models/response_model.dart';
import 'package:carpark/models/vehicle_model.dart';
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
    on<CreateVehicle>(onCreateVehicle);
    on<UpdateVehicle>(onUpdateVehicle);
    on<DeleteVehicle>(onDeleteVehicle);
  }

  FutureOr<void> onGetMember(GetMember event, Emitter<MemberState> emit) async {
    await sl<ApiService>()
        .getMember(sl<AppService>().token, event.id)
        .then((value) {
      emit(MemberState.success(member: value));
    }).onError((error, stackTrace) {
      emit(MemberState.error(message: error.toString()));
    });
  }

  FutureOr<void> onUpdateMember(
      UpdateMember event, Emitter<MemberState> emit) async {
    await sl<ApiService>()
        .updateMember(sl<AppService>().token, event.member.id!, event.member)
        .then((value) {
      emit(MemberState.updateSuccess(member: value));
    }).onError((error, stackTrace) {
      emit(MemberState.error(message: error.toString()));
    });
  }

  FutureOr<void> onCreateVehicle(
      CreateVehicle event, Emitter<MemberState> emit) async {
    await sl<ApiService>()
        .createVehicle(
            sl<AppService>().token, event.vehicle.memberId!, event.vehicle)
        .then((value) {
      emit(MemberState.createVehicleSuccess(member: value));
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(MemberState.error(message: response.error));
      } else {
        emit(MemberState.error(message: error.toString()));
      }
      return;
    });
  }

  FutureOr<void> onUpdateVehicle(
      UpdateVehicle event, Emitter<MemberState> emit) async {
    await sl<ApiService>()
        .updateVehicle(sl<AppService>().token, event.vehicle.id!, event.vehicle)
        .then((value) {
      emit(MemberState.updateVehicleSuccess(member: value));
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(MemberState.error(message: response.error));
      } else {
        emit(MemberState.error(message: error.toString()));
      }
      return;
    });
  }

  FutureOr<void> onDeleteVehicle(
      DeleteVehicle event, Emitter<MemberState> emit) async {
    await sl<ApiService>()
        .deleteVehicle(sl<AppService>().token, event.vehicle.id!)
        .then((value) {
      emit(MemberState.deleteVehicleSuccess(member: value));
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(MemberState.error(message: response.error));
      } else {
        emit(MemberState.error(message: error.toString()));
      }
      return;
    });
  }
}
