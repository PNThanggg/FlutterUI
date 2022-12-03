import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.transparent,
      )),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8)
      ..addListener(
        () {
          setState(() {
            _currentPageValue = _pageController.page!;
          });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(items[_currentPageValue.round()]['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 450,
              child: PageView.builder(
                controller: _pageController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // 0.0 ~ 1.0
                  var scale = (1 - (_currentPageValue - index).abs());
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(items[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30 - 30 * scale,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          // decoration: BoxDecoration(
                          //   color: Colors.black.withOpacity(0.3),
                          //   borderRadius: const BorderRadius.only(
                          //     bottomLeft: Radius.circular(15),
                          //     bottomRight: Radius.circular(15),
                          //   ),
                          // ),
                          child: const SizedBox.shrink(),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       items[index]['title']!,
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     Text(
                          //       items[index]['text']!,
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 12,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const items = [
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1552053831-71594a27632d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=624&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1552728089-57bdde30beb3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=734&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1589656966895-2f33e7653819?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  },
];
