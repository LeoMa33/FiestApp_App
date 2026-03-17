import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/components/input/select-text-input.component.dart';
import 'package:fiestapp/components/input/slider.component.dart';
import 'package:fiestapp/components/register/gender.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/provider/form/register-form.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/openapi.dart';

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
    // Lier chaque controller au provider
    _heightController.addListener(() {
      final value = int.tryParse(_heightController.text);
      if (value != null) {
        ref.read(registerFormProvider.notifier).updateHeight(value);
      }
    });

    _weightController.addListener(() {
      final value = int.tryParse(_weightController.text);
      if (value != null) {
        ref.read(registerFormProvider.notifier).updateWeight(value);
      }
    });

    _genderController.addListener(() {
      switch (_genderController.text) {
        case 'Female':
          ref
              .read(registerFormProvider.notifier)
              .updateGender(UserGenderEnum.female);
        case 'Male':
          ref
              .read(registerFormProvider.notifier)
              .updateGender(UserGenderEnum.male);
      }
    });

    _nameController.addListener(() {
      ref
          .read(registerFormProvider.notifier)
          .updateUsername(_nameController.text);
    });

    _ageController.addListener(() {
      final value = int.tryParse(_ageController.text);
      if (value != null) {
        ref.read(registerFormProvider.notifier).updateAge(value);
      }
    });

    _alcoholConsumptionController.addListener(() {
      switch (_alcoholConsumptionController.text) {
        case 'occasional':
          ref
              .read(registerFormProvider.notifier)
              .updateAlcohol(UserAlcoholConsumptionEnum.occasional);
        case 'regular':
          ref
              .read(registerFormProvider.notifier)
              .updateAlcohol(UserAlcoholConsumptionEnum.regular);
        case 'veteran':
          ref
              .read(registerFormProvider.notifier)
              .updateAlcohol(UserAlcoholConsumptionEnum.veteran);
        case 'unknown_default_open_api':
          ref
              .read(registerFormProvider.notifier)
              .updateAlcohol(UserAlcoholConsumptionEnum.unknownDefaultOpenApi);
      }
    });
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
          MinimalEnumSelector<UserAlcoholConsumptionEnum>(
            width: MediaQuery.sizeOf(context).width * 0.6,
            title: "Quel buveur êtes-vous ?",
            value: UserAlcoholConsumptionEnum.occasional,
            values: UserAlcoholConsumptionEnum.values.toList(),
            controller: _alcoholConsumptionController,
            labelBuilder: (val) {
              switch (val) {
                case UserAlcoholConsumptionEnum.occasional:
                  return "Occasionnel";
                case UserAlcoholConsumptionEnum.regular:
                  return "Régulier";
                case UserAlcoholConsumptionEnum.veteran:
                  return "Aguerri";
                case UserAlcoholConsumptionEnum.unknownDefaultOpenApi:
                  return 'Aucune valeur';
              }
              return '';
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
