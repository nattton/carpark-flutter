import 'package:carpark/features/auth/login/view_models/login_viewmodel.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class LoginUsernameField extends WatchingWidget {
  const LoginUsernameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final username = watchValue(
      (LoginViewModel viewModel) => viewModel.usernameChangedCommand,
    );
    return TextFormField(
      initialValue: username,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Username',
        suffixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.all(
          20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) =>
          getIt<LoginViewModel>().usernameChangedCommand(value),
    );
  }
}
