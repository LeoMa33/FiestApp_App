import 'dart:io';

import 'package:fiestapp/api/auth.service.dart';
import 'package:fiestapp/components/image-selector/image-selector.component.dart';
import 'package:fiestapp/components/register/header.component.dart';
import 'package:fiestapp/components/register/informations-block.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:fiestapp/provider/auth.provider.dart';
import 'package:fiestapp/provider/form/register-form.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/openapi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xffF4F1F7),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: RegisterHeader(),
                  ),
                  ImageSelector(
                    title: "Sélectionnez une image",
                    height: 130,
                    onImageSelect: (XFile? image) => {
                      ref
                          .read(registerFormProvider.notifier)
                          .updateSelectedFile(image),
                    },
                  ),
                  Expanded(child: RegisterInformationsBlock()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    label: "Créer le compte",
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: () {
                      _submitForm(ref, context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm(WidgetRef ref, context) async {
    final registerForm = ref.watch(registerFormProvider);

    final name = registerForm.username;
    final age = registerForm.age;
    final gender = registerForm.gender;
    final weight = registerForm.weight;
    final height = registerForm.height;
    final alcoholConsumption = registerForm.alcoholConsumption;

    final image = ref.read(registerFormProvider.notifier).selectedFile;

    if (name.isEmpty) return _showError("Le nom est requis", context);
    if (gender == UserGenderEnum.unknownDefaultOpenApi)
      return _showError("Le genre est requis", context);
    if (alcoholConsumption == UserAlcoholConsumptionEnum.unknownDefaultOpenApi)
      return _showError(
        "Le niveau de consommation d'alcool est requis",
        context,
      );

    print("Formulaire soumis avec :");
    print("Nom : $name");
    print("Âge : $age");
    print("Genre : $gender");
    print("Poids : $weight kg");
    print("Taille : $height cm");
    print("Alcool : $alcoholConsumption");
    print("Image: ${image?.name}");

    XFile? webpFile;
    if (image != null) {
      webpFile = await convertToWebP(File(image.path));
    }

    final response = await AuthService.register(
      registerForm.rebuild(
        (b) => b
          ..alcoholConsumption = UserAlcoholConsumptionEnum.regular
          ..gender = UserGenderEnum.male,
      ),
      webpFile == null ? null : File(webpFile.path),
    );

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentId', response.data!.user.guid);
      await prefs.setString('token', response.data!.accessToken);

      ref.read(authProvider.notifier).state = true;
      //ref.read(routerProvider).pushReplacement(AppRoute.home.path);
    }
  }

  Future<XFile?> convertToWebP(File originalFile) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      return await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        '${tempDir.path}/image_${timestamp}.webp',
        format: CompressFormat.webp,
        quality: 80,
        keepExif: false,
      );
    } catch (e) {
      print('Erreur conversion WebP: $e');
      rethrow;
    }
  }

  void _showError(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
