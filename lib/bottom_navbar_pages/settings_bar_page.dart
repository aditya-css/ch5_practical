import 'package:flutter/material.dart';

class SettingsBarPage extends StatelessWidget {
  const SettingsBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
