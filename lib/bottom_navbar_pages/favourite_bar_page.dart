import 'package:flutter/material.dart';

class FavouriteBarPage extends StatelessWidget {
  const FavouriteBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favourite',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
