import 'package:carpark/config/constants.dart';
import 'package:carpark/domain/models/registered_user/registered_user.dart';
import 'package:flutter/material.dart';

class RegisteredUserRowWidget extends StatelessWidget {
  const RegisteredUserRowWidget({
    required this.user, required this.onTapViewLogs, required this.onEditTap, super.key,
  });

  final RegisteredUser user;
  final VoidCallback onTapViewLogs;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapViewLogs,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTapViewLogs,
                  child: Text(
                    user.idCard,
                    style: const TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.thaiName,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.telephone,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.type,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.expiredDate?.toDateString() ?? '',
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: const Icon(Icons.edit, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
