import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'bottom_widget.dart';
import 'center_widget.dart';
import 'top_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  double _height1 = 0;
  double _height2 = 0;
  double _height3 = 0;

  double eachPadding = 50;
  double maxLeft = 100;
  double yOffset = 0;
  double maxOffset = 1;

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          yOffset = _scrollController!.offset;
        });
      });

    SchedulerBinding.instance.endOfFrame.then((v) {
      _height1 = _findHeightByKey(_key1);
      _height2 = _findHeightByKey(_key2);
      _height3 = _findHeightByKey(_key3);

      maxOffset = _height1 + _height2 + _height3 - eachPadding * 2 - MediaQuery.of(context).size.height;

      if (maxOffset <= 0) {
        maxOffset = 0;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              child: SizedBox(
                height: _height1 == 0 ? 0 : (_height1 + _height2 + _height3 - eachPadding * 2),
                child: Stack(
                  children: _buildStack(),
                ),
              ),
            ),
            Positioned(
              top: kToolbarHeight,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 70,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.notifications_none,
                          color: Color(0xff696969),
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.info_outline,
                          color: Color(0xff696969),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: kToolbarHeight,
              left: 10,
              child: CircleAvatar(
                minRadius: 30,
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStack() {
    List<Widget> list = [];
    list.add(Positioned(
      top: _height1 + _height2 - eachPadding * 2,
      left: maxLeft / 2 - maxLeft / 2 * (1.0 * yOffset / maxOffset),
      child: BottomWidget(_key3),
    ));
    list.add(Positioned(
      top: _height1 - eachPadding,
      left: maxLeft * (1.0 * yOffset / maxOffset),
      child: CenterWidget(_key2),
    ));
    list.add(Positioned(
      top: 0,
      left: 0,
      child: TopWidget(_key1),
    ));

    return list;
  }

  double _findHeightByKey(GlobalKey<State<StatefulWidget>> key) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;

    return renderBox.size.height;
  }
}
