import 'package:ch5_practical/core/widgets/shimmer_widgets/shimmer_effect_widget.dart';
import 'package:flutter/material.dart';

class CategoryLoadingShimmer extends StatelessWidget {
  const CategoryLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerEffect(
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 16.0,
              ),
              child: Container(color: Colors.white),
            ),
          ),
          ShimmerEffect(
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 16.0,
              ),
              child: Container(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
