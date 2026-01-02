import 'package:carpark/config/constants.dart';
import 'package:carpark/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.loginViewModel, super.key});

  final LoginViewModel loginViewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ListenableSubscription? loginViewModelSubscription;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void didChangeDependencies() {
    loginViewModelSubscription ??= widget.loginViewModel.loginCommand.listen((
      event,
      _,
    ) {
      switch (event) {
        case Ok<void>():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login Success')));
        case Error<void>():
          alertError(event.error.toString());
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    loginViewModelSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
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
                      TextField(
                        controller: _usernameController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          suffixIcon: const Icon(Icons.account_circle),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20,
                            20,
                            20,
                            20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
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
                          contentPadding: const EdgeInsets.fromLTRB(
                            20,
                            20,
                            20,
                            20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSubmitted: (_) => loginUser(),
                      ),
                      const SizedBox(height: 18),
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
                          onPressed: loginUser,
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
      ),
    );
  }

  Future<void> loginUser() async {
    if (_usernameController.text.length < 3 ||
        _passwordController.text.length < 3) {
      alertLogin('Please fill username and password');
      return;
    }
    try {
      widget.loginViewModel.loginCommand.run((
        _usernameController.text,
        _passwordController.text,
      ));

      setState(() {
        _usernameController.text = '';
        _passwordController.text = '';
      });
    } on DioException catch (_) {
      alertError('Network error: ไม่สามารถเข้าสู่ระบบได้');
    } on Exception catch (e) {
      alertError(e.toString());
    }
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
                context.pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void alertLogin(String desc) {
    final alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: Colors.grey),
      ),
      titleStyle: const TextStyle(color: Colors.red),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: 'Login Failed',
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: () => context.pop(),
          color: const Color.fromRGBO(0, 179, 134, 1),
          radius: BorderRadius.circular(0),
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
