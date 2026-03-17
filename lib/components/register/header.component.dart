import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterHeader extends ConsumerWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Center(child: CustomTitle(text: "Création de votre profil")),
        ],
      ),
    );
  }
}
