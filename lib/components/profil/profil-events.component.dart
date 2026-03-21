import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/event_card.dart';
import 'package:flutter/material.dart';

class ProfilEvenements extends StatelessWidget {
  final List<EventDto> events;

  const ProfilEvenements({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [CustomTitle(text: 'Vos évènements')],
          ),
          if (events.isEmpty)
            const Expanded(
              child: Center(
                child: Text("Vous n'avez pas encore créé d'évènements"),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: events
                      .map((event) => EventCard(event: event))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
