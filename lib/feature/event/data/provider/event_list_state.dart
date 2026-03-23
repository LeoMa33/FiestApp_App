import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListState {
  final List<EventDto>? events;
  final bool isLoading;

  EventListState({this.events, this.isLoading = false});

  EventListState copyWith({List<EventDto>? events, bool? isLoading}) {
    return EventListState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EventListNotifier extends StateNotifier<EventListState> {
  EventListNotifier() : super(EventListState());

  void setEvents(List<EventDto> events) {
    state = state.copyWith(events: events, isLoading: false);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void clear() {
    state = EventListState();
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, EventListState>((ref) {
      return EventListNotifier();
    });
