import 'package:carpark/shared/config/constants.dart';
import 'package:carpark/shared/services/api/model/login_response/user_model.dart';
import 'package:flutter/material.dart';

class UserListCard extends StatelessWidget {
  const UserListCard({required this.user, required this.onTap, super.key});

  final UserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: user.id == 0
          ? Card(
              color: Colors.blue.shade200,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.role,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            )
          : Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.role,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
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
