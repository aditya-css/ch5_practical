import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/pages/custom_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecrementCount extends StatefulWidget {
  const DecrementCount({Key? key}) : super(key: key);

  static const String routeName = '/decrement';

  @override
  _DecrementCountState createState() => _DecrementCountState();
}

class _DecrementCountState extends State<DecrementCount> with RouteAware {
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
          actionType: CounterActions.decrement,
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
      (_) => Provider.of<CounterStore>(context, listen: false)
          .changeBackgroundColor(
        Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
