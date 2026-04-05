import 'package:fiestapp/feature/event/data/dto/event_dto.dart';
import 'package:fiestapp/feature/event/data/dto/parking_dto.dart';
import 'package:fiestapp/feature/event/data/dto/prunes_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailsState {
  final EventDto? event;
  final PrunesDto? prunes;
  final List<ParkingDto> parkings;
  final bool isLoading;

  EventDetailsState({
    this.event,
    this.prunes,
    this.parkings = const [],
    this.isLoading = false,
  });

  EventDetailsState copyWith({
    EventDto? event,
    PrunesDto? prunes,
    List<ParkingDto>? parkings,
    bool? isLoading,
  }) {
    return EventDetailsState(
      event: event ?? this.event,
      prunes: prunes ?? this.prunes,
      parkings: parkings ?? this.parkings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EventDetailsNotifier extends StateNotifier<EventDetailsState> {
  EventDetailsNotifier() : super(EventDetailsState());

  void setEvent(EventDto event) {
    state = state.copyWith(event: event, isLoading: false);
  }

  void setPrunes(PrunesDto prunes) {
    state = state.copyWith(prunes: prunes, isLoading: false);
  }

  void setParkings(List<ParkingDto> parkings) {
    state = state.copyWith(parkings: parkings);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void clear() {
    state = EventDetailsState();
  }
}

final eventDetailsProvider =
    StateNotifierProvider<EventDetailsNotifier, EventDetailsState>((ref) {
      return EventDetailsNotifier();
    });
