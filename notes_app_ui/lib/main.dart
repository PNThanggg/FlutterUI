import 'package:flutter/material.dart';
import 'package:notes_app_ui/app_color.dart';

import 'view/landing_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          tabBarTheme: const TabBarTheme(
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3, color: AppColors.orange),
              )),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.buttonColor,
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: AppColors.lightTextColor)),
          appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: AppColors.lightTextColor),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))))),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingView(),
    );
  }
}
