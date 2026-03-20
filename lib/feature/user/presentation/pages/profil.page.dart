import 'package:fiestapp/components/page-switcher/page-switcher.component.dart';
import 'package:fiestapp/components/profil/profil-events.component.dart';
import 'package:fiestapp/components/profil/profil-header.component.dart';
import 'package:fiestapp/components/profil/profil-informations.component.dart';
import 'package:fiestapp/feature/estimation/domain/enum/estimation_enum.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profil extends ConsumerStatefulWidget {
  const Profil({super.key});

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends ConsumerState<Profil> {
  int currentPage = 0;

  // Mock du user
  final User? currentUser = User(
    userGuid: 'user-1',
    username: 'Léo',
    gender: Gender.man,
    age: 25,
    height: 180,
    weight: 75,
    alcoholConsumption: 'casual',
    ppLink: null,
  );

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                              currentUser!.gender == 'female'
                                  ? FontAwesomeIcons.venus
                                  : FontAwesomeIcons.mars,
                              size: 16,
                              color: Color(
                                currentUser!.gender == 'female'
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
                              AlcoholConsumption.fromString(
                                currentUser?.alcoholConsumption ?? '',
                              ),
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
                      : ProfilEvenements(currentUser: currentUser, events: []),
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
              currentPage: currentPage,
              firstPage: 'Informations',
              secondPage: 'Évènements',
            ),
          ),
        ),
      ),
    );
  }

  String? formatAlcoholConsumption(AlcoholConsumption? alcoholConsumption) {
    switch (alcoholConsumption) {
      case AlcoholConsumption.casual:
        return "Occasionnel";
      case AlcoholConsumption.regular:
        return "Régulier";
      case AlcoholConsumption.seasoned:
        return "Aguerri";
      case AlcoholConsumption.never:
        return "Jamais";
      default:
        return "Valeur non reconnue";
    }
  }
}
