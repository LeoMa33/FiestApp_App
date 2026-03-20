import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/components/page-switcher/page-switcher.component.dart';
import 'package:fiestapp/feature/estimation/domain/enum/gender_enum.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/organisation/organisation-bloc.component.dart';

class Details extends ConsumerStatefulWidget {
  const Details({super.key});

  @override
  DetailState createState() => DetailState();
}

class DetailState extends ConsumerState<Details> {
  bool isMapExpanded = false;
  int currentPage = 0;

  // Mock de l'événement
  final Event mockEvent = Event(
    guid: '1',
    title: 'Soirée Mock',
    description: 'Une description détaillée de cette super soirée de test.',
    location: 'Paris, France',
    latitute: 48.8566,
    longitude: 2.3522,
    date: DateTime.now().millisecondsSinceEpoch,
    organizer: User(
      userGuid: 'user-1',
      username: 'Léo',
      gender: Gender.man,
      age: 25,
      height: 180,
      weight: 75,
      alcoholConsumption: 'casual',
      ppLink: null,
    ),
    participants: [],
    expenses: [],
  );

  void expandMap() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: PageSwitcher(
            onPageChanged: changePage,
            currentPage: currentPage,
            firstPage: 'Informations',
            secondPage: 'Organisation',
          ),
        ),
        backgroundColor: const Color(0xffF4F1F7),
        body: Column(
          spacing: 10,
          children: [
            if (!isMapExpanded)
              DetailsHeader(
                height:
                    MediaQuery.sizeOf(context).height /
                    (currentPage == 0 ? 3 : 3.8),
              ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: currentPage == 1
                      ? const Organisation()
                      : EventDetailsWithMap(
                          isMapExpanded: isMapExpanded,
                          onExpandToggle: expandMap,
                          event: mockEvent,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
