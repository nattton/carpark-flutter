import 'dart:async';

import 'package:carpark/injection_container.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_bloc.freezed.dart';
part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  VehiclesBloc() : super(const _Initial()) {
    on<VehiclesEvent>((event, emit) {});
    on<Fetch>(onFetch);
  }

  FutureOr<void> onFetch(Fetch event, Emitter<VehiclesState> emit) async {
    await sl<ApiService>()
        .fetchVehicle(sl<AppService>().token, event.offset, event.limit,
            event.term, event.status, event.isMember)
        .then((vehicles) {
      if (event.offset > 0 && vehicles.isEmpty) {
        emit(const VehiclesState.endOfList());
        return;
      }
      emit(VehiclesState.success(offset: event.offset, vehicles: vehicles));
    }).catchError((error) {});
  }
}
