import 'package:flutter/material.dart';
import 'swipe_feed_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tinder cards demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SwipeFeedPage(),
    );
  }
}
