import 'package:design_ui/Components/OrDivider.dart';
import 'package:design_ui/Screen/Login/login_screen.dart';
import 'package:design_ui/Screen/SignUp/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/already_have_an_account_check.dart';
import '../../Components/password_container.dart';
import '../../Components/rounded_button.dart';
import '../../Components/text_filed_contaier.dart';
import '../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                TextFiledContainer(
                    hintText: "Your email",
                    iconData: Icons.email,
                    onChanged: (value) {}),
                PasswordContainer(
                  onChanged: (value) {},
                ),
                RoundedButton(
                    text: "Sign Up",
                    textColor: Colors.white,
                    press: () {},
                    color: kPrimaryColor),
                AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    }),
                SizedBox(height: size.height * 0.015),
                const OrDivider(),
                SizedBox(height: size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalIcon(path: "assets/icons/facebook.svg", press: () {}),
                    SocalIcon(
                        path: "assets/icons/google-plus.svg", press: () {}),
                    SocalIcon(path: "assets/icons/twitter.svg", press: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocalIcon extends StatelessWidget {
  final String path;
  final Function() press;

  const SocalIcon({Key? key, required this.path, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          path,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
