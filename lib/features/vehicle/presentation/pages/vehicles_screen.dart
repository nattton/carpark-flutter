import 'package:carpark/constants.dart';
import 'package:carpark/features/vehicle/presentation/bloc/vehicles_bloc.dart';
import 'package:carpark/features/vehicle/presentation/widget/vehicles_card.dart';
import 'package:carpark/features/vehicle/presentation/widget/vehicles_header_card.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  List<VehicleModel> _vehicles = [];
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
        BlocBuilder<VehiclesBloc, VehiclesState>(
          builder: (context, state) {
            return state.when(
                initial: () => Container(),
                success: (offset, vehicles) {
                  if (offset == 0) {
                    _vehicles = vehicles;
                  } else {
                    _vehicles = [..._vehicles, ...vehicles];
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _vehicles.length,
                      itemBuilder: (context, index) {
                        if (index == _vehicles.length - 1) {
                          fetchVehicles(index + 1);
                        }
                        return VehiclesCard(
                            vehicle: _vehicles[index],
                            onTap: () =>
                                onPressedRow(context, _vehicles[index]));
                      },
                    ),
                  );
                },
                endOfList: () {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _vehicles.length,
                      itemBuilder: (context, index) {
                        return VehiclesCard(
                            vehicle: _vehicles[index],
                            onTap: () =>
                                onPressedRow(context, _vehicles[index]));
                      },
                    ),
                  );
                });
          },
        )
      ],
    );
  }

  Future<void> fetchVehicles(int offset) async {
    context.read<VehiclesBloc>().add(VehiclesEvent.fetch(offset, _filterLimit,
        _searchController.text, _filterCondition, _filterIsMember));
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
