import 'package:carpark/features/member/presentation/bloc/member_list/member_list_bloc.dart';
import 'package:carpark/features/member/presentation/page/member_screen.dart';
import 'package:carpark/features/member/presentation/widget/member_header_card.dart';
import 'package:carpark/features/member/presentation/widget/member_list_card.dart';
import 'package:carpark/models/member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  late MemberListBloc _memberListBloc;
  final _filterController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _memberListBloc = context.read<MemberListBloc>();
    _memberListBloc.add(LoadMemberList());
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _filterController,
            autofocus: false,
            autocorrect: false,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _filterController.clear();
                  onSearchTextChanged('');
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        const MemberHeaderCard(),
        BlocBuilder<MemberListBloc, MemberListState>(
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.filteredMembers.length,
                itemBuilder: (context, index) {
                  return MemberListCard(
                      member: state.filteredMembers[index],
                      onTap: () =>
                          onPressedRow(context, state.filteredMembers[index]));
                },
              ),
            );
          },
        )
      ],
    );
  }

  void onPressedRow(BuildContext context, MemberModel member) async {
    Navigator.of(context)
        .pushNamed(MemberScreen.id, arguments: member.id)
        .then((value) => {
              _memberListBloc.add(LoadMemberList()),
            });
  }

  void onSearchTextChanged(String text) async {
    _memberListBloc.add(FilterMemberList(text));
  }
}
