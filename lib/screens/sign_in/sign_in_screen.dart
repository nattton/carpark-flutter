import 'package:carpark/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:carpark/screens/sign_in/bloc/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carpark/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  static const String id = 'sign_in_screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 800.w,
        height: 600.h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(gradient: kBackgroundGradiant),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 48.0,
                    ),
                    Text(
                      'Car Park',
                      style: TextStyle(
                        fontSize: 56.0,
                        fontFamily: kDefaultFont,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Car Park Management System',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: kDefaultFont,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400.0,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'User Login',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: kDefaultFont,
                          fontWeight: FontWeight.bold,
                          color: kColorTextGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        onChanged: (value) => context
                            .read<SignInBloc>()
                            .add(SignInEvent.usernameChanged(value)),
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          suffixIcon: const Icon(Icons.account_circle),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        onChanged: (value) => context
                            .read<SignInBloc>()
                            .add(SignInEvent.passwordChanged(value)),
                        autofocus: false,
                        autocorrect: false,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: const Icon(Icons.lock),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onSubmitted: (_) =>
                            SignInController(context: context).handleSignIn(),
                      ),
                      const SizedBox(height: 18.0),
                      Container(
                        height: 50,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          gradient: kBackgroundGradiant,
                        ),
                        child: MaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: const StadiumBorder(),
                          onPressed: () =>
                              SignInController(context: context).handleSignIn(),
                          child: const Text(
                            '   Login   ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
