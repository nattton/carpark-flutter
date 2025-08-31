import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/member/member_repository.dart';
import '../../../domain/models/member/member_model.dart';
import '../../../models/response_model.dart';
import '../../../utils/result.dart';

@injectable
class MemberViewModel extends ChangeNotifier {
  final MemberRepository _memberRepository;
  final _log = Logger('MemberViewModel');

  late Command<MemberModel, Result<MemberModel>> createMemberCommand;
  late Command<int, MemberModel> getMemberCommand;
  late Command<MemberModel, Result<ResponseModel>> updateMemberCommand;

  MemberViewModel({required MemberRepository memberRepository})
    : _memberRepository = memberRepository {
    createMemberCommand = Command.createAsync<MemberModel, Result<MemberModel>>(
      initialValue: Result.ok(MemberModel.empty()),
      (params) async {
        final result = await _memberRepository.createMember(params);
        if (result is Error<MemberModel>) {
          _log.warning('Create member failed! ${result.error}');
        }
        return result;
      },
    );

    getMemberCommand = Command.createAsync<int, MemberModel>(
      initialValue: MemberModel.empty(),
      (params) async {
        final result = await _memberRepository.getMember(params);
        switch (result) {
          case Ok<MemberModel>():
            return result.value;
          case Error<MemberModel>():
            _log.warning('Get member failed! ${result.error}');
            throw result.error;
        }
      },
    );

    updateMemberCommand =
        Command.createAsync<MemberModel, Result<ResponseModel>>(
          initialValue: Result.ok(ResponseModel()),
          (params) async {
            final result = await _memberRepository.updateMember(params);
            if (result is Error<ResponseModel>) {
              _log.warning('Update member failed! ${result.error}');
            }
            return result;
          },
        );
  }
}
