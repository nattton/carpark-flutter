import 'package:carpark/models/member.dart';
import 'package:flutter/material.dart';
import 'package:carpark/components/vehicle_list_card.dart';
import 'package:carpark/services/app_service.dart';

class VehicleScreen extends StatefulWidget {
  static const String id = "vehicle_screen";

  const VehicleScreen({super.key, required this.member});

  final Member member;
  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  late AppService appService;

  Member get member => widget.member;

  @override
  void initState() {
    super.initState();
    AppService.getInstance().then((value) {
      appService = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: member.vehicles!.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return VehicleListCard(
              vehicle: Vehicle(id: 0),
              onTap: () {},
            );
          }
          return VehicleListCard(
              vehicle: member.vehicles![index - 1],
              onTap: () => onPressedRow(context, member.vehicles![index - 1]));
        },
      ),
    );
  }

  void onPressedRow(BuildContext context, Vehicle vehicle) {}

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
