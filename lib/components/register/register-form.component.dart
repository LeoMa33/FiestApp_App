import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/components/input/select-text-input.component.dart';
import 'package:fiestapp/components/input/slider.component.dart';
import 'package:fiestapp/components/register/gender.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_create_state.dart';
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
  late TextEditingController _alcoholConsumptionController;

  @override
  void initState() {
    super.initState();

    final initialState = ref.read(userCreateProvider);

    _heightController = TextEditingController(
      text: (initialState.height * 100).toInt().toString(),
    );
    _weightController = TextEditingController(
      text: initialState.weight.toInt().toString(),
    );
    _nameController = TextEditingController(text: initialState.name);
    _ageController = TextEditingController(text: initialState.age.toString());
    _alcoholConsumptionController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    _ageController.dispose();
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
                  onChanged: (value) =>
                      ref.read(userCreateProvider.notifier).updateName(value),
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
                  onChanged: (value) {
                    final age = int.tryParse(value);
                    if (age != null) {
                      ref.read(userCreateProvider.notifier).updateAge(age);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const GenderSelector(),
          const SizedBox(height: 20),
          CustomSlider(
            title: "Quelle est votre taille ?",
            min: 120,
            max: 240,
            value: (ref.read(userCreateProvider).height * 100).toInt(),
            unit: "cm",
            controller: _heightController,
            onChanged: (value) => ref
                .read(userCreateProvider.notifier)
                .updateHeight(value.toDouble() / 100),
          ),
          const SizedBox(height: 20),
          CustomSlider(
            title: "Quel est votre poids ?",
            min: 30,
            max: 120,
            value: (ref.read(userCreateProvider).weight).toInt(),
            unit: "kg",
            controller: _weightController,
            onChanged: (value) => ref
                .read(userCreateProvider.notifier)
                .updateWeight(value.toDouble()),
          ),
          const SizedBox(height: 20),
          MinimalEnumSelector<AlcoholConsumption>(
            width: MediaQuery.sizeOf(context).width * 0.6,
            title: "Quel buveur êtes-vous ?",
            value: ref.watch(userCreateProvider).alcoholConsumption,
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
              if (newValue != null) {
                ref
                    .read(userCreateProvider.notifier)
                    .updateAlcoholConsumption(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
