import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:carpark/constants.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/screens/vehicles/component/vehicles_card.dart';
import 'package:carpark/screens/vehicles/component/vehicles_header_card.dart';
import 'package:carpark/screens/vehicles/cubit/vehicles_cubit.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  final _searchController = TextEditingController();
  int _filterLimit = 100;
  String _filterCondition = "";
  String _filterIsMember = "";

  @override
  void initState() {
    super.initState();
    fetchVehicles(0);
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
                  onChanged: (_) => fetchVehicles(0),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        fetchVehicles(0);
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
                      fetchVehicles(0);
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
              const Text("Condition:"),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterCondition,
                    onChanged: (String? value) {
                      setState(() {
                        _filterCondition = value!;
                      });
                      fetchVehicles(0);
                    },
                    items: kVehicleQueryConditionList
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
              const Text("Member:"),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownButton(
                    value: _filterIsMember,
                    onChanged: (String? value) {
                      setState(() {
                        _filterIsMember = value!;
                      });
                      fetchVehicles(0);
                    },
                    items: kVehicleQueryIsMemberList
                        .map<DropdownMenuItem<String>>((String selectValue) {
                      String value = selectValue == "all" ? "" : selectValue;
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(selectValue),
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
        const VehiclesHeaderCard(),
        BlocBuilder<VehiclesCubit, VehiclesState>(
          builder: (context, state) {
            final filteredVehicles = state.filteredVehicles;
            return Expanded(
              child: ListView.builder(
                itemCount: filteredVehicles.length,
                itemBuilder: (context, index) {
                  if (index == filteredVehicles.length - 1) {
                    fetchVehicles(index);
                  }
                  return VehiclesCard(
                      vehicle: filteredVehicles[index],
                      onTap: () =>
                          onPressedRow(context, filteredVehicles[index]));
                },
              ),
            );
          },
        )
      ],
    );
  }

  Future<void> fetchVehicles(int offset) async {
    context.read<VehiclesCubit>().fetch(offset, _filterLimit,
        _searchController.text, _filterCondition, _filterIsMember);
  }

  void onPressedRow(BuildContext context, VehicleModel vehicle) async {
    // Navigator.of(context)
    //     .pushNamed(MemberScreen.id, arguments: person.id)
    //     .then((value) => {getMember()});
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
