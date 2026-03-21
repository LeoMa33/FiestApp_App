import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/next_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DismissibleEventList extends ConsumerWidget {
  DismissibleEventList({super.key});

  final List<EventDto> events = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (events.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      height: 237,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (events.length > 1)
            Positioned(
              top: 15,
              right: 0,
              left: 0,
              child: Transform.scale(
                scale: 0.95,
                child: NextEventCard(event: events[1]),
              ),
            ),
          Dismissible(
            key: UniqueKey(),
            direction: events.length > 1
                ? DismissDirection.horizontal
                : DismissDirection.none,
            onDismissed: (direction) {
              // TODO Système de changement de card
            },
            child: NextEventCard(event: events[0]),
          ),
        ],
      ),
    );
  }
}
