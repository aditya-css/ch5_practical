import 'package:ch5_practical/features/favourite_article_local_store/presentation/pages/favourite_bar_page.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/home_bar_page.dart';
import 'package:ch5_practical/features/settings_app_permission/presentation/pages/settings_bar_page.dart';
import 'package:ch5_practical/features/store_platform_widgets/presentation/pages/store_bar_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  final List<Widget> _bottomNavBarPages = const <Widget>[
    HomeBarPage(),
    StoreBarPage(),
    FavouriteBarPage(),
    SettingsBarPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.cart_fill), label: 'Store'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.star_fill), label: 'Favourite'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.gear_alt_fill), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavStore>(
      builder: (_, store, __) => Observer(
        builder: (_) => Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: store.index,
            children: _bottomNavBarPages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: store.index,
            onTap: (newIndex) => store.onItemTap(newIndex),
            iconSize: 28,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: _bottomNavBarItems,
          ),
        ),
      ),
    );
  }
}
