import 'dart:math' show pi;

import 'package:flutter/material.dart';

import '../utilities.dart';

class CartoonCountShower extends StatefulWidget {
  const CartoonCountShower({
    Key? key,
    required this.title,
    required this.friendsCount,
  }) : super(key: key);

  final String title;
  final int friendsCount;

  @override
  State<CartoonCountShower> createState() => _CartoonCountShowerState();
}

class _CartoonCountShowerState extends State<CartoonCountShower> {
  double get _faceSize => 200;
  double get _handSize => 50;
  Matrix4 get _verticalTransform => Matrix4.rotationY((-2) * pi / 2);

  Image get _cartoonFace => Image.asset(
        cartoonSrc,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
        height: _faceSize,
        width: _faceSize,
      );

  Image get _cartoonHand => Image.asset(
        cartoonHandSrc,
        fit: BoxFit.contain,
        height: _handSize,
        width: _handSize,
      );

  @override
  void didChangeDependencies() {
    precacheImage(
      _cartoonFace.image,
      context,
    );
    precacheImage(
      _cartoonHand.image,
      context,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _cartoonFace,
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 22.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    widget.friendsCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 20,
                child: _cartoonHand,
              ),
              Positioned(
                right: -45,
                bottom: 20,
                child: Transform(
                  transform: _verticalTransform,
                  child: _cartoonHand,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
