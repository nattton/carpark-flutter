import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:carpark/features/user/presentation/bloc/user_bloc.dart';
import 'package:carpark/features/user/presentation/widget/user_list_card.dart';
import 'package:carpark/features/user/presentation/widget/user_list_header.dart';
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
        if (state.loadingResult.value != null) {
          _userBloc.add(const ClearError());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.loadingResult.value!),
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
              _userBloc.add(
                Update(
                  id: user.id,
                  username: _usernameController.text,
                  password: _passwordController.text,
                  role: user.role,
                ),
              );
              if (Navigator.canPop(context)) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => Navigator.pop(context));
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
