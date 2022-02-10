import 'package:ch5_practical/bottom_navbar_pages/favourite_bar_page.dart';
import 'package:ch5_practical/counter_page_widgets/counter_inherited_widget.dart';
import 'package:ch5_practical/counter_page_widgets/custom_counter_page.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class IncrementCount extends StatefulWidget {
  const IncrementCount({Key? key}) : super(key: key);

  static const String routeName = '/increment';

  @override
  _IncrementCountState createState() => _IncrementCountState();
}

class _IncrementCountState extends State<IncrementCount> with RouteAware {
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
          FavouriteActions.increment,
          title: 'Friends Adder',
          buttonTitle: 'Lost A Friend',
          fabIcon: Icon(Icons.add),
          tooltip: 'Increment',
        ),
      ),
    );
  }

  @override
  void didPush() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _colorChanger(
        Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
