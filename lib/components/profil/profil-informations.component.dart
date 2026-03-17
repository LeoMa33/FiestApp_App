import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilInformations extends ConsumerWidget {
  const ProfilInformations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [CustomTitle(text: 'Informations')],
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
                s3ImageUrl: "${S3_enpoint}asset/taille.webp",
                principalLabel: 'Taille',
                secondaryLabel: currentUser != null
                    ? '${currentUser.height ~/ 100}m${currentUser.height % 100}'
                    : BoneMock.name,
              ),
              IllustrationCard(
                imageSize: 50,
                s3ImageUrl: "${S3_enpoint}asset/poid.webp",
                principalLabel: 'Poids',
                secondaryLabel: currentUser != null
                    ? '${currentUser.weight} kg'
                    : BoneMock.name,
              ),
              IllustrationCard(
                imageSize: 50,
                s3ImageUrl: "${S3_enpoint}asset/age.webp",
                principalLabel: 'Age',
                secondaryLabel: currentUser != null
                    ? '${currentUser.age} ans'
                    : BoneMock.name,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
