import 'package:carpark/injector/injector.dart';
import 'package:carpark/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class LoginUsernameField extends WatchingWidget {
  const LoginUsernameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final username = watchValue(
      (LoginViewModel viewModel) => viewModel.username,
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
      onChanged: (value) => getIt<LoginViewModel>().username.value = value,
    );
  }
}
