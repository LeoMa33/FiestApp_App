import 'package:fiestapp/components/register/register-form.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterInformationsBlock extends ConsumerStatefulWidget {
  const RegisterInformationsBlock({super.key});

  @override
  ConsumerState<RegisterInformationsBlock> createState() =>
      _RegisterInformationsBlockState();
}

class _RegisterInformationsBlockState
    extends ConsumerState<RegisterInformationsBlock> {
  // Déclaration des controllers

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(text: "Informations"),
          Expanded(child: RegisterForm()),
        ],
      ),
    );
  }
}
