import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class EventLightDto {
  final String id;
  final String name;
  final DateTime date;
  final String address;
  final String? imageUrl;
  final UserLightDto creator;
  final List<UserLightDto> participants;
  final EstimationDto estimation;

  EventLightDto({
    required this.id,
    required this.name,
    required this.date,
    required this.address,
    this.imageUrl,
    required this.creator,
    required this.participants,
    required this.estimation,
  });

  factory EventLightDto.fromJson(Map<String, dynamic> json) {
    return EventLightDto(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      address: json['address'] as String,
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
      'date': date.toIso8601String(),
      'address': address,
      'imageUrl': imageUrl,
      'creator': creator.toJson(),
      'participants': participants.map((e) => e.toJson()).toList(),
      'estimation': estimation.toJson(),
    };
  }
}
