import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_state.dart';
part 'vehicles_cubit.freezed.dart';

class VehiclesCubit extends Cubit<VehiclesState> {
  VehiclesCubit() : super(const VehiclesState());

  void fetch(
      int offset, int limit, String term, String status, String isMember) {
    sl<ApiService>()
        .fetchVehicle(
            sl<AppService>().token, offset, limit, term, status, isMember)
        .then((vehicles) {
      if (offset > 0) {
        vehicles = [...state.vehicles, ...vehicles];
      }
      emit(VehiclesState(vehicles: vehicles, filteredVehicles: vehicles));
    }).catchError((error) {});
  }

  // void filter(String term) async {
  //   if (term.isEmpty) {
  //     emit(state.copyWith(filteredVehicles: state.vehicles));
  //     return;
  //   }
  //   var filtered = state.vehicles.where((vehicle) {
  //     return vehicle.plateNumber.contains(term);
  //   }).toList();
  //   emit(state.copyWith(filteredVehicles: filtered));
  //   return;
  // }
}
