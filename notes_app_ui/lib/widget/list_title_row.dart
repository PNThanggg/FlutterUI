import 'package:flutter/material.dart';
import 'package:notes_app_ui/app_color.dart';

class ListTitleRow extends StatelessWidget {
  final String text;
  final bool isChecked;

  const ListTitleRow({Key? key, required this.text, required this.isChecked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 16,
          child: Checkbox(
            shape: const CircleBorder(
                side: BorderSide(width: 2, color: AppColors.white)),
            value: isChecked,
            activeColor: AppColors.white,
            checkColor: AppColors.grey,
            onChanged: (bool? val) {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
            child: Text(
          text,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ))
      ],
    );
  }
}
