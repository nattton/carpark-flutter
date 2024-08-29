import 'package:carpark/components/member_header_card.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/screens/member/member_screen.dart';
import 'package:carpark/screens/member_list/cubit/member_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMember();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            controller: _searchController,
            autofocus: false,
            autocorrect: false,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _searchController.clear();
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
        BlocBuilder<MemberListCubit, MemberListState>(
          builder: (context, state) {
            final filteredMemberList = state.filteredMembers;
            return Expanded(
              child: ListView.builder(
                itemCount: filteredMemberList.length,
                itemBuilder: (context, index) {
                  return MemberListCard(
                      member: filteredMemberList[index],
                      onTap: () =>
                          onPressedRow(context, filteredMemberList[index]));
                },
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> getMember() async {
    context.read<MemberListCubit>().listMembers();
  }

  void onPressedRow(BuildContext context, MemberModel member) async {
    Navigator.of(context)
        .pushNamed(MemberScreen.id, arguments: member.id)
        .then((value) => {getMember()});
  }

  void alertError(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert Message'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  onSearchTextChanged(String term) async {
    context.read<MemberListCubit>().filter(term);
  }
}
