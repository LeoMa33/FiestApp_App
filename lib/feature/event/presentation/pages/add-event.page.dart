import 'dart:io';

import 'package:fiestapp/components/add-event/add-event-datetime.component.dart';
import 'package:fiestapp/components/add-event/add-event-header.component.dart';
import 'package:fiestapp/components/add-event/address-block.component.dart';
import 'package:fiestapp/components/add-event/informations-block.component.dart';
import 'package:fiestapp/components/image-selector/image-selector.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/event/data/event_service.dart';
import 'package:fiestapp/feature/event/data/provider/event_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class AddEvent extends ConsumerWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventCreateProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F1F7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 20,
                    children: [
                      const AddEventHeader(),
                      Column(
                        spacing: 20,
                        children: [
                          ImageSelector(
                            title: "Sélectionnez une image",
                            height: 130,
                            onImageSelect: (XFile? image) async {
                              if (image != null) {
                                final webpImage = await convertToWebP(
                                  File(image.path),
                                );
                                ref
                                    .read(eventCreateProvider.notifier)
                                    .updateImage(webpImage);
                              } else {
                                ref
                                    .read(eventCreateProvider.notifier)
                                    .updateImage(null);
                              }
                            },
                          ),
                          const AddEventDateTime(),
                          const AddEvenInformationsBlock(),
                          const AddEventAdressBlock(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.isLoading)
                    const CircularProgressIndicator()
                  else
                    CustomButton(
                      label: "Créer l'évènement",
                      icon: FontAwesomeIcons.arrowRight,
                      onPressed: () => _submitForm(ref, context),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm(WidgetRef ref, BuildContext context) async {
    final state = ref.read(eventCreateProvider);

    if (!state.isValid) {
      _showError("Veuillez remplir tous les champs obligatoires", context);
      return;
    }

    ref.read(eventCreateProvider.notifier).setLoading(true);

    try {
      final apiClient = ref.read(apiClientProvider);
      await EventService.create(apiClient: apiClient, dto: state.toDto());

      ref.read(eventCreateProvider.notifier).reset();

      if (context.mounted) {
        context.goNamed(AppRoute.home.name);
      }
    } catch (e) {
      if (context.mounted) {
        _showError("Une erreur est survenue lors de la création", context);
      }
    } finally {
      ref.read(eventCreateProvider.notifier).setLoading(false);
    }
  }

  Future<XFile?> convertToWebP(File originalFile) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final targetPath = '${tempDir.path}/image_$timestamp.webp';

      return await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        targetPath,
        format: CompressFormat.webp,
        quality: 80,
      );
    } catch (e) {
      return XFile(originalFile.path); // Fallback to original
    }
  }

  void _showError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
