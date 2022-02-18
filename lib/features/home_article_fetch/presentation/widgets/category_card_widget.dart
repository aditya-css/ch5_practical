import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(right: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
    );
  }
}
