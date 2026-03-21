import 'package:flutter/material.dart';

class CardFooter extends StatelessWidget {
  const CardFooter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
      child: child,
    );
  }
}
