import 'package:flutter/material.dart';

import 'sections.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: section.title,
      button: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              section.leftColor,
              section.rightColor,
            ],
          ),
        ),
        child: Image.asset(
          section.backgroundAsset,
          color: const Color.fromRGBO(255, 255, 255, 0.075),
          colorBlendMode: BlendMode.modulate,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
