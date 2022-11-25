import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import './../style/theme.dart' as style;
import '../model/food.dart';

class OrderAgain extends StatelessWidget {
  final foodItems = <Food>[
    Food(title: "Italian Pasta", price: "25.00", img: 'assets/icons/foods/food3.jpg', rating: "4.2"),
    Food(title: "Pasta with Ham", price: "20.00", img: 'assets/icons/foods/food2.jpg', rating: "4.2"),
    Food(title: "Black Beef", price: "13.00", img: 'assets/icons/foods/food4.jpg', rating: "4.7")
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: foodItems.length * 100.0,
      child: ListView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: foodItems.map<Widget>((Food food) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(image: AssetImage(food.img), fit: BoxFit.cover)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width - 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                food.title,
                                style: const TextStyle(color: Colors.black, fontSize: 14.0),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        food.rating,
                                        style: const TextStyle(fontSize: 9.0, color: Colors.black38),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Icon(
                                        EvaIcons.star,
                                        color: style.Colors.mainColor,
                                        size: 8.0,
                                      ),
                                      const Icon(
                                        EvaIcons.star,
                                        color: style.Colors.mainColor,
                                        size: 8.0,
                                      ),
                                      const Icon(
                                        EvaIcons.star,
                                        color: style.Colors.mainColor,
                                        size: 8.0,
                                      ),
                                      const Icon(
                                        EvaIcons.star,
                                        color: style.Colors.mainColor,
                                        size: 8.0,
                                      ),
                                      const Icon(
                                        EvaIcons.star,
                                        color: Colors.black38,
                                        size: 8.0,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Text(
                                        "(200)",
                                        style: TextStyle(fontSize: 9.0, color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "\$${food.price}",
                              style: const TextStyle(fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
