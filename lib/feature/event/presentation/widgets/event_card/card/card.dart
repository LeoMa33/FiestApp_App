import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    this.click,
  });

  final Widget child;
  final double height;
  final double width;
  final VoidCallback? click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => click?.call(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0AE15B42),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
