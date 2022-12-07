import 'package:flutter/material.dart';

import '../util/extensions.dart';

class CoffeeTile extends StatelessWidget {
  final String coffeeImagePath;
  final String coffeeName;
  final String coffeePrice;

  const CoffeeTile({Key? key, required this.coffeeImagePath, required this.coffeeName, required this.coffeePrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.5.wp, bottom: 2.0.hp, right: 2.5.wp, top: 2.0.hp),
      child: Container(
        width: 45.0.wp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0.sp),
          color: Colors.black54,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0.sp),
                child: Image.asset(coffeeImagePath),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffeeName,
                    style: TextStyle(fontSize: 18.0.sp),
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  Text(
                    "With Almond Milk",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(coffeePrice),
                  Container(
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(3.0.sp)),
                    child: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
