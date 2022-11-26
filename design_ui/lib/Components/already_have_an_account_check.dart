import 'package:design_ui/Screen/Login/login_screen.dart';
import 'package:design_ui/Screen/SignUp/signup_screen.dart';
import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() press;

  const AlreadyHaveAnAccountCheck(
      {Key? key, required this.login, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(login ? "Don't have an account? " : "Already have an account? ",
            style: const TextStyle(color: kPrimaryColor)),
        GestureDetector(
          onTap: () {
            login
                ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUpScreen();
                  }))
                : Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
          },
          child: Text(login ? "Sign Up" : "Sign In",
              style: const TextStyle(
                  color: kPrimaryColor, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
