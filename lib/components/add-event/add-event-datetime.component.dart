import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddEventDateTime extends ConsumerStatefulWidget {
  const AddEventDateTime({super.key});

  @override
  ConsumerState<AddEventDateTime> createState() => _AddEventDateTimeState();
}

class _AddEventDateTimeState extends ConsumerState<AddEventDateTime> {
  // Déclaration des controllers
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    // Initialisation des controllers
    _dateController = TextEditingController();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    // Libération de la mémoire
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          flex: 4,
          child: DataTagInput(
            title: "Date",
            iconColor: Color(0xffE15B42),
            placeholder: "01/01/2025",
            inputType: InputType.date,
            controller: _dateController,
            icon: FontAwesomeIcons.calendar,
            onChanged: (value) => print("Date sélectionnée: $value"),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ),
        ),
        Expanded(
          flex: 3,
          child: DataTagInput(
            title: "Heure",
            placeholder: "0:00",
            inputType: InputType.time,
            controller: _timeController,
            icon: FontAwesomeIcons.clock,
            iconColor: Color(0xffE15B42),
            onChanged: (value) => print("Date sélectionnée: $value"),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ),
        ),
      ],
    );
  }
}
