import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEvenInformations extends ConsumerStatefulWidget {
  const AddEvenInformations({super.key});

  @override
  ConsumerState<AddEvenInformations> createState() =>
      _AddEvenInformationsState();
}

class _AddEvenInformationsState extends ConsumerState<AddEvenInformations> {
  // Déclaration des controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialisation des controllers
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // Libération de la mémoire
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        DataTagInput(
          title: "Titre de l'événement",
          placeholder: "Entrez le titre",
          inputType: InputType.text,
          controller: _titleController,
          onChanged: (value) => print("Titre: $value"),
        ),
        DataTagInput(
          title: "Description de l'événement",
          iconColor: Color(0xffE15B42),
          placeholder: "Entrez la description",
          inputType: InputType.text,
          controller: _descriptionController,
          onChanged: (value) => print("Description: $value"),
        ),
      ],
    );
  }
}
