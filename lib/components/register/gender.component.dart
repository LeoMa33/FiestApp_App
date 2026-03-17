import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender = "Female";

  void _selectGender(String gender) {
    setState(() {
      print(gender);
      selectedGender = gender;
      widget.controller.text = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IllustrationCard(
            imageSize: 40,
            icon: FontAwesomeIcons.venus,
            iconColor: const Color(0xffFB8257),
            principalLabel: "Femme",
            secondaryLabel: 'Sexe',
            isSelected: selectedGender == 'Female',
            onClick: () => _selectGender('Female'),
            gradient: selectedGender == 'Female'
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFB8257), Color(0xFFF8C16F)],
                  )
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: IllustrationCard(
            imageSize: 40,
            icon: FontAwesomeIcons.mars,
            iconColor: const Color(0xffFB8257),
            principalLabel: 'Homme',
            secondaryLabel: 'Sexe',
            isSelected: selectedGender == 'Male',
            onClick: () => _selectGender('Male'),
            gradient: selectedGender == 'Male'
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF87D5C8), Color(0xFFABC760)],
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
