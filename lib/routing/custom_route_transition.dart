import 'package:flutter/material.dart';

class MyRouteTransition extends PageRouteBuilder {
  final Widget page;

  MyRouteTransition({required this.page})
      : super(
          pageBuilder: (_, __, ___) {
            return page;
          },
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
