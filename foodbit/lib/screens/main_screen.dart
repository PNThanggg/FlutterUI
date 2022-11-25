import 'dart:typed_data';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../bloc/bottom_nav_bloc.dart';
import './../style/theme.dart' as style;

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);
  late BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
    barcode = '';
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return const HomeScreen();

            case NavBarItem.NEAR:
              return _alertArea();

            case NavBarItem.CART:
              return _alertArea();

            case NavBarItem.ACCOUNT:
              return _settingsArea();
          }
          return Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            selectedFontSize: 10.0,
            unselectedFontSize: 10.0,
            selectedItemColor: style.Colors.mainColor,
            unselectedItemColor: style.Colors.titleColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            iconSize: 25.0,
            currentIndex: snapshot.data!.index,
            onTap: _bottomNavBarBloc.pickItem,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  EvaIcons.homeOutline,
                  color: style.Colors.titleColor,
                ),
                activeIcon: Icon(
                  EvaIcons.home,
                  color: style.Colors.mainColor,
                ),
              ),
              BottomNavigationBarItem(
                label: 'History',
                icon: Icon(
                  EvaIcons.clockOutline,
                  color: style.Colors.titleColor,
                ),
                activeIcon: Icon(EvaIcons.clock, color: style.Colors.mainColor),
              ),
              BottomNavigationBarItem(
                label: 'Users',
                icon: Icon(
                  EvaIcons.heartOutline,
                  color: style.Colors.titleColor,
                ),
                activeIcon: Icon(EvaIcons.heart, color: style.Colors.mainColor),
              ),
              BottomNavigationBarItem(
                label: "Favourite",
                icon: Icon(
                  EvaIcons.bellOutline,
                  color: style.Colors.titleColor,
                ),
                activeIcon: Icon(EvaIcons.bell, color: style.Colors.mainColor),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _alertArea() {
    return const Center(
      child: Text(
        'Test Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _settingsArea() {
    return const Center(
      child: Text(
        'Test Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
