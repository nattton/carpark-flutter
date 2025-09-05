import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../domain/models/registered_user/registered_user.dart';

class RegisteredUserRowWidget extends StatelessWidget {
  const RegisteredUserRowWidget({
    super.key,
    required this.user,
    required this.onTapViewLogs,
    required this.onEditTap,
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTapViewLogs,
                  child: Text(
                    user.idCard,
                    style: const TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16.0,
                    ),
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
                onTap: onEditTap,
                child: const Icon(Icons.edit, size: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
