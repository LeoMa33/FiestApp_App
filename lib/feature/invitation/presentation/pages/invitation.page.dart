import 'package:fiestapp/components/details/details-header.component.dart';
import 'package:fiestapp/components/details/event-data-with-map.component.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
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
    // Mock de l'event
    final mockEvent = Event(
      guid: widget.id,
      title: 'Soirée Mock',
      description: 'Invitation reçue !',
      location: 'Paris, France',
      latitute: 48.8566,
      longitude: 2.3522,
      date: DateTime.now().millisecondsSinceEpoch,
      organizer: User(
        userGuid: 'user-1',
        username: 'Léo',
        gender: 'male',
        age: 25,
        height: 180,
        weight: 75,
        alcoholConsumption: 'casual',
        ppLink: null,
      ),
      participants: [],
      expenses: [],
    );

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F1F7),
        body: FutureBuilder<Event>(
          future: Future.delayed(const Duration(seconds: 1), () => mockEvent),
          builder: (context, snapshot) {
            final isLoading = snapshot.connectionState == ConnectionState.waiting;
            final event = snapshot.data ?? mockEvent;

            return Skeletonizer(
              enabled: isLoading,
              child: Column(
                spacing: 10,
                children: [
                  if (!isMapExpanded) DetailsHeader(height: MediaQuery.sizeOf(context).height / 3),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: EventDetailsWithMap(isMapExpanded: isMapExpanded, onExpandToggle: ExpandMap, event: event),
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
