part of 'vehicle_bloc.dart';

@freezed
class VehicleState with _$VehicleState {
  const factory VehicleState.initial() = _Initial;
  const factory VehicleState.error({
    required String message,
  }) = ErrorVehicle;
  const factory VehicleState.loading() = LoadingVehicle;
  const factory VehicleState.createVehicle() = CreateVehicleSuccess;
  const factory VehicleState.updateVehicle() = UpdateVehicleSuccess;
  const factory VehicleState.deleteVehicle() = DeleteVehicleSuccess;
}
