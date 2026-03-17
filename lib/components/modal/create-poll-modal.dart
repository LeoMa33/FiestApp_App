import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreatePollModal extends StatefulWidget {
  const CreatePollModal({super.key});

  @override
  State<CreatePollModal> createState() => _CreatePollModalState();
}

class _CreatePollModalState extends State<CreatePollModal> {
  final TextEditingController _titleController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _optionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    }
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
                "Ajout d'un sondage",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            DataTagInput(
              title: 'Question',
              placeholder: 'Question du sondage',
              inputType: InputType.text,
              controller: _titleController,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Options",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    for (int i = 0; i < _optionControllers.length; i++)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: DataTagInput(
                              title: 'Option ${i + 1}',
                              placeholder: "Valeur de l'option",
                              inputType: InputType.text,
                              controller: _optionControllers[i],
                            ),
                          ),
                          if (_optionControllers.length > 2)
                            CustomIconButton(
                              icon: FontAwesomeIcons.trash,
                              backgroundColor: Colors.white,
                              iconColor: Color(0xffE15B42),
                              onClick: () => _removeOption(i),
                            ),
                        ],
                      ),
                    GestureDetector(
                      onTap: _addOption,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xffE15B42,
                              ).withValues(alpha: 0.04),
                              // #E15B42 avec 4% d'opacité
                              offset: Offset(0, 4),
                              // X: 0, Y: 4
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: const Color(0xffE15B42),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: 'Ajouter',
                  icon: FontAwesomeIcons.arrowRight,
                  onPressed: () {
                    // TODO : soumettre
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
