import 'package:flutter/material.dart';

class ProfileCardDraggable extends StatelessWidget {
  final int cardNum;

  const ProfileCardDraggable(this.cardNum, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.asset('res/portrait.jpeg', fit: BoxFit.cover),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Card number $cardNum', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  const Text('A short description.', textAlign: TextAlign.start),
                ],
              ))
        ],
      ),
    );
  }
}
