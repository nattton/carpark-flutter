import 'package:carpark/features/member/models/vehicle_model.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/material.dart';

class VehicleListCard extends StatelessWidget {
  const VehicleListCard({
    required this.vehicle,
    required this.onTap,
    super.key,
  });

  final VehicleModel vehicle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  vehicle.id!.toString(),
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.plateNumber!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.resemble!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.plateProvince!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.brand!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.color!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  vehicle.telephone!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.edit),
            ],
          ),
        ),
      ),
    );
  }
}
