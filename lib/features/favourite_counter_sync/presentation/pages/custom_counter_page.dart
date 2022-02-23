import 'dart:math' show Random;

import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/widgets/cartoon_count_shower_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({
    Key? key,
    required this.actionType,
    required this.title,
    required this.buttonTitle,
    required this.tooltip,
    required this.fabIcon,
  }) : super(key: key);

  final String tooltip, buttonTitle, title;
  final CounterActions actionType;
  final Icon fabIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        CartoonCountShower(title),
        const Spacer(),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () =>
                      Provider.of<CounterStore>(context, listen: false)
                          .handlePageChange(actionType),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        buttonTitle,
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
                onPressed: () =>
                    Provider.of<CounterStore>(context, listen: false)
                        .updateCount(actionType),
                child: fabIcon,
                tooltip: tooltip,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
