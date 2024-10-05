import 'package:carpark/constants.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:flutter/material.dart';

class CameraListCard extends StatelessWidget {
  const CameraListCard({super.key, required this.camera, required this.onTap});

  final CameraModel camera;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  camera.name,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  camera.ipAddress,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
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
