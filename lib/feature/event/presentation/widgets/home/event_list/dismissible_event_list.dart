import 'package:fiestapp/feature/event/data/provider/event_list_state.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/next_event_card.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DismissibleEventList extends ConsumerWidget {
  const DismissibleEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventListProvider);
    final userSession = ref.watch(userSessionProvider);

    final events = (eventState.events ?? []).where((event) {
      final isParticipant = event.participants.any(
        (p) => p.id == userSession.user?.id,
      );
      final isOwner = event.creator.id == userSession.user?.id;
      final isAfterNow = event.date.isAfter(
        DateTime.now().subtract(const Duration(minutes: 1)),
      );
      return (isParticipant || isOwner) && isAfterNow;
    }).toList();

    if (events.isEmpty) {
      return const SizedBox();
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
              if (events.length > 1) events.add(events.removeAt(0));
            },
            child: NextEventCard(event: events[0]),
          ),
        ],
      ),
    );
  }
}
