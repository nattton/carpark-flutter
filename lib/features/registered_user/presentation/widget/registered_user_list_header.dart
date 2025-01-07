import 'package:carpark/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserListHeader extends StatelessWidget {
  const RegisteredUserListHeader({super.key});

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
                "ID Card",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Thai Name",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Telephone",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Type",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Expired Date",
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
