import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.controller,
    this.onChanged,
    this.backgroundColor,
    this.title = "",
    this.unit = "u",
  });

  final int min;
  final int max;
  final int value;
  final TextEditingController controller;
  final Color? backgroundColor;
  final String title;
  final String unit;

  final ValueChanged<int>? onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late int _sliderValue = widget.value;

  @override
  void initState() {
    super.initState();
    widget.controller.text = _sliderValue.toString();
    _sliderValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE15B42).withValues(alpha: 0.04),
            // #E15B42 avec 4% d'opacité
            offset: Offset(0, 4),
            // X: 0, Y: 4
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xffE15B42),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$_sliderValue ${widget.unit}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            child: Slider(
              activeColor: Color(0xffE15B42),
              value: _sliderValue.toDouble(),
              min: widget.min.toDouble(),
              max: widget.max.toDouble(),
              divisions: widget.max - widget.min,
              thumbColor: Color(0xffE15B42),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value.round();
                });
                widget.onChanged?.call(_sliderValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
