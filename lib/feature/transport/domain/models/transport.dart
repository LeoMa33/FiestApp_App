import 'package:fiestapp/feature/event/domain/models/event.dart';
import 'package:fiestapp/feature/user/domain/models/user.dart';

class Ride {
  final String guid;
  final Event event;
  final User driver;
  final User passenger;

  Ride({
    required this.guid,
    required this.event,
    required this.driver,
    required this.passenger,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      guid: json['id'] as String,
      event: Event.fromJson(json['event']),
      driver: User.fromJson(json['driver']),
      passenger: User.fromJson(json['passenger']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': guid,
      'event': event.toJson(),
      'driver': driver.toJson(),
      'passenger': passenger.toJson(),
    };
  }
}
