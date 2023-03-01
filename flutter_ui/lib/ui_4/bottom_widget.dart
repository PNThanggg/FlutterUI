import 'package:flutter/material.dart';

class BottomWidget extends StatefulWidget {
  GlobalKey sizeKey;

  BottomWidget(this.sizeKey);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  List<String> names = [
    "John Doe",
    "David Schwimmer",
    "Alexander",
    "Sivorsky",
    "Harold",
    "Folyed",
    "Rosemary",
    "Rosemary",
    "Rosemary",
    "Rosemary",
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      key: widget.sizeKey,
      elevation: 4,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          top: 100,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> list = [];

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          "MONEY TRANSFER",
          style: TextStyle(
            color: Color(0xffCFCFCE),
            fontSize: 14,
          ),
        ),
        Text(
          "Search people",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
      ],
    ));

    list.add(const Padding(
      padding: EdgeInsets.only(
        top: 20,
      ),
    ));

    list.addAll(names.map((s) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              child: FlutterLogo(),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
            ),
            Expanded(
              child: Text(
                s,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
      );
    }).toList());

    list.add(const Padding(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
    ));
    return list;
  }
}
