import 'dart:async';

import 'package:carpark/injection_container.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carpark/models/vehicle_model.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';
part 'vehicle_bloc.freezed.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(const VehicleState.initial()) {
    on<VehicleEvent>((event, emit) {});
    on<CreateVehicle>(onCreateVehicle);
    on<UpdateVehicle>(onUpdateVehicle);
    on<DeleteVehicle>(onDeleteVehicle);
  }

  FutureOr<void> onCreateVehicle(event, Emitter<VehicleState> emit) async {
    emit(const VehicleState.loading());
    await sl<ApiService>()
        .createVehicle(
            sl<AppService>().token, event.vehicle.memberId!, event.vehicle)
        .then((value) {
      emit(const VehicleState.createVehicle());
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(VehicleState.error(message: response.error));
      } else {
        emit(VehicleState.error(message: error.toString()));
      }
    });
  }

  FutureOr<void> onUpdateVehicle(
      UpdateVehicle event, Emitter<VehicleState> emit) async {
    emit(const VehicleState.loading());
    await sl<ApiService>()
        .updateVehicle(sl<AppService>().token, event.vehicle.id, event.vehicle)
        .then((value) {
      emit(const VehicleState.updateVehicle());
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(VehicleState.error(message: response.error));
      } else {
        emit(VehicleState.error(message: error.toString()));
      }
    });
  }

  FutureOr<void> onDeleteVehicle(
      DeleteVehicle event, Emitter<VehicleState> emit) async {
    emit(const VehicleState.loading());
    await sl<ApiService>()
        .deleteVehicle(sl<AppService>().token, event.vehicle.id)
        .then((value) {
      emit(const VehicleState.deleteVehicle());
    }).onError((error, stackTrace) {
      if (error.runtimeType == DioException) {
        final res = (error as DioException).response;
        final response = ResponseModel.fromJson(res!.data);
        emit(VehicleState.error(message: response.error));
      } else {
        emit(VehicleState.error(message: error.toString()));
      }
    });
  }
}
