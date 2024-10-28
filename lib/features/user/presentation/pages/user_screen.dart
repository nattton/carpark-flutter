import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:carpark/features/user/data/models/save_user_model.dart';
import 'package:carpark/features/user/presentation/bloc/user_bloc.dart';
import 'package:carpark/features/user/presentation/widget/user_list_card.dart';
import 'package:carpark/features/user/presentation/widget/user_list_header.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserBloc _userBloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>()..add(const Load());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.loadingResult.error != null) {
          _userBloc.add(const ClearError());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to perform this action'),
            ),
          );
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.users.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const UserListHeader();
            }
            return UserListCard(
                user: state.users[index - 1],
                onTap: () => onPressedRow(context, state.users[index - 1]));
          },
        );
      },
    );
  }

  void saveUser(UserModel user) {
    var saveUser = SaveUserModel(
        id: user.id,
        username: _usernameController.text,
        password: _passwordController.text,
        role: user.role);
    sl<ApiService>()
        .updateUser(sl<AppService>().token, saveUser.id, saveUser)
        .then((value) {
      Navigator.pop(context);
      _userBloc.add(const Load());
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void onPressedRow(BuildContext context, UserModel user) {
    _usernameController.text = user.username;
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
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
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
          )
        ]).show();
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
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }
}
