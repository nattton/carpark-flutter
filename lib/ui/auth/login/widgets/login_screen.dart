import 'package:carpark/config/constants.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class LoginScreen extends WatchingWidget {
  const LoginScreen({super.key});
  LoginViewModel get _loginViewModel => getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(content: Text(error?.error.toString() ?? 'Unknow Error')),
        );
      },
    );

    final username = watchValue(
      (LoginViewModel viewModel) => viewModel.username,
    );

    final password = watchValue(
      (LoginViewModel viewModel) => viewModel.password,
    );

    final obscurePassword = watchValue(
      (LoginViewModel viewModel) => viewModel.obscurePassword,
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
                child: Column(
                  children: [
                    const Text(
                      'User Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: kDefaultFont,
                        fontWeight: FontWeight.bold,
                        color: kColorTextGrey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
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
                          _loginViewModel.username.value = value,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: password,
                      autocorrect: false,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _loginViewModel.obscurePassword.value =
                                !_loginViewModel.obscurePassword.value;
                          },
                          child: const Icon(Icons.lock),
                        ),
                        contentPadding: const EdgeInsets.all(
                          20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) =>
                          _loginViewModel.password.value = value,
                      onFieldSubmitted: (_) =>
                          _loginViewModel.loginCommand.run(),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 50,
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        gradient: kBackgroundGradiant,
                      ),
                      child: MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const StadiumBorder(),
                        onPressed: _loginViewModel.loginCommand.run,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
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
