import 'package:carpark/data/repositories/member/member_repository.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/domain/models/member/vehicle_model.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class MemberViewModel {
  MemberViewModel({required MemberRepository memberRepository})
    : _memberRepository = memberRepository {
    createMemberCommand = Command.createAsync<MemberModel, MemberModel>(
      initialValue: MemberModel.empty(),
      (params) async {
        final result = await _memberRepository.createMember(params);
        switch (result) {
          case Ok<MemberModel>():
            return result.value;
          case Error<MemberModel>():
            _log.warning('Create member failed! ${result.error}');
            throw result.error;
        }
      },
    );

    getMemberCommand = Command.createAsyncNoResult<int>(
      (params) async {
        if (params == 0) {
          member.value = MemberModel.empty();
          return;
        }
        final result = await _memberRepository.getMember(params);
        switch (result) {
          case Ok<MemberModel>():
            member.value = result.value;
          case Error<MemberModel>():
            _log.warning('Get member failed! ${result.error}');
            throw result.error;
        }
      },
    );

    reloadMemberCommand = Command.createAsyncNoParamNoResult(
      () async {
        getMemberCommand.run(member.value.id);
      },
    );

    updateMemberCommand =
        Command.createAsync<MemberModel, Result<ResponseModel>>(
          initialValue: const Result.ok(ResponseModel()),
          (params) async {
            final result = await _memberRepository.updateMember(params);
            if (result is Error<ResponseModel>) {
              _log.warning('Update member failed! ${result.error}');
            }
            return result;
          },
        );

    newVehicleCommand = Command.createSyncNoParamNoResult(() {
      vehicleEditing.value = VehicleModel(memberId: member.value.id);
    });

    editVehicleCommand = Command.createSyncNoResult<VehicleModel>((params) {
      vehicleEditing.value = params.copyWith(memberId: member.value.id);
    });

    createVehicleCommand = Command.createAsyncNoParam<Result<ResponseModel>>(
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

    updateVehicleCommand = Command.createAsyncNoParam<Result<ResponseModel>>(
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

    deleteVehicleCommand = Command.createAsync(
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
  final MemberRepository _memberRepository;
  final _log = Logger('MemberViewModel');

  final member = ValueNotifier<MemberModel>(
    MemberModel.empty(),
  );
  final vehicleEditing = ValueNotifier<VehicleModel?>(null);
  late Command<MemberModel, MemberModel> createMemberCommand;
  late Command<int, void> getMemberCommand;
  late Command<void, void> reloadMemberCommand;
  late Command<MemberModel, Result<ResponseModel>> updateMemberCommand;
  late Command<void, void> newVehicleCommand;
  late Command<VehicleModel, void> editVehicleCommand;
  late Command<void, Result<ResponseModel>> createVehicleCommand;
  late Command<void, Result<ResponseModel>> updateVehicleCommand;
  late Command<int, Result<void>> deleteVehicleCommand;
}
