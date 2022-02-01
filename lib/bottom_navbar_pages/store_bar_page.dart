import 'package:flutter/material.dart';

import '../tabbar_page_widgets/android_tabbar_page.dart';
import '../tabbar_page_widgets/ios_tabbar_page.dart';

enum SampleDialogOptions { option1, option2 }

extension SimpleDialogOptionsExtension on SampleDialogOptions {
  String get value {
    switch (this) {
      case SampleDialogOptions.option1:
        return 'Sample Option 1';
      case SampleDialogOptions.option2:
        return 'Sample Option 2';
    }
  }
}

class StoreBarPage extends StatelessWidget {
  const StoreBarPage({Key? key}) : super(key: key);

  int get _startIndex => 0;

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
      initialIndex: _startIndex,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: const Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              indicatorWeight: 4.0,
              indicatorColor: Colors.lightBlueAccent,
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
