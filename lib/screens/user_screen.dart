import 'package:carpark/components/user_list_card.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/save_user_model.dart';
import 'package:carpark/models/user_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
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
            user: UserModel(id: 0, name: "Name", role: "Role"),
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
        .getUserList(getIt<AppService>().token)
        .then((value) {
          setState(() {
            userList = value;
          });
        })
        .catchError((error) {});
  }

  void saveUser(UserModel user) {
    var saveUser = SaveUserModel(
      id: user.id,
      username: _usernameController.text,
      password: _passwordController.text,
      role: user.role,
    );
    getIt<ApiService>()
        .updateUser(getIt<AppService>().token, saveUser.id, saveUser)
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
      title: "Change Password",
      content: Column(
        children: [
          const SizedBox(height: 8.0),
          TextField(
            controller: _usernameController,
            autofocus: false,
            autocorrect: false,
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'User',
              suffixIcon: const Icon(Icons.account_circle),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: _passwordController,
            autofocus: false,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'New Password',
              suffixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
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
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void alertError(String msg) {
    showDialog(
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
