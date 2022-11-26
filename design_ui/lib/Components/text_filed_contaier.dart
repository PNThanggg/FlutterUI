import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';

class TextFiledContainer extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;

  const TextFiledContainer({
    Key? key,
    required this.hintText,
    required this.iconData,
    required this.onChanged
  }) : super(key: key);

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
          decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(
                iconData,
                color: kPrimaryColor,
              ),
              border: InputBorder.none)),
    );
  }
}
