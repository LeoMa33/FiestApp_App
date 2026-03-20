import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderSelector extends ConsumerWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(userCreateProvider).gender;

    return Row(
      children: [
        Expanded(
          child: IllustrationCard(
            imageSize: 40,
            icon: FontAwesomeIcons.venus,
            iconColor: const Color(0xffFB8257),
            principalLabel: "Femme",
            secondaryLabel: 'Sexe',
            isSelected: selectedGender == Gender.woman,
            onClick: () => ref
                .read(userCreateProvider.notifier)
                .updateGender(Gender.woman),
            gradient: selectedGender == Gender.woman
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFB8257), Color(0xFFF8C16F)],
                  )
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: IllustrationCard(
            imageSize: 40,
            icon: FontAwesomeIcons.mars,
            iconColor: const Color(0xffFB8257),
            principalLabel: 'Homme',
            secondaryLabel: 'Sexe',
            isSelected: selectedGender == Gender.man,
            onClick: () =>
                ref.read(userCreateProvider.notifier).updateGender(Gender.man),
            gradient: selectedGender == Gender.man
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF87D5C8), Color(0xFFABC760)],
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
