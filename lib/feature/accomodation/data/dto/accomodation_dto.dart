import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class AccommodationDto {
  final String id;
  final UserLightDto host;
  final int count;
  final String? address;
  final List<UserLightDto> guests;
  final String eventId;

  AccommodationDto({
    required this.id,
    required this.host,
    required this.count,
    this.address,
    required this.guests,
    required this.eventId,
  });

  factory AccommodationDto.fromJson(Map<String, dynamic> json) {
    return AccommodationDto(
      id: json['id'] as String,
      host: UserLightDto.fromJson(json['host'] as Map<String, dynamic>),
      count: (json['count'] as num).toInt(),
      address: json['address'] as String?,
      guests:
          (json['guests'] as List<dynamic>?)
              ?.map((g) => UserLightDto.fromJson(g as Map<String, dynamic>))
              .toList() ??
          [],
      eventId: json['eventId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host.toJson(),
      'count': count,
      'address': address,
      'guests': guests.map((g) => g.toJson()).toList(),
      'eventId': eventId,
    };
  }
}
