import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/location_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Invitation extends ConsumerStatefulWidget {
  final String id;

  const Invitation({super.key, required this.id});

  @override
  InvitationState createState() => InvitationState();
}

class InvitationState extends ConsumerState<Invitation> {
  bool isMapExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  void ExpandMap() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F1F7),
        body: FutureBuilder<EventDto>(
          future: Future.delayed(const Duration(seconds: 1), () => mockEvent),
          builder: (context, snapshot) {
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            final event = snapshot.data ?? mockEvent;

            return Skeletonizer(
              enabled: isLoading,
              child: Column(
                spacing: 10,
                children: [
                  if (!isMapExpanded)
                    DetailsHeader(
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: EventDetailsWithMap(
                        isMapExpanded: isMapExpanded,
                        onExpandToggle: ExpandMap,
                        event: event,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
