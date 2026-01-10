import 'package:carpark/features/user/widgets/user_list_card.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/models/save_user_model.dart';
import 'package:carpark/shared/services/api/api_service.dart';
import 'package:carpark/shared/services/api/model/login_response/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList = [];
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return UserListCard(
            user: const UserModel(id: 0, name: 'Name', role: 'Role'),
            onTap: () {},
          );
        }
        return UserListCard(
          user: userList[index - 1],
          onTap: () => onPressedRow(context, userList[index - 1]),
        );
      },
    );
  }

  Future<void> getUser() async {
    getIt<ApiService>()
        .getUserList()
        .then((value) {
          setState(() {
            userList = value;
          });
        })
        .catchError((error) {});
  }

  void saveUser(UserModel user) {
    final saveUser = SaveUserModel(
      id: user.id,
      username: _usernameController.text,
      password: _passwordController.text,
      role: user.role,
    );
    getIt<ApiService>()
        .updateUser(saveUser.id, saveUser)
        .then((value) {
          GoRouter.of(context).pop();
          getUser();
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }

  void onPressedRow(BuildContext context, UserModel user) {
    _usernameController.text = user.name;
    _passwordController.text = '';

    Alert(
      context: context,
      title: 'Change Password',
      content: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            autocorrect: false,
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'User',
              suffixIcon: const Icon(Icons.account_circle),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'New Password',
              suffixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            saveUser(user);
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void alertError(String msg) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert Message'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
