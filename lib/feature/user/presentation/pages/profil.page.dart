import 'package:fiestapp/components/page-switcher/page-switcher.component.dart';
import 'package:fiestapp/components/profil/profil-events.component.dart';
import 'package:fiestapp/components/profil/profil-header.component.dart';
import 'package:fiestapp/components/profil/profil-informations.component.dart';
import 'package:fiestapp/provider/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:openapi/openapi.dart';


class Profil extends ConsumerStatefulWidget {
  const Profil({super.key});

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends ConsumerState<Profil> {
  int currentPage = 0;

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xffF4F1F7),
        body: Column(
          spacing: 15,
          children: [
            Column(
              spacing: 50,
              children: [
                ProfilHeader(allowEdit: currentPage == 0),
                Skeletonizer(
                  enabled: currentUser == null,
                  child: Column(
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 2,
                        children: [
                          if (currentUser != null)
                            FaIcon(
                              currentUser.gender == 'female'
                                  ? FontAwesomeIcons.venus
                                  : FontAwesomeIcons.mars,
                              size: 16,
                              color: Color(
                                currentUser.gender == 'female'
                                    ? 0xffFB8257
                                    : 0xff87D5C8,
                              ),
                            ),
                          Text(
                            currentUser?.username ?? BoneMock.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        formatAlcoholConsumption(
                              currentUser?.alcoholConsumption,
                            ) ??
                            BoneMock.name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: currentPage == 0
                      ? ProfilInformations()
                      : ProfilEvenements(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: PageSwitcher(
              onPageChanged: changePage,
              currentPage: 0,
              firstPage: 'Informations',
              secondPage: 'Évènements',
            ),
          ),
        ),
      ),
    );
  }

  String? formatAlcoholConsumption(UserAlcoholConsumptionEnum? alcoholConsumption) {
    switch (alcoholConsumption) {
      case UserAlcoholConsumptionEnum.occasional:
        return "Occasionnel";
      case UserAlcoholConsumptionEnum.regular:
        return "Régulier";
      case UserAlcoholConsumptionEnum.veteran:
        return "Aguerri";
      default:
        return "Valeur non reconnu <PageProfil line 123>";
    }
  }
}
