import 'dart:io';

import 'package:fiestapp/components/add-event/add-event-datetime.component.dart';
import 'package:fiestapp/components/add-event/add-event-header.component.dart';
import 'package:fiestapp/components/add-event/address-block.component.dart';
import 'package:fiestapp/components/add-event/informations-block.component.dart';
import 'package:fiestapp/components/image-selector/image-selector.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEvent extends ConsumerWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xffF4F1F7),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 20,
                children: [
                  AddEventHeader(),
                  Column(
                    spacing: 20,
                    children: [
                      ImageSelector(title: "Sélectionnez une image", height: 130, onImageSelect: (XFile? image) {}),
                      AddEventDateTime(),
                      AddEvenInformationsBlock(),
                      AddEventAdressBlock(),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    label: "Créer l'évènement",
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: () => {_submitForm(ref, context), ref.read(routerProvider).pop()},
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
    final prefs = await SharedPreferences.getInstance();
    final String monId = prefs.getString('currentId') ?? '';
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }
}
