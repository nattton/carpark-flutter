import 'package:carpark/constants.dart';
import 'package:flutter/material.dart';

class UserListHeader extends StatelessWidget {
  const UserListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
      color: Colors.blue.shade200,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Username',
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'Role',
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
    ));
  }
}
