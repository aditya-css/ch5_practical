import 'package:flutter/material.dart';

import '../tabbar_page_widgets/android_tabbar_page.dart';
import '../tabbar_page_widgets/ios_tabbar_page.dart';

class StoreBarPage extends StatelessWidget {
  const StoreBarPage({Key? key}) : super(key: key);

  static const List<Text> _tabs = <Text>[
    Text(
      'Android',
      style: TextStyle(fontSize: 18, height: 4),
    ),
    Text(
      'iOS',
      style: TextStyle(fontSize: 18, height: 4),
    ),
  ];

  static const List<Widget> _tabViews = <Widget>[
    AndroidTabBarPage(),
    IOSTabBarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              indicatorWeight: 4.0,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              tabs: _tabs,
            ),
          ),
        ),
        body: const Center(
          child: TabBarView(children: _tabViews),
        ),
      ),
    );
  }
}
