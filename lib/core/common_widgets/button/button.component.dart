import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: onPressed == null ? Colors.grey : const Color(0xffE15B42),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
            FaIcon(icon, color: Colors.white, size: 15),
          ],
        ),
      ),
    );
  }
}
