import 'package:carpark/config/constants.dart';
import 'package:carpark/ui/features/auth/login/view_models/login_viewmodel.dart';
import 'package:carpark/ui/features/auth/login/views/login_button.dart';
import 'package:carpark/ui/features/auth/login/views/login_password_field.dart';
import 'package:carpark/ui/features/auth/login/views/login_username_field.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:material_ui/material_ui.dart';

class LoginScreen extends WatchingWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    registerHandler(
      select: (LoginViewModel viewModel) => viewModel.loginCommand.isRunning,
      handler: (context, isRunning, cancel) async {
        if (isRunning) {
          await EasyLoading.show();
        } else {
          await EasyLoading.dismiss();
        }
      },
    );

    registerHandler(
      select: (LoginViewModel viewModel) => viewModel.loginCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Success')));
      },
    );

    registerHandler(
      select: (LoginViewModel viewModel) => viewModel.loginCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error?.error.toString() ?? 'Unknown Error')),
        );
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(gradient: kBackgroundGradiant),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 48),
                  Text(
                    'Car Park',
                    style: TextStyle(
                      fontSize: 56,
                      fontFamily: kDefaultFont,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Car Park Management System',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: kDefaultFont,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 36),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Column(
                  children: [
                    Text(
                      'User Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: kDefaultFont,
                        fontWeight: FontWeight.bold,
                        color: kColorTextGrey,
                      ),
                    ),
                    SizedBox(height: 30),
                    LoginUsernameField(),
                    SizedBox(height: 8),
                    LoginPasswordField(),
                    SizedBox(height: 18),
                    LoginButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
