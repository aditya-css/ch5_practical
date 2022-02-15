import 'package:ch5_practical/bottom_navbar_pages/favourite_bar_page.dart';
import 'package:ch5_practical/bottom_navbar_pages/home_bar_page.dart';
import 'package:ch5_practical/bottom_navbar_pages/settings_bar_page.dart';
import 'package:ch5_practical/bottom_navbar_pages/store_bar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _bottomNavBarPages;

  final List<BottomNavigationBarItem> _bottomNavBarItems =
      const <BottomNavigationBarItem>[
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
  void initState() {
    _bottomNavBarPages = <Widget>[
      HomeBarPage(onActionTap: _onItemTapped),
      const StoreBarPage(),
      const FavouriteBarPage(),
      const SettingsBarPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _bottomNavBarPages,
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
