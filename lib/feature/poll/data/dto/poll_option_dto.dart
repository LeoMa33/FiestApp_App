import 'package:fiestapp/feature/user/data/dto/user_light_dto.dart';

class PollOptionDto {
  final String id;
  final String value;
  final List<UserLightDto> votes;

  PollOptionDto({required this.id, required this.value, required this.votes});

  factory PollOptionDto.fromJson(Map<String, dynamic> json) {
    return PollOptionDto(
      id: json['id'] as String,
      value: json['value'] as String,
      votes: (json['votes'] as List? ?? [])
          .map((user) => UserLightDto.fromJson(user as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'votes': votes.map((user) => user.toJson()).toList(),
    };
  }

  int get voteCount => votes.length;
}
