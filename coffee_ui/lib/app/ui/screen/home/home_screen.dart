import 'package:coffee_ui/app/util/coffee_tile.dart';
import 'package:coffee_ui/app/util/coffee_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List coffeeType = [
    [
      "Cappucino",
      true,
    ],
    [
      "Latte",
      false,
    ],
    [
      "Black",
      false,
    ],
    [
      "Tea",
      false,
    ],
  ];

  void coffeeTypedSelected(int index) {
    setState(() {
      for(int i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }

      coffeeType[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.0.wp),
            child: const Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
            child: Text("Find the best coffee for you", style: GoogleFonts.bebasNeue(fontSize: 40.0.sp)),
          ),
          SizedBox(
            height: 3.0.hp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Find the coffee ...",
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600))),
            ),
          ),
          SizedBox(
            height: 3.0.hp,
          ),
          SizedBox(
            height: 6.0.hp,
            child: ListView.builder(
              itemCount: coffeeType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  CoffeeType(
                      type: coffeeType[index][0], isSelected: coffeeType[index][1], onTap: () {
                    coffeeTypedSelected(index);
                  }),
            ),
          ),
          Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CoffeeTile(coffeeImagePath: "lib/app/res/images/latte.jpg", coffeeName: "Late", coffeePrice: "\$4.20"),
                  CoffeeTile(coffeeImagePath: "lib/app/res/images/latte.jpg", coffeeName: "Late", coffeePrice: "\$4.20"),
                  CoffeeTile(coffeeImagePath: "lib/app/res/images/latte.jpg", coffeeName: "Late", coffeePrice: "\$4.20"),
                ],
              ))
        ],
      ),
    );
  }
}
