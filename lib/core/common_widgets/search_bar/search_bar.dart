import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.icon,
    required this.placeholder,
    this.size = 22.0,
    this.iconColor = const Color(0xFF909090),
    this.placeholderColor = const Color(0xFF909090),
    this.height = 46.0,
  });

  final String placeholder;
  final IconData icon;
  final double size;
  final Color iconColor;
  final double height;
  final Color placeholderColor;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: placeholder,
      hintStyle: WidgetStateProperty.all(TextStyle(color: placeholderColor)),
      leading: FaIcon(icon, size: size, color: iconColor),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      constraints: BoxConstraints(minHeight: height, maxHeight: height),
    );
  }
}
