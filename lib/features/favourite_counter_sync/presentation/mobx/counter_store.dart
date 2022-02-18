import 'package:ch5_practical/core/routing/custom_route_transition.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/pages/decrement_count_page.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/pages/increment_count_page.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterStore = _CounterStore with _$CounterStore;

abstract class _CounterStore with Store {
  @readonly
  int _count = 0;

  @readonly
  Color _bgColor = kSecondaryContainer;

  @action
  void updateCount(CounterActions type) {
    if (type == CounterActions.decrement) {
      if (_count > 0) _count--;
    } else {
      _count++;
    }
  }

  @action
  void changeBackgroundColor(Color newColor) => _bgColor = newColor;

  final RouteObserver<ModalRoute<void>> nestedRouteObserver =
      RouteObserver<ModalRoute<void>>();

  final GlobalKey<NavigatorState> nestedNavKey = GlobalKey<NavigatorState>();

  void handlePageChange(CounterActions type) {
    String _routeName = (type == CounterActions.increment)
        ? DecrementCount.routeName
        : IncrementCount.routeName;
    nestedNavKey.currentState!.pushReplacementNamed(_routeName);
  }

  Route<dynamic> generateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case IncrementCount.routeName:
        return MyRouteTransition(const IncrementCount());
      case DecrementCount.routeName:
        return MyRouteTransition(const DecrementCount());
      default:
        return MyRouteTransition(const IncrementCount());
    }
  }
}
