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
            // #E15B42 avec 4% d'opacité
            offset: Offset(0, 4),
            // X: 0, Y: 4
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
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: imageSize,
              height: imageSize,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.image,
        color: Colors.grey,
        size: imageSize,
      );
    }
  }

  Widget _buildInputByType(BuildContext context) {
    switch (inputType) {
      case InputType.text:
        return TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: TextInputType.text,
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

      case InputType.number:
        return TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
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

      case InputType.date:
        return GestureDetector(
          onTap: enabled ? () => _selectDate(context) : null,
          child: Container(
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              onTap: () async {
                DateTime now = DateTime.now();
                DateTime? pickedDate = await showDatePicker(
                  locale: Locale('fr', 'FR'),
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: now.add(const Duration(days: 365 * 5)),
                );
                controller.value = TextEditingValue(
                  text: pickedDate != null
                      ? DateFormat(dateFormat).format(pickedDate)
                      : '',
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                // Supprime la bordure
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: placeholder,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        );

      case InputType.time:
        return GestureDetector(
          onTap: enabled ? () => _selectDate(context) : null,
          child: Container(
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedDate = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                controller.value = TextEditingValue(
                  text: pickedDate != null
                      ? DateFormat(timeFormat).format(
                          DateTime(0, 0, 0, pickedDate.hour, pickedDate.minute),
                        )
                      : '',
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                // Supprime la bordure
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: placeholder,
              ),
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
                  controller.text = (currentValue - 1).toString();
                  if (onChanged != null) onChanged!(controller.text);
                }
              },
              child: FaIcon(
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
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                controller.text = (currentValue + 1).toString();
                if (onChanged != null) onChanged!(controller.text);
              },
              child: FaIcon(
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
    final DateTime initialDate = _parseDate(controller.text) ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
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

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat(dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }
}

// Extension utile pour la validation
extension DataTagInputValidator on DataTagInput {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format d\'email invalide';
    }
    return null;
  }

  static String? validateNumber(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) return null;
    final number = double.tryParse(value);
    if (number == null) {
      return 'Veuillez entrer un nombre valide';
    }
    if (min != null && number < min) {
      return 'La valeur doit être supérieure ou égale à $min';
    }
    if (max != null && number > max) {
      return 'La valeur doit être inférieure ou égale à $max';
    }
    return null;
  }
}
