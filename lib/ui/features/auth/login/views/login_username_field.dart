import 'package:carpark/config/injector.dart';
import 'package:carpark/ui/features/auth/login/view_models/login_viewmodel.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:material_ui/material_ui.dart';

class LoginUsernameField extends WatchingWidget {
  const new({super.key});

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
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (value) =>
          getIt<LoginViewModel>().usernameChangedCommand(value),
    );
  }
}
