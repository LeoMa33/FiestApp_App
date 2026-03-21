import 'package:fiestapp/components/button/icon-button.component.dart';
import 'package:fiestapp/components/button/profil-image-button.component.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/core/routing/route_enum.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WelcomeHeader extends ConsumerWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userSessionProvider).user;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Text(
              user?.name ?? 'Utilisateur',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            CustomIconButton(
              icon: FontAwesomeIcons.bell,
              iconColor: Colors.black,
              backgroundColor: Colors.white,
              onClick: () {
                context.go(AppRoute.notification.path);
              },
            ),
            ProfilImageButton(
              imagePath: S3Service.getUserImage(user?.imageUrl),
              onClick: () {
                context.go(AppRoute.profil.path);
              },
            ),
          ],
        ),
      ],
    );
  }
}
