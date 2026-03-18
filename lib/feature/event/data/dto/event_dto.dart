import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/event/data/dto/location_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class EventDto {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String address;
  final LocationDto location;
  final String? imageUrl;
  final UserLightDto creator;
  final List<UserLightDto> participants;
  final EstimationDto estimation;

  EventDto({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.address,
    required this.location,
    this.imageUrl,
    required this.creator,
    required this.participants,
    required this.estimation,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      address: json['address'] as String,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
      creator: UserLightDto.fromJson(json['creator'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => UserLightDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      estimation: EstimationDto.fromJson(
        json['estimation'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'address': address,
      'location': location.toJson(),
      'imageUrl': imageUrl,
      'creator': creator.toJson(),
      'participants': participants.map((e) => e.toJson()).toList(),
      'estimation': estimation.toJson(),
    };
  }
}
