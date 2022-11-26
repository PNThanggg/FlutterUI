import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';

class PasswordContainer extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const PasswordContainer({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: kPrimaryLightColor, borderRadius: BorderRadius.circular(30)),
        child: TextField(
            onChanged: onChanged,
            decoration: const InputDecoration(
                hintText: "Your password",
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: kPrimaryColor,
                ),
                border: InputBorder.none)));
  }
}
