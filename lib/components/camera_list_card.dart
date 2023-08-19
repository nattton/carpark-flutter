import 'package:carpark/models/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';

class CameraListCard extends StatelessWidget {
  const CameraListCard({super.key, required this.camera, required this.onTap});

  final CameraModel camera;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: camera.id == 0
          ? Card(
              color: Colors.blue.shade200,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontFamily: kDefaultFont,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'IP Address',
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.0),
                  ],
                ),
              ),
            )
          : Card(
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
