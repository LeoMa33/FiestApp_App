import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddEventHeader extends ConsumerWidget {
  const AddEventHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bouton retour à gauche
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const FaIcon(FontAwesomeIcons.arrowLeft),
            ),
          ),
          // Titre centré
          const Center(child: CustomTitle(text: "Création d'un évenement")),
        ],
      ),
    );
  }
}
