import 'package:ch5_practical/core/utilities.dart';
import 'package:flutter/material.dart';

class CartoonHandImage extends StatelessWidget {
  const CartoonHandImage({Key? key}) : super(key: key);

  AssetImage get image => AssetImage(cartoonHandSrc);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      cartoonHandSrc,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      height: 50,
      width: 50,
    );
  }
}
