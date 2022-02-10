import 'package:ch5_practical/counter_page_widgets/counter_inherited_widget.dart';
import 'package:ch5_practical/counter_page_widgets/decrement_count_page.dart';
import 'package:ch5_practical/counter_page_widgets/increment_count_page.dart';
import 'package:ch5_practical/routing/custom_route_transition.dart';
import 'package:flutter/material.dart';

class FavouriteBarPage extends StatefulWidget {
  const FavouriteBarPage({Key? key}) : super(key: key);

  static final RouteObserver<ModalRoute<void>> nestedRouteObserver =
      RouteObserver<ModalRoute<void>>();

  @override
  State<FavouriteBarPage> createState() => _FavouriteBarPageState();
}

class _FavouriteBarPageState extends State<FavouriteBarPage> {
  final GlobalKey<NavigatorState> _nestedNavKey = GlobalKey<NavigatorState>();

  int _count = 0;
  late Color _backColor;

  void _handleCountChange(int newCount) => setState(() => _count = newCount);

  void _handlePageChange(String routeName) =>
      _nestedNavKey.currentState!.pushReplacementNamed(routeName);

  void _handleColorChange(Color newColor) {
    if (_backColor != newColor) {
      setState(() => _backColor = newColor);
    }
  }

  Route<dynamic> _generateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case IncrementCount.routeName:
        return MyRouteTransition(page: const IncrementCount());
      case DecrementCount.routeName:
        return MyRouteTransition(page: const DecrementCount());
      default:
        return MyRouteTransition(page: const IncrementCount());
    }
  }

  @override
  void didChangeDependencies() {
    _backColor = Theme.of(context).colorScheme.secondaryVariant;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CounterParentWidget(
      count: _count,
      onCountChange: _handleCountChange,
      onColorChange: _handleColorChange,
      onPageChange: _handlePageChange,
      child: Container(
        color: _backColor,
        child: Navigator(
          key: _nestedNavKey,
          observers: <RouteObserver<ModalRoute<void>>>[
            FavouriteBarPage.nestedRouteObserver
          ],
          initialRoute: IncrementCount.routeName,
          onGenerateRoute: _generateNestedRoute,
        ),
      ),
    );
  }
}
