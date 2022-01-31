import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navbar_pages/favourite_bar_page.dart';
import 'bottom_navbar_pages/home_bar_page.dart';
import 'bottom_navbar_pages/settings_bar_page.dart';
import 'bottom_navbar_pages/store_bar_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int get _secondPageIndex => 1;
  int _selectedIndex = 0;

  static const List<Widget> _bottomNavBarPages = <Widget>[
    HomeBarPage(),
    StoreBarPage(),
    FavouriteBarPage(),
    SettingsBarPage(),
  ];

  static const List<BottomNavigationBarItem> _bottomNavBarItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.cart_fill),
      label: 'Store',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.star_fill),
      label: 'Favourite',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.gear_alt_fill),
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bottomNavBarPages.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(_secondPageIndex),
        child: const Icon(CupertinoIcons.cart_fill),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 28,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: _bottomNavBarItems,
      ),
    );
  }
}
