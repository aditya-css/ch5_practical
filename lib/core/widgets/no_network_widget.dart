import 'package:ch5_practical/core/image_paths.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 150,
            maxWidth: 150,
          ),
          child: Image.asset(
            ImagePath.noWifiImageSrc,
            fit: BoxFit.contain,
          ),
        ),
        const Text(
          'No Internet Connection Detected.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
