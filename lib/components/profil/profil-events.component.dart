import 'package:fiestapp/components/custom-card/you-participate/you-participate-card.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilEvenements extends ConsumerWidget {
  final List<Event> events;
  final User? currentUser;

  const ProfilEvenements({super.key, required this.events, required this.currentUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredEvents = events.where((event) => event.organizer.userGuid == currentUser?.userGuid).toList();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [CustomTitle(text: 'Vos évènements')],
          ),
          if (filteredEvents.isEmpty)
            const Expanded(child: Center(child: Text("Vous n'avez pas encore créé d'évènements")))
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: filteredEvents.map((event) => YouParticipateCard(event: event)).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
