import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
              child: Divider(
                color: Colors.deepPurple[400],
                height: 2,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or',
              style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              child: Divider(
                color: Colors.deepPurple[400],
                height: 2,
              )),
        ],
      ),
    );
  }
}
