import 'package:flutter/material.dart';

import 'cards_section_alignment.dart';

class SwipeFeedPage extends StatefulWidget {
  const SwipeFeedPage({super.key});

  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.grey)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.question_answer, color: Colors.grey)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[CardsSectionAlignment(context), buttonsRow()],
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: const Icon(Icons.loop, color: Colors.yellow),
          ),
          const Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: const Icon(Icons.close, color: Colors.red),
          ),
          const Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: const Icon(Icons.favorite, color: Colors.green),
          ),
          const Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: const Icon(Icons.star, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
