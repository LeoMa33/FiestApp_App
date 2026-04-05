import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilInformations extends ConsumerWidget {
  const ProfilInformations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(userSessionProvider).user!;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [CustomTitle(text: 'Informations')],
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.70,
            children: [
              IllustrationCard(
                imageSize: 50,
                s3ImageUrl: "${S3_enpoint}/asset/taille.webp",
                principalLabel: 'Taille',
                secondaryLabel: currentUser.height != null
                    ? '${currentUser.height! ~/ 100}m${currentUser.height! % 100}'
                    : '-',
              ),
              IllustrationCard(
                imageSize: 50,
                s3ImageUrl: "${S3_enpoint}/asset/poid.webp",
                principalLabel: 'Poids',
                secondaryLabel: currentUser.weight != null
                    ? '${currentUser.weight! / 1000} kg'
                    : '-',
              ),
              IllustrationCard(
                imageSize: 50,
                s3ImageUrl: "${S3_enpoint}/asset/age.webp",
                principalLabel: 'Age',
                secondaryLabel: '${currentUser.age} ans',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
