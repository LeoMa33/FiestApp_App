import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCard extends ConsumerWidget {
  const AddCard({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.onClick,
  });

  final double height;
  final double width;
  final double radius;
  final Function() onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
        height: height,
        width: width,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Color(0xffE15B42),
          size: 25,
        ),
      ),
    );
  }
}
