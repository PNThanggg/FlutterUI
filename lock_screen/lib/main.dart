import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

List days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
List months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Time Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inconsolata-Regular',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final int hour = time.hour;
    final int minute = time.minute;

    final int day = time.weekday;
    final int month = time.month;
    final int dayInMonth = time.day;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 48,
              right: 0,
              left: 0,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}",
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${days[day - 1]}, ${months[month - 1]} $dayInMonth",
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
