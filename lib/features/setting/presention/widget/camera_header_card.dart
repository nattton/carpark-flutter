import 'package:carpark/constants.dart';
import 'package:flutter/material.dart';

class CameraHeaderCard extends StatelessWidget {
  const CameraHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
