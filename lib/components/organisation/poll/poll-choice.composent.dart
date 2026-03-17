import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';

class PollChoice extends StatelessWidget {
  final String label;
  final double percentage;
  final PollChoiceStatus status;
  final VoidCallback onTap;

  const PollChoice({
    super.key,
    required this.label,
    required this.percentage,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = status == PollChoiceStatus.selected;
    final bool isValidated = status == PollChoiceStatus.validated;

    final background = isSelected || isValidated
        ? const LinearGradient(colors: [Color(0xffE15B42), Color(0xffF9B93A)])
        : null;

    final textColor = isSelected || isValidated ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          gradient: background,
          color: background == null ? Colors.white : null,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
            if (isValidated)
              Text(
                "${(percentage * 100).toStringAsFixed(0)}%",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
