import 'package:carpark/constants.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:flutter/material.dart';

class RegisteredUserRow extends StatelessWidget {
  const RegisteredUserRow({
    super.key,
    required this.user,
    required this.onTap,
    required this.onEditTap,
  });

  final RegisteredUser user;
  final VoidCallback onTap;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                user.idCard,
                style: const TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                user.thaiName,
                style: const TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                user.telephone,
                style: const TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                user.type,
                style: const TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                user.expiredDate?.toDateString() ?? "",
                style: const TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: const Icon(Icons.visibility, size: 24.0),
            ),
            SizedBox(width: 12.0),
            GestureDetector(
              onTap: onEditTap,
              child: const Icon(Icons.edit, size: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
