import 'package:fiestapp/feature/event/presentation/widgets/event_card/event_card.dart';
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
    final events = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [...events.map((event) => EventCard(event: event))],
    );
  }
}
