import 'package:design_ui/Components/rounded_button.dart';
import 'package:design_ui/Screen/Login/login_screen.dart';
import 'package:design_ui/Screen/SignUp/signup_screen.dart';
import 'package:design_ui/Screen/Welcome/background.dart';
import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "Login",
                textColor: Colors.white,
                color: kPrimaryColor,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
              ),
              RoundedButton(
                text: "Sign Up",
                textColor: Colors.black,
                color: kPrimaryLightColor,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUpScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
