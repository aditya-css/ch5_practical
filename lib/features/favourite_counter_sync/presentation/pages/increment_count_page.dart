import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/pages/custom_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncrementCount extends StatefulWidget {
  const IncrementCount({Key? key}) : super(key: key);

  static const String routeName = '/increment';

  @override
  _IncrementCountState createState() => _IncrementCountState();
}

class _IncrementCountState extends State<IncrementCount> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CounterStore>(context, listen: false)
        .nestedRouteObserver
        .subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CounterPage(
          actionType: CounterActions.increment,
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
      (_) => Provider.of<CounterStore>(context, listen: false)
          .changeBackgroundColor(
              Theme.of(context).colorScheme.secondaryContainer),
    );
  }
}
