import 'package:flutter/material.dart';

import 'bg_widget.dart';
import 'front_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double left = 0;
  late double direction;

  double MAX_LEFT = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          MAX_LEFT = MediaQuery.of(context).size.width * 1.0 - 80;
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onHorizontalDragUpdate: (update) {
        left = left + update.delta.dx;
        direction = update.delta.direction;
        if (left <= 0) {
          left = 0;
        }

        if (left > MAX_LEFT) {
          left = MAX_LEFT;
        }
        setState(() {});
      },
      onHorizontalDragEnd: (end) {
        animateWidget();
      },
      child: Container(
        color: const Color(0xff191f39),
        child: Stack(
          children: <Widget>[
            BgWidget(open),
            Positioned(
              left: left,
              top: left * 0.2,
              bottom: left * 0.2 / 2,
              child: FrontWidget(open),
            ),
          ],
        ),
      ),
    );
  }

  void open() {
    if (left == MAX_LEFT) {
      direction = 1;
    } else {
      direction = 0;
    }

    animateWidget();
  }

  late Animation _animation;

  void animateWidget() {
    bool increment = direction <= 0;

    AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        left = _animation.value;
        setState(() {});
      });

    double tempLeft = left;
    _animation = Tween(
      begin: tempLeft,
      end: increment ? MAX_LEFT : 0.0,
    ).animate(CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn, parent: controller));

    controller.forward();
  }
}
