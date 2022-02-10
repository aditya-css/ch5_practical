import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class CounterParentWidget extends InheritedWidget {
  const CounterParentWidget({
    required this.count,
    required this.onCountChange,
    required this.onPageChange,
    required this.onColorChange,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final int count;
  final ChangeCount<int> onCountChange;
  final ChangePage<String> onPageChange;
  final ChangeColor<Color> onColorChange;

  @override
  bool updateShouldNotify(covariant CounterParentWidget oldWidget) =>
      count != oldWidget.count;

  static CounterParentWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CounterParentWidget>();
}
