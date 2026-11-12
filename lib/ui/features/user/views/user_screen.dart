import 'dart:async';

import 'package:carpark/config/injector.dart';
import 'package:carpark/data/models/login_response/user_model.dart';
import 'package:carpark/domain/models/response_model.dart';
import 'package:carpark/domain/models/save_user_model.dart';
import 'package:carpark/ui/features/user/view_models/user_viewmodel.dart';
import 'package:carpark/ui/features/user/views/user_list_card.dart';
import 'package:carpark/utils/result.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserViewModel _viewModel;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<UserViewModel>();
    unawaited(_viewModel.loadUsers());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final userList = _viewModel.userList;
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
      },
    );
  }

  Future<void> saveUser(UserModel user) async {
    final saveUser = SaveUserModel(
      id: user.id,
      username: _usernameController.text,
      password: _passwordController.text,
      role: user.role,
    );
    final result = await _viewModel.updateUser(saveUser);
    switch (result) {
      case Ok<ResponseModel>():
        if (!mounted) return;
        GoRouter.of(context).pop();
      case Error<ResponseModel>():
        alertError(result.error.toString());
    }
  }

  void onPressedRow(BuildContext context, UserModel user) {
    _usernameController.text = user.name;
    _passwordController.text = '';

    unawaited(
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
              unawaited(saveUser(user));
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show(),
    );
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
