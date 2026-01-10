import 'package:carpark/features/member/view_models/member_list_viewmodel.dart';
import 'package:carpark/features/member/widgets/member_list_card.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class MemberListView extends WatchingWidget {
  const MemberListView({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredMembers = watchValue(
      (MemberListViewModel viewModel) => viewModel.filteredMemberListCommand,
    );
    return ListView.builder(
      itemCount: filteredMembers.length,
      itemBuilder: (context, index) {
        return MemberListCard(
          member: filteredMembers[index],
          onTap: () {
            getIt<MemberListViewModel>().goMemberScreenCommand(
              filteredMembers[index].id,
            );
          },
        );
      },
    );
  }
}
