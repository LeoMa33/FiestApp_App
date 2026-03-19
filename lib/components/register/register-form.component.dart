import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/components/input/select-text-input.component.dart';
import 'package:fiestapp/components/input/slider.component.dart';
import 'package:fiestapp/components/register/gender.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _fileController;
  late TextEditingController _alcoholConsumptionController;

  @override
  void initState() {
    super.initState();

    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _genderController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _fileController = TextEditingController();
    _alcoholConsumptionController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _fileController.dispose();
    _alcoholConsumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DataTagInput(
                  title: "Comment doit-on vous appeler ?",
                  placeholder: "Votre nom",
                  inputType: InputType.text,
                  controller: _nameController,
                  onChanged: (value) => print("Nom: $value"),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: DataTagInput(
                  title: "Quel âge avez-vous ?",
                  iconColor: const Color(0xffE15B42),
                  placeholder: "25",
                  inputType: InputType.number,
                  controller: _ageController,
                  onChanged: (value) => print("Âge: $value"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GenderSelector(controller: _genderController),
          const SizedBox(height: 20),
          CustomSlider(
            title: "Quelle est votre taille ?",
            min: 120,
            max: 240,
            value: 170,
            unit: "cm",
            controller: _heightController,
            onChanged: (value) => print("Taille: $value cm"),
          ),
          const SizedBox(height: 20),
          CustomSlider(
            title: "Quel est votre poids ?",
            min: 30,
            max: 120,
            value: 70,
            unit: "kg",
            controller: _weightController,
            onChanged: (value) => print("Poids: $value kg"),
          ),
          const SizedBox(height: 20),
          MinimalEnumSelector<AlcoholConsumption>(
            width: MediaQuery.sizeOf(context).width * 0.6,
            title: "Quel buveur êtes-vous ?",
            value: AlcoholConsumption.casual,
            values: AlcoholConsumption.values.toList(),
            controller: _alcoholConsumptionController,
            labelBuilder: (val) {
              switch (val) {
                case AlcoholConsumption.casual:
                  return "Occasionnel";
                case AlcoholConsumption.regular:
                  return "Régulier";
                case AlcoholConsumption.seasoned:
                  return "Aguerri";
                case AlcoholConsumption.never:
                  return 'Jamais';
              }
            },
            onChanged: (newValue) {
              print("Alcool sélectionné : $newValue");
            },
          ),
        ],
      ),
    );
  }
}
