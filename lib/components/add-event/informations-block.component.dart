import 'package:fiestapp/components/add-event/add-event-informations.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEvenInformationsBlock extends ConsumerStatefulWidget {
  const AddEvenInformationsBlock({super.key});

  @override
  ConsumerState<AddEvenInformationsBlock> createState() =>
      _AddEvenInformationsBlockState();
}

class _AddEvenInformationsBlockState
    extends ConsumerState<AddEvenInformationsBlock> {
  // Déclaration des controllers

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(text: "Informations"),
        AddEvenInformations(),
      ],
    );
  }
}
