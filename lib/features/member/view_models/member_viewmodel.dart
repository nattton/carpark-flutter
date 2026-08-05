import 'package:carpark/features/member/models/member_model.dart';
import 'package:carpark/features/member/models/vehicle_model.dart';
import 'package:carpark/shared/models/response_model.dart';
import 'package:carpark/shared/repositories/member/member_repository.dart';
import 'package:carpark/shared/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';

class MemberViewModel {
  MemberViewModel({required this._memberRepository});
  final MemberRepository _memberRepository;
  final _log = Logger('MemberViewModel');

  final Command<int, int> memberIdCommand = Command.createSync<int, int>(
    initialValue: 0,
    (newParam) => newParam,
  );

  final Command<String, String> nameCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (newParam) => newParam,
      );

  final Command<String, String> telephoneCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (newParam) => newParam,
      );

  final Command<String, String> typeCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (newParam) => newParam,
      );

  final Command<String, String> statusCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (newParam) => newParam,
      );

  final Command<List<VehicleModel>, List<VehicleModel>> vehiclesCommand =
      Command.createSync<List<VehicleModel>, List<VehicleModel>>(
        initialValue: [],
        (newParam) => newParam,
      );

  final vehicleEditing = ValueNotifier<VehicleModel?>(null);

  late final Command<void, MemberModel> createMemberCommand =
      Command.createAsyncNoParam<MemberModel>(
        initialValue: MemberModel.empty(),
        () async {
          final result = await _memberRepository.createMember(
            MemberModel(
              id: 0,
              name: nameCommand.value,
              telephone: telephoneCommand.value,
              type: typeCommand.value,
              status: statusCommand.value,
            ),
          );
          switch (result) {
            case Ok<MemberModel>():
              return result.value;
            case Error<MemberModel>():
              _log.warning('Create member failed! ${result.error}');
              throw result.error;
          }
        },
      );

  late final Command<int, void> getMemberCommand =
      Command.createAsyncNoResult<int>(
        (params) async {
          if (params == 0) {
            return;
          }
          final result = await _memberRepository.getMember(params);
          switch (result) {
            case Ok<MemberModel>():
              memberIdCommand(result.value.id);
              nameCommand(result.value.name);
              telephoneCommand(result.value.telephone);
              typeCommand(result.value.type);
              statusCommand(result.value.status);
              vehiclesCommand(result.value.vehicles);
            case Error<MemberModel>():
              _log.warning('Get member failed! ${result.error}');
              throw result.error;
          }
        },
      );

  late final Command<void, void> reloadMemberCommand =
      Command.createAsyncNoParamNoResult(
        () async {
          getMemberCommand.run(memberIdCommand.value);
        },
      );

  late final Command<void, Result<ResponseModel>> updateMemberCommand =
      Command.createAsyncNoParam<Result<ResponseModel>>(
        initialValue: const Result.ok(ResponseModel()),
        () async {
          final result = await _memberRepository.updateMember(
            MemberModel(
              id: memberIdCommand.value,
              name: nameCommand.value,
              telephone: telephoneCommand.value,
              type: typeCommand.value,
              status: statusCommand.value,
            ),
          );
          if (result is Error<ResponseModel>) {
            _log.warning('Update member failed! ${result.error}');
          }
          return result;
        },
      );

  late final Command<void, void> newVehicleCommand =
      Command.createSyncNoParamNoResult(() {
        vehicleEditing.value = VehicleModel(
          memberId: memberIdCommand.value,
        );
      });

  late final Command<VehicleModel, void> editVehicleCommand =
      Command.createSyncNoResult<VehicleModel>((params) {
        vehicleEditing.value = params.copyWith(
          memberId: memberIdCommand.value,
        );
      });

  late final Command<void, Result<ResponseModel>> createVehicleCommand =
      Command.createAsyncNoParam<Result<ResponseModel>>(
        initialValue: const Result.ok(ResponseModel()),
        () async {
          final vehicle = vehicleEditing.value;
          if (vehicle == null) {
            return Result.error(Exception('vehicle is empty!'));
          }

          final result = await _memberRepository.createVehicle(
            vehicle,
          );
          if (result is Error<ResponseModel>) {
            _log.warning('Create vehicle failed! ${result.error}');
          } else {
            vehicleEditing.value = null;
          }
          return result;
        },
      )..pipeToCommand(reloadMemberCommand);

  late final Command<void, Result<ResponseModel>> updateVehicleCommand =
      Command.createAsyncNoParam<Result<ResponseModel>>(
        initialValue: const Result.ok(ResponseModel()),
        () async {
          final vehicle = vehicleEditing.value;
          if (vehicle == null) {
            return Result.error(Exception('vehicle is empty!'));
          }

          final result = await _memberRepository.updateVehicle(vehicle);
          if (result is Error<ResponseModel>) {
            _log.warning('Update vehicle failed! ${result.error}');
          } else {
            vehicleEditing.value = null;
          }
          return result;
        },
      )..pipeToCommand(reloadMemberCommand);

  late final Command<int, Result<void>> deleteVehicleCommand =
      Command.createAsync(
        initialValue: const Result.ok(null),
        (
          vehicleId,
        ) async {
          final result = await _memberRepository.deleteVehicle(vehicleId);
          if (result is Error<ResponseModel>) {
            _log.warning('Delete vehicle failed! ${result.error}');
          }
          return result;
        },
      )..pipeToCommand(reloadMemberCommand);
}
