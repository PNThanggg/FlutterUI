import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Inconsolata-Regular",
        backgroundColor: Colors.black26,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black26,
          fontFamily: "Inconsolata-Regular"
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                            height: 360,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: DefaultTextStyle(
                                        style: TextStyle(color: Colors.black, fontSize: 24), child: Text("Exit App")),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: DefaultTextStyle(
                                        style: TextStyle(color: Colors.black, fontSize: 18),
                                        child: Text("Are you sure you want to exit the app?")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      width: 240,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.black, width: 1)),
                                      child: const Center(
                                        child: DefaultTextStyle(
                                            style: TextStyle(color: Colors.black, fontSize: 18), child: Text("Exit")),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width: 240,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.black, width: 1)),
                                      child: const Center(
                                        child: DefaultTextStyle(
                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                          child: Text("Cancel"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      width: 240,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.black, width: 1)),
                                      child: const Center(
                                        child: DefaultTextStyle(
                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                          child: Text("Follow on Instagram"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
            child: const Text("Show dialog"),
          ),
        ),
      ),
    );
  }
}
