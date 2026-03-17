import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateExpenseModal extends StatefulWidget {
  const CreateExpenseModal({super.key});

  @override
  State<CreateExpenseModal> createState() => _CreateExpenseModalState();
}

class _CreateExpenseModalState extends State<CreateExpenseModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
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
                "Ajout d'une dépense",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Nom de la dépense',
              placeholder: 'Dépense',
              inputType: InputType.text,
              controller: _nameController,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Expanded(
                  child: DataTagInput(
                    title: 'Coût',
                    placeholder: '0',
                    inputType: InputType.number,
                    controller: _costController,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.euroSign,
                  color: Color(0xffE15B42),
                  size: 20,
                ),
              ],
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
