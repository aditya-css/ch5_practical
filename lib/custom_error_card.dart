import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'SORRY',
              style: TextStyle(
                color: Colors.black12,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            Icon(
              Icons.info,
              color: Colors.black12,
              size: 32,
            ),
          ],
        ),
        const Text(
          'Failed to retrieve data.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
