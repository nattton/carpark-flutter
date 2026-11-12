import 'package:carpark/config/injector.dart';
import 'package:carpark/ui/features/auth/login/view_models/login_viewmodel.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:material_ui/material_ui.dart';

class LoginPasswordField extends WatchingWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final password = watchValue(
      (LoginViewModel viewModel) => viewModel.passwordChangedCommand,
    );

    final obscurePassword = watchValue(
      (LoginViewModel viewModel) => viewModel.obscurePasswordChangedCommand,
    );
    return TextFormField(
      initialValue: password,
      autocorrect: false,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: GestureDetector(
          onTap: () {
            getIt<LoginViewModel>().obscurePasswordChangedCommand(
              !getIt<LoginViewModel>().obscurePasswordChangedCommand.value,
            );
          },
          child: const Icon(Icons.lock),
        ),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (value) =>
          getIt<LoginViewModel>().passwordChangedCommand(value),
      onFieldSubmitted: (_) => getIt<LoginViewModel>().loginCommand.run(),
    );
  }
}
