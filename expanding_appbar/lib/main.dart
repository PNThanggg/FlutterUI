import 'package:expanding_appbar/expanding_appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<String>.generate(40, (i) => 'Item $i'),
  ));
}

class MyApp extends StatefulWidget {
  final List<String> items;
  const MyApp({Key? key, required this.items}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 90, end: 120).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AnimatedAppBar(
          title: const Text(
            'Expandable AppBar',
          ),
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ),
        body: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.items[index]),
              );
            }),
      ),
    );
  }
}
