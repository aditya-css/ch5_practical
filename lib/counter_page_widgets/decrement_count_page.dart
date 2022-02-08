import 'package:ch5_practical/bottom_navbar_pages/favourite_bar_page.dart';
import 'package:ch5_practical/counter_page_widgets/counter_inherited_widget.dart';
import 'package:ch5_practical/counter_page_widgets/custom_counter_page.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class DecrementCount extends StatefulWidget {
  const DecrementCount({Key? key}) : super(key: key);

  static const String routeName = '/decrement';

  @override
  _DecrementCountState createState() => _DecrementCountState();
}

class _DecrementCountState extends State<DecrementCount> with RouteAware {
  ChangeColor<Color> get _colorChanger =>
      CounterParentWidget.of(context)!.onColorChange;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FavouriteBarPage.nestedRouteObserver.subscribe(
      this,
      ModalRoute.of(context)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CounterPage(
          FavouriteActions.decrement,
          title: 'Friends Remover',
          buttonTitle: 'Made A Friend',
          fabIcon: Icon(Icons.remove),
          tooltip: 'Decrement',
        ),
      ),
    );
  }

  @override
  void didPush() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _colorChanger(
        Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
