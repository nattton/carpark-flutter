part of 'vehicles_cubit.dart';

@freezed
class VehiclesState with _$VehiclesState {
  const factory VehiclesState({
    @Default([]) List<VehicleModel> vehicles,
    @Default([]) List<VehicleModel> filteredVehicles,
  }) = _VehiclesState;
}
