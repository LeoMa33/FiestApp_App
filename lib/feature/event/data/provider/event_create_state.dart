import 'package:fiestapp/feature/event/data/dto/event_create_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCreateState {
  final String name;
  final String description;
  final DateTime? date;
  final TimeOfDay? time;
  final String street;
  final String city;
  final String postalCode;
  final bool isLoading;

  EventCreateState({
    this.name = '',
    this.description = '',
    this.date,
    this.time,
    this.street = '',
    this.city = '',
    this.postalCode = '',
    this.isLoading = false,
  });

  EventCreateState copyWith({
    String? name,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    String? street,
    String? city,
    String? postalCode,
    bool? isLoading,
  }) {
    return EventCreateState(
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      street: street ?? this.street,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isValid =>
      name.isNotEmpty &&
      date != null &&
      time != null &&
      street.isNotEmpty &&
      city.isNotEmpty &&
      postalCode.isNotEmpty;

  EventCreateDto toDto() {
    final combinedDateTime = DateTime(
      date!.year,
      date!.month,
      date!.day,
      time!.hour,
      time!.minute,
    );

    return EventCreateDto(
      name: name,
      description: description,
      date: combinedDateTime,
      address: '$street, $postalCode $city',
    );
  }
}

class EventCreateNotifier extends StateNotifier<EventCreateState> {
  EventCreateNotifier() : super(EventCreateState());

  void updateName(String name) => state = state.copyWith(name: name);
  void updateDescription(String description) =>
      state = state.copyWith(description: description);
  void updateDate(DateTime date) => state = state.copyWith(date: date);
  void updateTime(TimeOfDay time) => state = state.copyWith(time: time);
  void updateStreet(String street) => state = state.copyWith(street: street);
  void updateCity(String city) => state = state.copyWith(city: city);
  void updatePostalCode(String postalCode) =>
      state = state.copyWith(postalCode: postalCode);
  void setLoading(bool isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  void reset() => state = EventCreateState();
}

final eventCreateProvider =
    StateNotifierProvider<EventCreateNotifier, EventCreateState>((ref) {
      return EventCreateNotifier();
    });
