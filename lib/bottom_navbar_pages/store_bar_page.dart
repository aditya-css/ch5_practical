import 'package:flutter/material.dart';

import '../tabbar_page_widgets/android_tabbar_page.dart';
import '../tabbar_page_widgets/ios_tabbar_page.dart';

class StoreBarPage extends StatelessWidget {
  const StoreBarPage({Key? key}) : super(key: key);

  final List<Text> _tabs = const <Text>[
    Text(
      'Android',
      style: TextStyle(fontSize: 18, height: 4),
    ),
    Text(
      'iOS',
      style: TextStyle(fontSize: 18, height: 4),
    ),
  ];

  final List<Widget> _tabViews = const <Widget>[
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
        body: Center(
          child: TabBarView(children: _tabViews),
        ),
      ),
    );
  }
}
