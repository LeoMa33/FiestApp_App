import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/components/organisation/organisation-bloc.component.dart';
import 'package:fiestapp/core/common_widgets/page_switcher/page-switcher.component.dart';
import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/location_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Details extends ConsumerStatefulWidget {
  const Details({super.key, required this.id});

  final String id;

  @override
  DetailState createState() => DetailState();
}

class DetailState extends ConsumerState<Details> {
  bool isMapExpanded = false;
  int currentPage = 0;

  // TODO Get l'event par son id (widget.id)
  final EventDto mockEvent = EventDto(
    name: '',
    id: '',
    description: '',
    date: DateTime.now(),
    address: '',
    location: LocationDto(lat: 0, long: 0),
    creator: UserLightDto(id: '', name: ''),
    participants: [],
    estimation: EstimationDto(beer: 3, pizza: 3, softDrink: 3),
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
