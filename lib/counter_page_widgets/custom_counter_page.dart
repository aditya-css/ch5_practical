import 'dart:math' show Random;

import 'package:ch5_practical/counter_page_widgets/counter_inherited_widget.dart';
import 'package:ch5_practical/counter_page_widgets/custom_cartoon_counter.dart';
import 'package:ch5_practical/counter_page_widgets/decrement_count_page.dart';
import 'package:ch5_practical/counter_page_widgets/increment_count_page.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage(
    this.actionType, {
    Key? key,
    required this.title,
    required this.buttonTitle,
    required this.tooltip,
    required this.fabIcon,
  }) : super(key: key);

  final String tooltip, buttonTitle, title;
  final FavouriteActions actionType;
  final Icon fabIcon;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int? get _parentCount => CounterParentWidget.of(context)?.count;
  ChangeCount<int> get _modifyCount =>
      CounterParentWidget.of(context)!.onCountChange;
  ChangePage<String> get _navigatePage =>
      CounterParentWidget.of(context)!.onPageChange;

  void _handleActionPress(int value) {
    if (widget.actionType == FavouriteActions.decrement) {
      if (value > 0) {
        _modifyCount(value - 1);
      }
    } else {
      _modifyCount(value + 1);
    }
  }

  void _handleButtonPress() {
    if (widget.actionType == FavouriteActions.decrement) {
      _navigatePage(IncrementCount.routeName);
    } else {
      _navigatePage(DecrementCount.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        CartoonCountShower(
          title: widget.title,
          friendsCount: _parentCount ?? 0,
        ),
        const Spacer(),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () => _handleButtonPress(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.buttonTitle,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4.0),
                      const Icon(Icons.help, size: 22),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: Random(),
                onPressed: () => _handleActionPress(_parentCount ?? 0),
                child: widget.fabIcon,
                tooltip: widget.tooltip,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
