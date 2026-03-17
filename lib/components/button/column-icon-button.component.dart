import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColumnIconButton extends StatelessWidget {
  const ColumnIconButton({
    super.key,
    this.color = const Color(0xffE15B42),
    this.textColor = Colors.white,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Color color;
  final Color textColor;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: textColor),
              Text(label, style: TextStyle(color: textColor, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
