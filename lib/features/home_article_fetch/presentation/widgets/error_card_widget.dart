import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key, this.desc}) : super(key: key);

  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Row(
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
        ),
        const Text(
          'Failed to retrieve data.',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        if (desc != null)
          Text(
            desc!,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
      ],
    );
  }
}
