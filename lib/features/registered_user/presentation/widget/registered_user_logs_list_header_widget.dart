import 'package:carpark/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserLogListHeaderWidget extends StatelessWidget {
  const RegisteredUserLogListHeaderWidget({super.key});

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
                "ID",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Check In Time",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Check Out Time",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Duration",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
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
