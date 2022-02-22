import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key? key,
    this.desc,
    this.head = 'SORRY',
    this.title = 'Failed to retrieve data.',
  }) : super(key: key);

  final String? head, title, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                head!,
                style: const TextStyle(
                  color: Colors.black12,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const Icon(
                Icons.info,
                color: Colors.black12,
                size: 32,
              ),
            ],
          ),
        ),
        Text(
          title!,
          softWrap: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        if (desc != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              desc!,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
