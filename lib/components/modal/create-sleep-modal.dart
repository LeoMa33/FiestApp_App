import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateSleepModal extends StatefulWidget {
  const CreateSleepModal({super.key});

  @override
  State<CreateSleepModal> createState() => _CreateSleepModalState();
}

class _CreateSleepModalState extends State<CreateSleepModal> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _placesController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
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
                "Ajout d'un hébergement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Rue',
              placeholder: 'Entrer la rue',
              inputType: InputType.text,
              controller: _streetController,
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: DataTagInput(
                    title: 'Ville',
                    placeholder: 'Ville',
                    inputType: InputType.text,
                    controller: _cityController,
                  ),
                ),
                Expanded(
                  child: DataTagInput(
                    title: 'Code postal',
                    placeholder: 'Code postal',
                    inputType: InputType.number,
                    controller: _postalCodeController,
                  ),
                ),
              ],
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
                  onPressed: () {
                    // Exemple d'accès aux valeurs :
                    final rue = _streetController.text;
                    final ville = _cityController.text;
                    final codePostal = _postalCodeController.text;
                    final places = int.tryParse(_placesController.text) ?? 0;

                    // TODO : soumettre les données
                    print(
                      "Rue: $rue, Ville: $ville, CP: $codePostal, Places: $places",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
