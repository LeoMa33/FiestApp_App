import 'package:fiestapp/feature/event/data/dto/location_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class TransportDto {
  final String id;
  final UserLightDto driver;
  final int count;
  final String address;
  final LocationDto location;
  final List<UserLightDto> passengers;
  final String eventId;

  TransportDto({
    required this.id,
    required this.driver,
    required this.count,
    required this.address,
    required this.location,
    required this.passengers,
    required this.eventId,
  });

  factory TransportDto.fromJson(Map<String, dynamic> json) {
    return TransportDto(
      id: json['id'] as String,
      driver: UserLightDto.fromJson(json['driver'] as Map<String, dynamic>),
      count: (json['count'] as num).toInt(),
      address: json['address'] as String,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      passengers: (json['passengers'] as List)
          .map((p) => UserLightDto.fromJson(p as Map<String, dynamic>))
          .toList(),
      eventId: json['eventId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver.toJson(),
      'count': count,
      'address': address,
      'location': location.toJson(),
      'passengers': passengers.map((p) => p.toJson()).toList(),
      'eventId': eventId,
    };
  }

  int get availableSeats => count - passengers.length;
  bool get isFull => passengers.length >= count;
}
