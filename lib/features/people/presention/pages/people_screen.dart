import 'package:carpark/constants.dart';
import 'package:carpark/features/people/data/models/person_model.dart';
import 'package:carpark/features/people/presention/bloc/people_bloc.dart';
import 'package:carpark/features/people/presention/pages/person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/people_card.dart';
import '../widget/people_header_card.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  List<String> listPeopleType = ['', ...kPeopleQueryTypeList];
  List<PersonModel> _people = [];
  final _searchController = TextEditingController();
  int _filterLimit = 100;
  String _filterType = '';
  String _filterActive = '';

  @override
  void initState() {
    super.initState();
    fetchPeople(0);
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
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  autocorrect: false,
                  onChanged: (_) => fetchPeople(0),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        fetchPeople(0);
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
                width: 10,
              ),
              const Text("Limit"),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownButton<int>(
                    hint: const Text("Limit"),
                    value: _filterLimit,
                    onChanged: (value) {
                      setState(() {
                        _filterLimit = value!;
                      });
                      fetchPeople(0);
                    },
                    items: kLimitList
                        .map<DropdownMenuItem<int>>((int selectValue) {
                      String text = selectValue == 0
                          ? "No Limit"
                          : selectValue.toString();
                      return DropdownMenuItem<int>(
                        value: selectValue,
                        child: Text(text),
                      );
                    }).toList()),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Active:"),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterActive,
                    onChanged: (String? value) {
                      setState(() {
                        _filterActive = value!;
                      });
                      fetchPeople(0);
                    },
                    items: kPeopleQueryActiveList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Type:"),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterType,
                    onChanged: (String? value) {
                      setState(() {
                        _filterType = value!;
                      });
                      fetchPeople(0);
                    },
                    items: listPeopleType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
        const PeopleHeaderCard(),
        BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
            return state.when(
                initial: () => Container(),
                success: (offset, people) {
                  if (offset == 0) {
                    _people = people;
                  } else {
                    _people = [..._people, ...people];
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: _people.length,
                      itemBuilder: (context, index) {
                        if (index == _people.length - 1) {
                          fetchPeople(index + 1);
                        }
                        return PeopleCard(
                            person: _people[index],
                            onTap: () => onPressedRow(context, _people[index]));
                      },
                    ),
                  );
                },
                endOfList: () {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _people.length,
                      itemBuilder: (context, index) {
                        return PeopleCard(
                            person: _people[index],
                            onTap: () => onPressedRow(context, _people[index]));
                      },
                    ),
                  );
                });
          },
        )
      ],
    );
  }

  Future<void> fetchPeople(int offset) async {
    context.read<PeopleBloc>().add(Fetch(offset, _filterLimit,
        _searchController.text, _filterType, _filterActive));
  }

  void onPressedRow(BuildContext context, PersonModel person) async {
    Navigator.of(context)
        .pushNamed(PersonScreen.id, arguments: person.id)
        .then((value) => {fetchPeople(0)});
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
}
