import 'package:flutter/material.dart';

import '../util/extensions.dart';

class CoffeeType extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const CoffeeType({Key? key, required this.type, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0.wp),
        child: Text(
          type,
          style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold, color: isSelected ? Colors.orange : Colors.white),
        ),
      ),
    );
  }
}
