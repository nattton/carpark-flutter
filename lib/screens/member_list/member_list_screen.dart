import 'package:carpark/components/member_header_card.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/constants.dart';
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
  final List<String> _listStatus = ["", ...kStatusList];
  final List<String> _listMemberType = ["", ...kMemberTypeList];
  String _filterStatus = "";
  String _filterMemberType = "";

  @override
  void initState() {
    super.initState();
    fetchMember();
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  autocorrect: false,
                  onChanged: (_) => filterChanged(),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        filterChanged();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text("Type:"),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterMemberType,
                    onChanged: (String? value) {
                      setState(() {
                        _filterMemberType = value!;
                      });
                      filterChanged();
                    },
                    items: _listMemberType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text("Status:"),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterStatus,
                    onChanged: (String? value) {
                      setState(() {
                        _filterStatus = value!;
                      });
                      filterChanged();
                    },
                    items: _listStatus
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              )
            ],
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

  Future<void> fetchMember() async {
    context.read<MemberListCubit>().fetchMember();
  }

  void onPressedRow(BuildContext context, MemberModel member) async {
    Navigator.of(context)
        .pushNamed(MemberScreen.id, arguments: member.id)
        .then((value) => {fetchMember()});
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

  filterChanged() async {
    context
        .read<MemberListCubit>()
        .filter(_searchController.text, _filterMemberType, _filterStatus);
  }
}
