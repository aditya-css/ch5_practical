import 'dart:math' show pi;

import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/widgets/cartoon_face_image.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/widgets/cartoon_hand_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CartoonCountShower extends StatefulWidget {
  const CartoonCountShower(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<CartoonCountShower> createState() => _CartoonCountShowerState();
}

class _CartoonCountShowerState extends State<CartoonCountShower> {
  double get _boardHeight => MediaQuery.of(context).size.height * 0.2;

  Matrix4 get _verticalTransform => Matrix4.rotationY((-2) * pi / 2);

  @override
  void didChangeDependencies() {
    precacheImage(
      const CartoonFaceImage().image,
      context,
    );
    precacheImage(
      const CartoonHandImage().image,
      context,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
            const CartoonFaceImage(),
            Stack(
              children: [
                Container(
                  height: _boardHeight,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 22.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Observer(
                      builder: (_) => Text(
                        Provider.of<CounterStore>(context).count.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 5,
                  bottom: 20,
                  child: CartoonHandImage(),
                ),
                Positioned(
                  right: -45,
                  bottom: 20,
                  child: Transform(
                    transform: _verticalTransform,
                    child: const CartoonHandImage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
