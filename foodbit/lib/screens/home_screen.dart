import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import './../style/theme.dart' as style;
import '../widgets/food_list.dart';
import '../widgets/order_again.dart';
import '../widgets/top_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Good morning, Bilguun",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                ),
                Stack(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(right: 1.0, top: 3.5),
                      child: Icon(
                        EvaIcons.bellOutline,
                        size: 25.0,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: style.Colors.mainColor,
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 1.0, bottom: 1.0),
                              child: Text(
                                "2",
                                style: TextStyle(color: Colors.white, fontSize: 7.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(width: 1.0, color: Colors.grey[300]!)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(
                    EvaIcons.searchOutline,
                    color: style.Colors.mainColor,
                  ),
                  Text(
                    "Find a food or Restaurant",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16.0),
                  ),
                  const Icon(
                    EvaIcons.moreHorizontalOutline,
                    color: style.Colors.mainColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 140,
            child: HomeHeader(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Popular Food",
              style: TextStyle(fontSize: 20.0, color: style.Colors.titleColor),
            ),
          ),
          SizedBox(
            height: 275,
            child: FoodList(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Order Again",
              style: TextStyle(fontSize: 20.0, color: style.Colors.titleColor),
            ),
          ),
          OrderAgain()
        ],
      ),
    );
  }
}
