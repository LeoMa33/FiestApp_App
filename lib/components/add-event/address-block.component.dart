import 'package:fiestapp/components/add-event/add-event-adress.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEventAdressBlock extends ConsumerStatefulWidget {
  const AddEventAdressBlock({super.key});

  @override
  ConsumerState<AddEventAdressBlock> createState() =>
      _AddEventAdressBlockState();
}

class _AddEventAdressBlockState extends ConsumerState<AddEventAdressBlock> {
  // Déclaration des controllers

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(text: "Adresse"),
        AddEventAdress(),
      ],
    );
  }
}
