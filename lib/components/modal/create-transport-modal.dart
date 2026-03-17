import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateTransportModal extends StatefulWidget {
  const CreateTransportModal({super.key});

  @override
  State<CreateTransportModal> createState() => _CreateTransportModalState();
}

class _CreateTransportModalState extends State<CreateTransportModal> {
  final TextEditingController _placesController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _placesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.95,
        minWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Center(
              child: Text(
                "Ajout d'un transport",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Places disponibles',
              placeholder: '0',
              inputType: InputType.counter,
              controller: _placesController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: 'Ajouter',
                  icon: FontAwesomeIcons.arrowRight,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
