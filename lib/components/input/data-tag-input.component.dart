import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DataTagInput extends ConsumerWidget {
  const DataTagInput({
    super.key,
    required this.title,
    required this.placeholder,
    required this.inputType,
    required this.controller,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.s3ImageUrl,
    this.imageSize = 20,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.dateFormat = 'dd/MM/yyyy',
    this.timeFormat = 'HH:mm',
    this.firstDate,
    this.lastDate,
  });

  final String title;
  final String placeholder;
  final InputType inputType;
  final TextEditingController controller;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String? s3ImageUrl;
  final double imageSize;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;
  final String dateFormat;
  final String timeFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE15B42).withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        spacing: 10,
        children: [
          if (icon != null || s3ImageUrl != null) ...[
            Padding(padding: const EdgeInsets.all(10), child: _buildIcon()),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xffE15B42),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _buildInputByType(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return FaIcon(icon!, color: iconColor ?? Colors.black, size: imageSize);
    } else if (s3ImageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          s3ImageUrl!,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return FaIcon(
              FontAwesomeIcons.image,
              color: Colors.grey,
              size: imageSize,
            );
          },
        ),
      );
    }
    return FaIcon(FontAwesomeIcons.image, color: Colors.grey, size: imageSize);
  }

  Widget _buildInputByType(BuildContext context) {
    switch (inputType) {
      case InputType.date:
        return TextFormField(
          controller: controller,
          readOnly: true,
          enabled: enabled,
          onTap: enabled ? () => _selectDate(context) : null,
          decoration: InputDecoration.collapsed(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        );

      case InputType.time:
        return TextFormField(
          controller: controller,
          readOnly: true,
          enabled: enabled,
          onTap: enabled ? () => _selectTime(context) : null,
          decoration: InputDecoration.collapsed(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        );

      case InputType.number:
      case InputType.text:
        return TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: inputType == InputType.number
              ? const TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                )
              : TextInputType.text,
          onChanged: onChanged,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration.collapsed(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.normal,
            ),
          ),
        );

      case InputType.counter:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                if (currentValue > 0) {
                  final newValue = (currentValue - 1).toString();
                  controller.text = newValue;
                  onChanged?.call(newValue);
                }
              },
              child: const FaIcon(
                FontAwesomeIcons.minus,
                color: Color(0xffE15B42),
                size: 18,
              ),
            ),
            SizedBox(
              width: 50,
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller,
                enabled: enabled,
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: onChanged,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration.collapsed(hintText: placeholder),
              ),
            ),
            GestureDetector(
              onTap: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                final newValue = (currentValue + 1).toString();
                controller.text = newValue;
                onChanged?.call(newValue);
              },
              child: const FaIcon(
                FontAwesomeIcons.plus,
                color: Color(0xffE15B42),
                size: 18,
              ),
            ),
          ],
        );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _parseDate(controller.text) ?? now,
      firstDate: firstDate ?? now,
      lastDate: lastDate ?? now.add(const Duration(days: 365 * 5)),
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: const Color(0xffE15B42)),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat(dateFormat).format(pickedDate);
      controller.text = formattedDate;
      onChanged?.call(formattedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _parseTime(controller.text) ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: const Color(0xffE15B42)),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final formattedTime = DateFormat(timeFormat).format(dt);
      controller.text = formattedTime;
      onChanged?.call(formattedTime);
    }
  }

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat(dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  TimeOfDay? _parseTime(String timeString) {
    if (timeString.isEmpty) return null;
    try {
      final dt = DateFormat(timeFormat).parse(timeString);
      return TimeOfDay.fromDateTime(dt);
    } catch (e) {
      return null;
    }
  }
}
