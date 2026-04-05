import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/components/input/select-text-input.component.dart';
import 'package:fiestapp/components/input/slider.component.dart';
import 'package:fiestapp/components/register/gender.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _nameController;
  late TextEditingController _birthdayController;
  late TextEditingController _alcoholConsumptionController;

  @override
  void initState() {
    super.initState();

    final initialState = ref.read(userCreateProvider);

    _heightController = TextEditingController(
      text: initialState.height.toString(),
    );
    _weightController = TextEditingController(
      text: initialState.weight.toString(),
    );
    _nameController = TextEditingController(text: initialState.name);
    _birthdayController = TextEditingController(
      text: initialState.birthday != null
          ? DateFormat('dd/MM/yyyy').format(initialState.birthday!)
          : '',
    );
    _alcoholConsumptionController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    _alcoholConsumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userCreateProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Row(
            spacing: 20,
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
              Expanded(
                flex: 2,
                child: DataTagInput(
                  title: "Date de naissance",
                  placeholder: "01/01/2000",
                  inputType: InputType.date,
                  controller: _birthdayController,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final date = DateFormat('dd/MM/yyyy').parse(value);
                      ref
                          .read(userCreateProvider.notifier)
                          .updateBirthday(date);
                    }
                  },
                ),
              ),
            ],
          ),
          const GenderSelector(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Activer les estimations IA",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Switch(
                value: userState.isEstimationActive,
                activeColor: const Color(0xffE15B42),
                onChanged: (value) {
                  ref
                      .read(userCreateProvider.notifier)
                      .updateEstimationActive(value);
                },
              ),
            ],
          ),
          if (userState.isEstimationActive) ...[
            CustomSlider(
              title: "Quelle est votre taille ?",
              min: 120,
              max: 240,
              value: userState.height,
              unit: "cm",
              controller: _heightController,
              onChanged: (value) => ref
                  .read(userCreateProvider.notifier)
                  .updateHeight(value.toInt()),
            ),
            CustomSlider(
              title: "Quel est votre poids ?",
              min: 30,
              max: 120,
              value: userState.weight,
              unit: "kg",
              controller: _weightController,
              onChanged: (value) => ref
                  .read(userCreateProvider.notifier)
                  .updateWeight(value.toInt()),
            ),
            MinimalEnumSelector<AlcoholConsumption>(
              width: MediaQuery.sizeOf(context).width * 0.6,
              title: "Quel buveur êtes-vous ?",
              value: userState.alcoholConsumption,
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
        ],
      ),
    );
  }
}
