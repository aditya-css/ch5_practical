import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/pages/increment_count_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FavouriteBarPage extends StatelessWidget {
  const FavouriteBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterStore>(
      builder: (_, store, __) => Observer(
        builder: (_) => Container(
          color: store.bgColor,
          child: Navigator(
            key: store.nestedNavKey,
            observers: <RouteObserver<ModalRoute<void>>>[
              store.nestedRouteObserver
            ],
            initialRoute: IncrementCount.routeName,
            onGenerateRoute: store.generateNestedRoute,
          ),
        ),
      ),
    );
  }
}
