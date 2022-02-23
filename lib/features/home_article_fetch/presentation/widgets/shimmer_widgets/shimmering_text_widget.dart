import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/shimmer_effect_widget.dart';
import 'package:flutter/material.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  height: 8,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
