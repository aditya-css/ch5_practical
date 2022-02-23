import 'package:ch5_practical/core/utilities.dart';
import 'package:flutter/material.dart';

class CartoonFaceImage extends StatelessWidget {
  const CartoonFaceImage({Key? key}) : super(key: key);

  AssetImage get image => AssetImage(cartoonSrc);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      cartoonSrc,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
    );
  }
}
