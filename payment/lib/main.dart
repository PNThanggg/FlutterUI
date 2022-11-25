import 'package:flutter/material.dart';

import 'const/color_const.dart';
import 'const/string_const.dart';
import 'shopping/ShopPageEighteen.dart';
import 'shopping/ShopPageNineteen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: BLUE_DEEP,
        fontFamily: "Montserrat",
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: YELLOW),
      ),
      home: const ShopPageEighteen(),
    );
  }
}
