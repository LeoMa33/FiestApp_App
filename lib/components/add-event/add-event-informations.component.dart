import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEvenInformations extends ConsumerStatefulWidget {
  const AddEvenInformations({super.key});

  @override
  ConsumerState<AddEvenInformations> createState() =>
      _AddEvenInformationsState();
}

class _AddEvenInformationsState extends ConsumerState<AddEvenInformations> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(eventCreateProvider);
    _titleController = TextEditingController(text: state.name);
    _descriptionController = TextEditingController(text: state.description);
  }

  @override
  void dispose() {
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
          onChanged: (value) =>
              ref.read(eventCreateProvider.notifier).updateName(value),
        ),
        DataTagInput(
          title: "Description de l'événement",
          iconColor: Color(0xffE15B42),
          placeholder: "Entrez la description",
          inputType: InputType.text,
          controller: _descriptionController,
          onChanged: (value) =>
              ref.read(eventCreateProvider.notifier).updateDescription(value),
        ),
      ],
    );
  }
}
