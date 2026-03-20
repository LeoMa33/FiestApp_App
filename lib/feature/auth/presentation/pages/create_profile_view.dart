import 'dart:io';

import 'package:fiestapp/components/image-selector/image-selector.component.dart';
import 'package:fiestapp/components/register/header.component.dart';
import 'package:fiestapp/components/register/informations-block.component.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_create_state.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:fiestapp/feature/user/data/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class CreateProfileView extends ConsumerStatefulWidget {
  const CreateProfileView({super.key});

  @override
  ConsumerState<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends ConsumerState<CreateProfileView> {
  bool _isLoading = false;

  Future<void> _createProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final apiClient = ref.read(apiClientProvider);
      final userState = ref.read(userCreateProvider);
      final dto = userState.toDto();

      final user = await UserService.create(apiClient: apiClient, dto: dto);

      ref.read(userSessionProvider.notifier).setUser(user);

      if (mounted) {
        context.goNamed(AppRoute.home.name);
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la création du profil')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<File?> _processImage(XFile xFile) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String targetPath = '${tempDir.path}/profile_$timestamp.webp';

      var result = await FlutterImageCompress.compressAndGetFile(
        xFile.path,
        targetPath,
        format: CompressFormat.webp,
        quality: 80,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      print('Erreur compression: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F1F7),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: RegisterHeader(),
                  ),
                  ImageSelector(
                    title: "Sélectionnez une image",
                    height: 130,
                    onImageSelect: (XFile? image) async {
                      if (image != null) {
                        final processedFile = await _processImage(image);
                        ref
                            .read(userCreateProvider.notifier)
                            .updateProfilePicture(processedFile);
                      }
                    },
                  ),
                  const Expanded(child: RegisterInformationsBlock()),
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
                    isLoading: _isLoading,
                    onPressed: _isLoading ? null : _createProfile,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
