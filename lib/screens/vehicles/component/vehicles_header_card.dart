import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';

class VehiclesHeaderCard extends StatelessWidget {
  const VehiclesHeaderCard({super.key});

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
                "ทะเบียน",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "เวลาเข้า",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "เวลาออก",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "สมาชิก",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "โทร.",
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
