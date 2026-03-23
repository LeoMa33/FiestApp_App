import 'package:fiestapp/feature/event/data/provider/event_list_state.dart';
import 'package:fiestapp/feature/event/presentation/widgets/event_card/event_card.dart';
import 'package:fiestapp/feature/user/data/provider/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventList extends ConsumerStatefulWidget {
  const EventList({super.key});

  @override
  ConsumerState<EventList> createState() => _EventListState();
}

class _EventListState extends ConsumerState<EventList> {
  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventListProvider);
    final userSession = ref.watch(userSessionProvider);

    final events = (eventState.events ?? []).where((event) {
      final isParticipant = event.participants.any(
        (p) => p.id == userSession.user?.id,
      );
      final isCreator = event.creator.id == userSession.user?.id;
      final isAfterNow = event.date.isAfter(DateTime.now());
      return (isParticipant || isCreator) && isAfterNow;
    }).toList();

    if (eventState.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [...events.map((event) => EventCard(event: event))],
    );
  }
}
