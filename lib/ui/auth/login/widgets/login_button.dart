import 'package:carpark/config/constants.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: kBackgroundGradiant,
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        onPressed: getIt<LoginViewModel>().loginCommand.run,
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
    );
  }
}
