import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends ConsumerWidget {
  const CustomIconButton({
    super.key,
    this.size = 14.0,
    this.height = 44.0,
    this.width = 44.0,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onClick,
  });

  final IconData icon;
  final Color backgroundColor;
  final double size;
  final Color iconColor;
  final Function() onClick;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 44,
        width: 44,
        child: FaIcon(icon, color: iconColor, size: size),
      ),
    );
  }
}
