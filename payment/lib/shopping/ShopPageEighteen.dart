import "package:flutter/material.dart";

import '../../const/color_const.dart';

class ShopPageEighteen extends StatefulWidget {
  const ShopPageEighteen({super.key});

  @override
  _ShopEighteenState createState() => _ShopEighteenState();
}

class _ShopEighteenState extends State<ShopPageEighteen> {
  Widget _backButton() {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 20),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromRGBO(7, 7, 7, 1), Color.fromRGBO(59, 59, 59, 1)],
          ),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
          child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          print("Go Back");
        },
      )),
    );
  }

  late List<Widget> paymentOptions;
  List<Color> payment_colors = <Color>[
    const Color.fromRGBO(249, 238, 169, 1),
    const Color.fromRGBO(173, 210, 252, 1),
    GREEN,
  ];

  List<String> imageurl = <String>[
    "assets/images/shopping/paypal.png",
    "assets/images/shopping/visa.png",
    "assets/images/shopping/apple_pay.png"
  ];

  Widget floatingTextFieldWidget(name, topmargin) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(top: topmargin, left: 10, right: 10),
      child: Theme(
        data: ThemeData(
            primaryColor: Colors.black,
            primaryColorDark: Colors.blue,
            highlightColor: Colors.green,
            textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.blue[100]) // text selection color
            ),
        child: TextField(
          decoration: InputDecoration(
            prefixStyle: const TextStyle(color: RED),
            prefix: Text(
              name + "        ",
            ),
            hintStyle: const TextStyle(color: Colors.white),
            // helperText: 'Keep it short, this is just a demo.',
            labelText: name,
            labelStyle: const TextStyle(color: Colors.black),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // prefixText: 'Email ',
            // suffixText: 'USD',
            // suffixStyle: const TextStyle(color: Colors.green)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
            //appbar
            height: 80,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [YELLOW, BLUE])),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: FractionalOffset.center,
                    child: const Text(
                      "PAYMENT",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: FractionalOffset.centerRight,
                    margin: const EdgeInsets.only(top: 15),
                    child: IconButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Color.fromRGBO(7, 7, 7, 1),
                        size: 30,
                      ),
                      onPressed: () {
                        print("More Vertical options needed");
                      },
                    ),
                  ),
                )
              ],
            ),
          ), //appbar end
          Container(
            //Horizontal ListView
            height: MediaQuery.of(context).size.height / 3.8,
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [YELLOW, Color.fromRGBO(211, 239, 202, 1)])),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int currentindex) {
                  return InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: payment_colors[currentindex],
                          child: Image.asset(
                            imageurl[currentindex],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ));
                }),
          ),
          Expanded(
            //Button Background
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  colors: [YELLOW, BLUE],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: FractionalOffset.topCenter,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(7, 7, 7, 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(198, 193, 124, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ]),
        Positioned(
          top: MediaQuery.of(context).size.height / 2.8,
          width: MediaQuery.of(context).size.width,
          child: Container(
            //pink container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [RED_LIGHT, RED],
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.2,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                floatingTextFieldWidget("Card Number", 10.0),
                floatingTextFieldWidget("Name", 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: floatingTextFieldWidget("Exp Date", 10.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: floatingTextFieldWidget("CVV", 10.0),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.black),
                      child: Theme(
                        data: ThemeData(disabledColor: Colors.lightBlue[100]),
                        child: const Radio(
                          value: null,
                          groupValue: null,
                          onChanged: null,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 10), child: const Text("Save credit card information")),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(margin: const EdgeInsets.only(top: 10), child: _backButton())
      ],
    )));
  }
}

// #abecd6  blue gradient
// #fbed96 yellow gradient
// #ffb0bb pink card right top
// #f7eeaa paypal color
// #f9eea9 paypal left
// #d3efca apple pay right top
// #a3c6fd visa right bottom
// #add2fc visa right top
// #bde4fb visa left center
// #3b3b3b button color right
// #070707 button left
// #c6c17c Button text color  rgb(198, 193, 124)
// #34323d underline color rgb(52, 50, 61)
